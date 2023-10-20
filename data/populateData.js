// data/populateData.js

const dynamoDb = require("../db/index");
const { ListObjectsCommand } = require("@aws-sdk/client-s3");
const { BatchWriteItemCommand } = require("@aws-sdk/client-dynamodb");
const { S3Client } = require("@aws-sdk/client-s3");
const products = require("./initialData.json");

const tableName = "ecom-app-products-table";
const s3Client = new S3Client({ region: "us-east-1" });
const bucketName = "ecom-app-products-s3-bucket";

// Utility function to break an array into chunks of a specified size
const chunk = (array, size) => {
  return Array.from({ length: Math.ceil(array.length / size) }, (v, i) =>
    array.slice(i * size, i * size + size)
  );
};

// Function to retrieve image URLs from S3 bucket based on object keys
const getS3ImageUrls = async () => {
  const command = new ListObjectsCommand({ Bucket: bucketName });
  const data = await s3Client.send(command);

  const urls = {};
  data.Contents.forEach((content) => {
    const productName = content.Key.split(".")[0];
    urls[productName] = `https://${bucketName}.s3.amazonaws.com/${content.Key}`;
  });

  return urls;
};

// Main function to populate product data in DynamoDB
const populateData = async () => {
  const s3ImageUrls = await getS3ImageUrls(); // Fetch the image URLs from S3

  // Associate each product with its respective image URL
  const productsWithUrls = products.map((product) => ({
    ...product,
    imageUrl: s3ImageUrls[product.name] || null,
  }));
  // Log warnings for products without associated images
  productsWithUrls.forEach((product) => {
    if (!product.imageUrl) {
      console.warn(`Image URL not found for product: ${product.name}`);
    }
  });

  // Convert the product data into the format required for a DynamoDB batch write
  const writeRequests = productsWithUrls.map((product) => ({
    PutRequest: {
      Item: {
        productId: { S: product.productId },
        name: { S: product.name },
        price: { N: product.price.toString() },
        description: { S: product.description },
        imageUrl: { S: product.imageUrl || "default-image-url" },
      },
    },
  }));

  // Split the write requests into batches (DynamoDB batch write has a max limit of 25 items)
  const chunks = chunk(writeRequests, 25);
  // Process each batch of write requests
  for (let batch of chunks) {
    const params = {
      RequestItems: {
        [tableName]: batch,
      },
    };

    // Log each batch before sending to DynamoDB
    console.log("Batch data to be sent to DynamoDB:", JSON.stringify(params));
    const command = new BatchWriteItemCommand(params);
    try {
      await dynamoDb.send(command);
      console.log("Batch populated successfully");
    } catch (error) {
      console.error("Error populating batch:", error);
      throw error;
    }
  }
};

populateData().catch((error) => {
  console.error("Error occurred while populating data:", error);
  process.exit(1);
});
