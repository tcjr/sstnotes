import Route from '@ember/routing/route';
import type { NoteType } from 'ember-frontend/models/note';
import { API } from 'aws-amplify';
import { onError } from 'ember-frontend/utils/error';

export default class IndexRoute extends Route {
  async model() {
    let allNotes: NoteType[] = [];
    try {
      allNotes = await API.get('notes', '/notes', {});
    } catch (error) {
      onError(error);
    }
    return { notes: allNotes };
  }
}
