const dynamoDb = require("./index");
const { S3Client, ListObjectsV2Command } = require("@aws-sdk/client-s3");

const bucketName = "ecom-app-products-s3-bucket";
const jsonFilePath = "../data/initialData.json";

// Get S3 objects from the bucket and store the URLs in DynamoDB
const storeS3Urls = async (bucketName) => {
  const s3 = new S3Client({ region: "us-east-1" });
  const command = new ListObjectsV2Command({ Bucket: bucketName });
  const objects = await s3.send(command)
  const urls = objects.Contents.map((object) => ({
    url: `https://${bucketName}.s3.amazonaws.com/${object.Key}`,
    productId: object.Key, // Assuming the S3 object Key can be used as the productId
  }));

  // Read the JSON file and parse its contents
  const fs = require("fs");
  const data = fs.readFileSync(jsonFilePath, "utf8");
  const products = JSON.parse(data);

  // Add the S3 URLs to the product objects
  products.forEach((product) => {
    const matchingUrl = urls.find((url) => url.productId === product.productId);
    if (matchingUrl) {
      product.imageUrl = matchingUrl.url;
    }
  });

  // Write the updated JSON file
  const updatedData = JSON.stringify(products, null, 2);
  fs.writeFileSync(jsonFilePath, updatedData, "utf8");

  console.log(`S3 URLs added to ${jsonFilePath}`);
};

// Call the function to add S3 URLs into the JSON file
storeS3Urls(bucketName, jsonFilePath).catch((error) =>
  console.error("Error occurred while storing S3 URLs:", error)
);

// Insert items to Product Table
const putItem = async (params, errorMessage) => {
  try {
    return await dynamoDb.put(params).promise();
  } catch (error) {
    console.error(`${errorMessage}: ${error}`);
    throw error;
  }
};

// Get items from Product Table
const getItem = async (params, errorMessage) => {
  try {
    return await dynamoDb.get(params).promise();
  } catch (error) {
    console.error(`${errorMessage}: ${error}`);
    throw error;
  }
};

// Delete items from Product Table                                                                                                                                                                                                                                                                                                                                                                                     s
const deleteItem = async (params, errorMessage) => {
  try {
    return await dynamoDb.delete(params).promise();
  } catch (error) {
    console.error(`${errorMessage}: ${error}`);
    throw error;
  }
};

// Update items in Product Table
const updateItem = async (params, errorMessage) => {
  try {
    return await dynamoDb.update(params).promise();
  } catch (error) {
    console.error(`${errorMessage}: ${error}`);
    throw error;
  }
};

// Query a specific item in Product Table
const queryItem = async (params, errorMessage) => {
  try {
    return await dynamoDb.query(params).promise();
  } catch (error) {
    console.error(`${errorMessage}: ${error}`);
    throw error;
  }
};

// Scan all products in Products Table
const scanItems = async (params, errorMessage) => {
  try {
    return await dynamoDb.scan(params).promise();
  } catch (error) {
    console.error(`${errorMessage}: ${error}`);
    throw error;
  }
};

module.exports = {
  putItem,
  getItem,
  deleteItem,
  updateItem,
  queryItem,
  scanItems,
  storeS3Urls,
};
