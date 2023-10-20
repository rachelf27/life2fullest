module.exports = {
  // DynamoDB table name
  aws_table_name: "ecom-app-products-table",

  // Local DynamoDB configuration for development
  aws_local_config: {
    region: "local",
    endpoint: "http://localhost:8000",
  },

  // AWS remote service configuration
  aws_remote_config: {
    accessKeyId: process.env.AWS_ACCESS_KEY, // AWS Access Key
    secretAccessKey: process.env.AWS_SECRET_KEY, // AWS Secret Key
    region: "us-east-1", // AWS region
  },
};
