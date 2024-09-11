import { Util } from '@sstnotes/core/util';
import { Note } from './db-access';

export const main = Util.handler(async (event) => {
  const currentUserId =
    event.requestContext.authorizer?.iam.cognitoIdentity.identityId;

  if (!event?.pathParameters?.id) {
    throw new Error('Missing path parameters');
  }

  const resp = await Note.get({
    userId: currentUserId,
    noteId: event?.pathParameters?.id, // The id of the note from the path
  }).go();

  if (!resp.data) {
    throw new Error('Item not found.');
  }

  // Return the retrieved item
  return JSON.stringify(resp.data);
});
