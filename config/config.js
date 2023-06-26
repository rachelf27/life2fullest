module.exports = {
    aws_table_name: 'ecom-app-products-table',
    aws_local_config: {
        region: 'local',
        endpoint: 'http://localhost:8000'
    },
    aws_remote_config: {
        accessKeyId: process.env.AWS_ACCESS_KEY,
        secret_AccessKey: process.env.AWS_SECRET_KEY,
        region: 'us-east-1'
    }
};