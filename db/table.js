const {
  putItem,
  getItem,
  deleteItem,
  updateItem,
  queryItem,
  scanItems,
} = require("./operations");

// add an item to the table
const addProduct = async (product) => {
  const params = {
    TableName: "tf_products_table",
    Item: product,
  };
  try {
    return await putItem(params);
  } catch (error) {
    console.error(`Error occurred while adding product: ${error}`);
    throw error;
  }
};

// get an item from the table
const getProduct = async (productId) => {
  const params = {
    TableName: "tf_products_table",
    Key: {
      productId: productId,
    },
  };
  try {
    return await getItem(params);
  } catch (error) {
    console.error(`Error occurred while getting an item from products: ${error}`);
    throw error;
  }
};

// delete an item from the table
const deleteProduct = async (productId) => {
  const params = {
    TableName: "tf_products_table",
    Key: {
      productId: productId,
    },
  };
  try {
    return await deleteItem(params);
  } catch (error) {
    console.error(`Error occurred while deleting a product: ${error}`);
    throw error;
  }
};

// update an item in the table
const updateProduct = async (productId, updateExpression, expressionAttributeValues) => {
  const params = {
    TableName: "tf_products_table",
    Key: {
      productId: productId,
    },
    UpdateExpression: updateExpression,
    ExpressionAttributesValues: expressionAttributeValues,
    ReturnValues: "UPDATED_NEW"
  };
  try {
    return await updateItem(params);
  } catch (error) {
    console.error(`Error occurred while updating a product: ${error}`);
    throw error;
  }
};

// query an item from the table
const queryProduct = async (productId) => {
  const params = {
    TableName: "tf_products_table",
    Key: {
      productId: productId,
    },
  };
  try {
    return await queryItem(params);
  } catch (error) {
    console.error(`Error occurred while querying a product: ${error}`);
    throw error;
  }
};

/* //scan an item from the table
const scanProduct = async (productId) => {
  const params = {
    TableName: "tf_products_table",
    Key: {
      productId: productId,
    },
  };
  try {
    return await scanItem(params);
  } catch (error) {
    console.error(`Error occurred while scanning product: ${error}`);
    throw error;
  }
}; */

const scanProducts = async () => {
  const params = {
    TableName: "tf_products_table"
    }
  try {
    return await scanItems();
  } catch (error) {
    console.error(`Error occurred while scanning products: ${error}`);
    throw error;
  }
};
module.exports = {
  addProduct,
  getProduct,
  deleteProduct,
  updateProduct,
  queryProduct,
  //scanProduct,
  scanProducts
};
