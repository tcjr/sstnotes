import { Resource } from 'sst';
import { Util } from '@sstnotes/core/util';

export const main = Util.handler(async (_event) => {
  // TODO: show the current bucket name
  // TODO: show the current authenticated user
  // TODO: show some table stats

  const result = {
    type: 'info',
    currentTimestamp: new Date().toISOString(),
  };

  return JSON.stringify(result);
});
