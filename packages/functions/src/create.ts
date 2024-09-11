import * as uuid from 'uuid';
import { Util } from '@sstnotes/core/util';
import { Note } from './db-access';

export const main = Util.handler(async (event) => {
  const currentUserId =
    event.requestContext.authorizer?.iam.cognitoIdentity.identityId;

  let data = {
    content: '',
    attachment: '',
  };

  if (event.body != null) {
    data = JSON.parse(event.body);
  }

  console.log('calling create with currentUserId:', currentUserId);
  const resp = await Note.create({
    userId: currentUserId,
    noteId: uuid.v1(), // A unique uuid
    content: data.content, // Parsed from request body
    attachment: data.attachment, // Parsed from request body
    createdAt: new Date().toISOString(),
  }).go();
  console.log('resp.data:', resp.data);

  return JSON.stringify(resp.data);
});
