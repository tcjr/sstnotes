/* tslint:disable */
/* eslint-disable */
import "sst"
declare module "sst" {
  export interface Resource {
    "Api": {
      "type": "sst.aws.ApiGatewayV2"
      "url": string
    }
    "ApiSecretARN": {
      "type": "sst.sst.Secret"
      "value": string
    }
    "IdentityPool": {
      "id": string
      "type": "sst.aws.CognitoIdentityPool"
    }
    "Notes": {
      "name": string
      "type": "sst.aws.Dynamo"
    }
    "ReactFrontend": {
      "type": "sst.aws.StaticSite"
      "url": string
    }
    "ReactWebSecretARN": {
      "type": "sst.sst.Secret"
      "value": string
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
