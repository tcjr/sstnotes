import Route from '@ember/routing/route';
import type { NoteType } from 'ember-frontend/models/note';
import { API } from 'aws-amplify';
import { onError } from 'ember-frontend/utils/error';
import { service } from '@ember/service';
import type SessionService from 'ember-frontend/services/session';

export default class IndexRoute extends Route {
  @service declare session: SessionService;

  async model() {
    let allNotes: NoteType[] = [];
    // We let users see this page if they aren't authenticated, but we don't load any notes
    if (this.session.isAuthenticated) {
      try {
        allNotes = await API.get('notes', '/notes', {});
      } catch (error) {
        onError(error);
      }
    }
    return { notes: allNotes };
  }
}
