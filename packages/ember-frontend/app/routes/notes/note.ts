import Route from '@ember/routing/route';
import type { NoteType } from 'ember-frontend/models/note';
import { API, Storage } from 'aws-amplify';
import { onError } from 'ember-frontend/utils/error';

interface NotesNoteRouteSignature {
  Args: {
    model: {
      note: NoteType;
    };
  };
}

export default class NotesNoteRoute extends Route<NotesNoteRouteSignature> {
  async model(params) {
    const { note_id } = params;
    let note: NoteType = {
      content: '',
    };
    try {
      console.log('loading note with id:', note_id);
      note = await API.get('notes', `/notes/${note_id}`, {});

      if (note.attachment) {
        console.log('loading attachment for:', note_id);
        note.attachmentURL = await Storage.vault.get(note.attachment);
      }
    } catch (error) {
      onError(error);
    }

    return { note };
  }
}
