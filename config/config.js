module.exports = {
    aws_table_name: 'tf_products_table',
    aws_local_config: {
        region: 'local',
        endpoint: 'http://localhost:8000'
    },
    aws_remote_config: {
        accessKeyId: 'ACCESS_KEY_ID',
        secret_AccessKey: 'SECRET_ACCESS_KEY',
        region: 'us-east-1'
    }
};