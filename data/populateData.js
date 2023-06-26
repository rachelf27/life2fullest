const dynamoDb = require("../db/index");
const products = require("./initialData.json");

const tableName = "ecom-app-products-table";

const populateData = async () => {
  const writeRequests = products.map((product) => ({
    PutRequest: {
      Item: {
        productId: product.productId,
        name: product.name,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
      },
    },
  }));

  const params = {
    RequestItems: {
      [tableName]: writeRequests,
    },
  };

  try {
    await dynamoDb.batchWrite(params).promise();
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
