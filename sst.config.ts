/// <reference path="./.sst/platform/config.d.ts" />

export default $config({
  app(input) {
    return {
      name: 'sstnotes',
      removal: input?.stage === 'production' ? 'retain' : 'remove',
      home: 'aws',
    };
  },

  async run() {
    await import('./infra/storage');
    await import('./infra/api');

    const auth = await import('./infra/auth');

    // The return values from here show up in the console output at the end of the deployment
    return {
      UserPool: auth.userPool.id,
      Region: aws.getRegionOutput().name,
      IdentityPool: auth.identityPool.id,
      UserPoolClient: auth.userPoolClient.id,
    };
  },
});
