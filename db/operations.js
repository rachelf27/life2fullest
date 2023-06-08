const dynamoDb = require("./index");

// dynamoDb.put product items
const putItem = async (params) => {
  try {
    return await dynamoDb.put(params).promise();
  } catch (error) {
    console.error(`Error occurred while putting item: ${error}`);
    throw error; // or handle error in a way that makes sense for your application
  }
};

// dynamoDb.get products
const getItem = async (params) => {
  try {
    return await dynamoDb.get(params).promise();
  } catch (error) {
    console.error(`Error occurred while retrieving item: ${error}`);
    throw error;
  }
};

// dynamoDb.delete product                                                                                                                                                                                                                                                                                                                                                                                     s
const deleteItem = async (params) => {
  try {
    return await dynamoDb.delete(params).promise();
  } catch (error) {
    console.error(`Error occurred while deleting item: ${error}`);
    throw error;
  }
};

// dynamoDb.update products
const updateItem = async (params) => {
  try {
    return await dynamoDb.update(params).promise();
  } catch (error) {
    console.error(`Error occurred while updating item: ${error}`);
    throw error;
  }
};

// dynamoDB.query to query items
const queryItem = async (params) => {
  try {
    return await dynamoDb.query(params).promise();
  } catch (error) {
    console.error(`Error occurred while querying item: ${error}`);
    throw error;
  }
};

/* // dynamoDb.scan a single products
const scanItem = async (params) => {
  try {
    return await dynamoDb.scan(params).promise();
  } catch (error) {
    console.error(`Error occurred while scanning for item: ${error}`);
    throw error;
  }
}; */

// dynamoDb.scan all products
const scanItems = async () => {
  try {
    return await dynamoDb.scan().promise();
  } catch (error) {
    console.error(`Error occurred while scanning for item: ${error}`);
    throw error;
  }
};

module.exports = {
  putItem,
  getItem,
  deleteItem,
  updateItem,
  queryItem,
  scanItems
};
