const dynamoDb = require("../db/index");
const { BatchWriteItemCommand } = require("@aws-sdk/client-dynamodb");
const products = require("./initialData.json");

const tableName = "ecom-app-products-table";

const populateData = async () => {
  const writeRequests = products.map((product) => ({
    PutRequest: {
      Item: {
        productId: { S:product.productId},
        name: { S: product.name},
        price: { N: product.price.toString()},
        description: {S: product.description},
        imageUrl: {S: product.imageUrl},
      },
    },
  }));

  const params = {
    RequestItems: {
      [tableName]: writeRequests,
    },
  };

  const command = new BatchWriteItemCommand(params);

  try {
    await dynamoDb.send(command);
    console.log("Data populated successfully");
  } catch (error) {
    console.error("Error populating data:", error);
    throw error;
  }
};

populateData().catch((error) => {
  console.error("Error occurred while populating data:", error);
  process.exit(1);
});
