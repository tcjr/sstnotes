import { Resource } from 'sst';
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { Entity } from 'electrodb';

const client = new DynamoDBClient({});
const tableName = Resource.DynamoData.name;

export const Note = new Entity(
  {
    model: {
      entity: 'note',
      version: '1',
      service: 'store',
    },
    attributes: {
      noteId: { type: 'string' },
      userId: { type: 'string' },
      content: { type: 'string' },
      attachment: { type: 'string' },
      createdAt: { type: 'string' }, // date type?
    },
    indexes: {
      byAuthor: {
        pk: {
          field: 'pk',
          composite: ['userId'],
        },
        sk: {
          field: 'sk',
          composite: ['noteId'],
        },
      },
    },
  },
  { client, table: tableName }
);
