import { Util } from '@sstnotes/core/util';
import { Note } from './db-access';

export const main = Util.handler(async (event) => {
  const currentUserId =
    event.requestContext.authorizer?.iam.cognitoIdentity.identityId;

  console.log('making query with currentUserId:', currentUserId);
  const resp = await Note.query.byAuthor({ userId: currentUserId }).go();
  console.log('resp.data:', resp.data);

  return JSON.stringify(resp.data);
});
