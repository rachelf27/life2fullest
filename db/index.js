//const AWS = require('aws-sdk');
//const dynamoDb = new AWS.DynamoDB.DocumentClient();

// New AWS SDK v3
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient } = require("@aws-sdk/lib-dynamodb");
const dynamoDb = DynamoDBDocumentClient.from(new DynamoDBClient({ region: "us-east-1" }));

const config = require('../config/config');
AWS.config.update(config.aws_remote_config);
module.exports = dynamoDb;