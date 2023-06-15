const {
  putItem,
  getItem,
  deleteItem,
  updateItem,
  queryItem,
  scanItems,
  storeS3Urls,
} = require("./dynamoDbUtils");

// Add an item to the Product Table
const addProduct = async (productId, name, price, description, imageUrl) => {
  const params = {
    TableName: "ecom-app-products-table",
    Item: {
      productId: productId,
      name: name,
      price: price,
      description: description,
      imageUrl: imageUrl
    }
  };
  return putItem(params, "Error occurred while inserting an item from products");
};

// Get an item from the Product Table
const getProduct = async (productId) => {
  const params = {
    TableName: "ecom-app-products-table",
    Key: {
      productId: productId,
    },
  };
  return getItem(params, "Error occurred while getting an item from products");
};

// Delete an item from the Product Table
const deleteProduct = async (productId) => {
  const params = {
    TableName: "ecom-app-products-table",
    Key: {
      productId: productId,
    },
  };
  return deleteItem(params, "Error occurred while deleting an item from products");
};

// Update an item in the Product Table
const updateProduct = async (
  productId,
  updateExpression,
  expressionAttributeValues
) => {
  const params = {
    TableName: "ecom-app-products-table",
    Key: {
      productId: productId,
    },
    UpdateExpression: updateExpression,
    ExpressionAttributesValues: expressionAttributeValues,
    ReturnValues: "UPDATED_NEW",
  };
  return updateItem(params, "Error occurred while updating an item from products");
};

// Query an item from the Product Table
const queryProduct = async (productId) => {
  const params = {
    TableName: "ecom-app-products-table",
    Key: {
      productId: productId,
    },
  };
  return queryItem(params, "Error occurred while querying an item from products");
};

// Scan for all items in Product Table
const scanProducts = async () => {
  const params = {
    TableName: "ecom-app-products-table",
  };
  return scanItems(params, "Error occurred while scanning items");
};

module.exports = {
  addProduct,
  getProduct,
  deleteProduct,
  updateProduct,
  queryProduct,
  scanProducts,
};
