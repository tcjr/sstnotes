'use strict';

module.exports = function (environment) {
  const ENV = {
    modulePrefix: 'ember-frontend',
    environment,
    rootURL: '/',
    locationType: 'history',
    EmberENV: {
      EXTEND_PROTOTYPES: false,
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. EMBER_NATIVE_DECORATOR_SUPPORT: true
      },
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    },

    // The following config is roughly equivalent to the React app's config in the
    // file "packages/react-frontend/src/config.js".
    // We're not using VITE yet in the Ember app, but we're using the same
    // names here as the React app to keep things consistent.

    // Frontend config
    MAX_ATTACHMENT_SIZE: 5000000,
    STRIPE_KEY:
      'pk_test_51PqeokP1u1ZH3i6mHeTnhWJEHEv2YtS9NLbAd6i52H4p9mlm63ScPJcd2bDb3bZnQdFO3y01VeyqHmsWwApwXqtP00eRmWcca3',

    // Backend config
    s3: {
      REGION: process.env.VITE_REGION,
      BUCKET: process.env.VITE_BUCKET,
    },
    apiGateway: {
      REGION: process.env.VITE_REGION,
      URL: process.env.VITE_API_URL,
    },
    cognito: {
      REGION: process.env.VITE_REGION,
      USER_POOL_ID: process.env.VITE_USER_POOL_ID,
      APP_CLIENT_ID: process.env.VITE_USER_POOL_CLIENT_ID,
      IDENTITY_POOL_ID: process.env.VITE_IDENTITY_POOL_ID,
    },
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
    ENV.APP.autoboot = false;
  }

  if (environment === 'production') {
    // here you can enable a production-specific feature
  }

  return ENV;
};
