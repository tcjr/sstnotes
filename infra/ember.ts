import { api } from './api';
import { bucket } from './storage';
import { userPool, identityPool, userPoolClient } from './auth';

const region = aws.getRegionOutput().name;

let siteDomain = undefined;
if ($app.stage === 'production') {
  // The ARN is here: https://us-east-1.console.aws.amazon.com/acm/home?region=us-east-1#/certificates/list
  const arn = new sst.Secret('EmberWebSecretARN');
  siteDomain = {
    dns: false,
    name: 'ember-notes.tcjr.org',
    cert: arn.value,
  };
}

export const reactFrontend = new sst.aws.StaticSite('EmberFrontend', {
  path: 'packages/ember-frontend',
  build: {
    output: 'dist',
    command: 'npm run build',
  },
  dev: {
    command: 'npm run start',
  },
  domain: siteDomain,
  environment: {
    VITE_REGION: region,
    VITE_API_URL: api.url,
    VITE_BUCKET: bucket.name,
    VITE_USER_POOL_ID: userPool.id,
    VITE_IDENTITY_POOL_ID: identityPool.id,
    VITE_USER_POOL_CLIENT_ID: userPoolClient.id,
  },
});
