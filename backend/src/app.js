const AWS = require('aws-sdk');
const CognitoIdentityServiceProvider = AWS.CognitoIdentityServiceProvider;
const AmazonCognitoIdentity = require('amazon-cognito-identity-js');
const poolData = {
  UserPoolId: 'us-east-1_123456789', // Reemplaza con el ID de tu grupo de usuarios
  ClientId: '1234567890abcdef', // Reemplaza con el ID de cliente de tu grupo de usuarios
};

const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

const authenticationData = {
  Username: 'tu_usuario', // Reemplaza con el nombre de usuario
  Password: 'tu_contraseña', // Reemplaza con la contraseña del usuario
};

const authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails(authenticationData);

const cognitoUser = new AmazonCognitoIdentity.CognitoUser({
  Username: authenticationData.Username,
  Pool: userPool,
});

cognitoUser.authenticateUser(authenticationDetails, {
  onSuccess: (result) => {
    console.log('Autenticación exitosa');
    console.log(result);
  },
  onFailure: (err) => {
    console.log('Error de autenticación');
    console.log(err);
  },
});

app.get('/api/hola', (req, res) => {
  const apiGateway = require('./apiGateway');
  apiGateway.client.get(params, (err, data) => {
    if (err) {
      res.status(500).send({ message: 'Error al obtener la respuesta' });
    } else {
      res.send(data);
    }
  });
});

const express = require('express');
const app = express();
const aws = require('aws-sdk');

const waf = new aws.WAF({
  region: 'us-east-1',
  accessKeyId: 'TU_ACCESS_KEY_ID',
  secretAccessKey: 'TU_SECRET_ACCESS_KEY',
});

const webACL = 'TU_WEB_ACL_ID';

app.use((req, res, next) => {
  const headers = req.headers;
  const method = req.method;
  const url = req.url;

  waf.getWebACL({
    WebACLId: webACL,
  }, (err, data) => {
    if (err) {
      console.log(err);
      res.status(500).send({ message: 'Error al obtener la Web ACL' });
    } else {
      const rules = data.WebACL.Rules;

      rules.forEach((rule) => {
        if (rule.Predicate.Type === 'SQLInjection') {
          const sqlInjectionRule = rule.Predicate;

          if (sqlInjectionRule.Value === 'SELECT * FROM users') {
            res.status(403).send({ message: 'Acceso denegado' });
          } else {
            next();
          }
        } else {
          next();
        }
      });
    }
  });
});

//app.listen(3000, () => {
//  console.log('Servidor escuchando en el puerto 3000');
//});

const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

app.get('/api/hola', (req, res) => {
  res.send('hola mundo');
});

app.listen(port, () => {
  console.log(`Servidor escuchando en el puerto ${port}`);
});
