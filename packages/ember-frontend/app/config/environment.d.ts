/**
 * Type declarations for
 *    import config from 'ember-frontend/config/environment'
 */
declare const config: {
  cognito: {
    REGION: string;
    USER_POOL_ID: string;
    APP_CLIENT_ID: string;
    IDENTITY_POOL_ID: string;
  };
  s3: {
    BUCKET: string;
    REGION: string;
  };
  apiGateway: {
    URL: string;
    REGION: string;
  };

  environment: string;
  modulePrefix: string;
  podModulePrefix: string;
  locationType: 'history' | 'hash' | 'none';
  rootURL: string;
  APP: Record<string, unknown>;
};

export default config;
