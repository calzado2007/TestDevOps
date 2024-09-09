const AWS = require('aws-sdk');
const apiGateway = new AWS.APIGateway({
  region: 'us-east-1',
  accessKeyId: 'TU_ACCESS_KEY_ID',
  secretAccessKey: 'TU_SECRET_ACCESS_KEY',
});

const params = {
  restApiId: 'TU_API_ID',
  stageName: 'TU_STAGE_NAME',
  httpMethod: 'GET',
  resourceId: 'TU_RESOURCE_ID',
};

apiGateway.client.get(params, (err, data) => {
  if (err) {
    console.log(err);
  } else {
    console.log(data);
  }
});
