/* tslint:disable */
/* eslint-disable */
import "sst"
declare module "sst" {
  export interface Resource {
    "Api": {
      "type": "sst.aws.ApiGatewayV2"
      "url": string
    }
    "DynamoData": {
      "name": string
      "type": "sst.aws.Dynamo"
    }
    "EmberFrontend": {
      "type": "sst.aws.StaticSite"
      "url": string
    }
    "IdentityPool": {
      "id": string
      "type": "sst.aws.CognitoIdentityPool"
    }
    "ReactFrontend": {
      "type": "sst.aws.StaticSite"
      "url": string
    }
    "StripeSecretKey": {
      "type": "sst.sst.Secret"
      "value": string
    }
    "Uploads": {
      "name": string
      "type": "sst.aws.Bucket"
    }
    "UserPool": {
      "id": string
      "type": "sst.aws.CognitoUserPool"
    }
    "UserPoolClient": {
      "id": string
      "secret": string
      "type": "sst.aws.CognitoUserPoolClient"
    }
  }
}
export {}
