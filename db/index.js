// db/index.js

const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const config = require('../config/config');
const dynamoDb = new DynamoDBClient(config.aws_remote_config);

module.exports = dynamoDb;