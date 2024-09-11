import { Util } from '@sstnotes/core/util';
import { Note } from './db-access';

export const main = Util.handler(async (event) => {
  const currentUserId =
    event.requestContext.authorizer?.iam.cognitoIdentity.identityId;

  if (!event?.pathParameters?.id) {
    throw new Error('Missing path parameters');
  }

  const data = JSON.parse(event.body || '{}');

  const resp = await Note.patch({
    userId: currentUserId,
    noteId: event?.pathParameters?.id, // The id of the note from the path
  })
    .set({
      content: data.content, // Parsed from request body
      attachment: data.attachment, // Parsed from request body
    })
    .go();

  // should we return the updated data instead?
  return JSON.stringify({ status: true });
});
