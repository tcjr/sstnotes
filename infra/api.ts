import { secret, table } from './storage';

// Create the API
export const api = new sst.aws.ApiGatewayV2('Api', {
  cors: true,
  transform: {
    route: {
      handler: {
        // makes the table and stripe secret available to all our routes
        link: [table, secret],
      },
      args: {
        // tells our API that we want to use AWS_IAM across all our routes
        auth: { iam: true },
      },
    },
  },
});

api.route('GET /info', 'packages/functions/src/info.main');

api.route('GET /notes', 'packages/functions/src/list.main');

api.route('POST /notes', 'packages/functions/src/create.main');
api.route('GET /notes/{id}', 'packages/functions/src/get.main');
api.route('PUT /notes/{id}', 'packages/functions/src/update.main');
api.route('DELETE /notes/{id}', 'packages/functions/src/delete.main');

api.route('POST /billing', 'packages/functions/src/billing.main');
