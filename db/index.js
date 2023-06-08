const AWS = require('aws-sdk');
const config = require('../config/config');
AWS.config.update(config.aws_remote_config);
const dynamoDb = new AWS.DynamoDB.DocumentClient();
module.exports = dynamoDb;