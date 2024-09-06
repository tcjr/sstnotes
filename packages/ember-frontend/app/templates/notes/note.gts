import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import { NoteType } from 'ember-frontend/models/note';
import { onError } from 'ember-frontend/utils/error';
import BsButton from 'ember-bootstrap/components/bs-button';
import Form from 'ember-bootstrap/components/bs-form';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';
import { API } from 'aws-amplify';
import { s3Upload } from 'ember-frontend/utils/aws';
import config from 'ember-frontend/config/environment';
import './note.css';

function formatFilename(str: string) {
  return str.replace(/^\w+-/, '');
}

function saveNote(id: string, note: NoteType) {
  return API.put('notes', `/notes/${id}`, { body: note });
}

function deleteNote(id: string) {
  return API.del('notes', `/notes/${id}`, {});
}

interface NotesNoteComponentSignature {
  Args: {
    model: {
      note: NoteType;
    };
  };
}

class NotesNoteComponent extends Component<NotesNoteComponentSignature> {
  @service declare router: RouterService;
  // represents a new file to upload
  @tracked file = null;
  @tracked isSubmitting = false;
  @tracked isDeleting = false;

  get note(): NoteType {
    return this.args.model.note;
  }

  handleFileChange = (Event) => {
    if (event.currentTarget.files === null) {
      return;
    }
    this.file = event.currentTarget.files[0];
  };

  handleSubmit = async () => {
    const file = this.file;
    let attachment = undefined;

    console.log('file:', file);
    if (file && file.size > config.MAX_ATTACHMENT_SIZE) {
      alert(
        `Please pick a file smaller than ${
          config.MAX_ATTACHMENT_SIZE / 1000000
        } MB.`,
      );
      return;
    }
    this.isSubmitting = true;

    try {
      console.log('this.note:', this.note);

      if (file) {
        attachment = await s3Upload(file);
      } else if (this.note && this.note.attachment) {
        attachment = this.note.attachment;
      }

      // Using a new object, but could probably use this.note directly
      await saveNote(this.note.noteId, {
        content: this.note.content,
        attachment,
      });

      this.router.transitionTo('index');
    } catch (error) {
      onError(error);
      this.isSubmitting = false;
    } finally {
      // this.isSubmitting = false;
    }
  };

  handleDelete = async () => {
    const confirmed = confirm('Are you sure you want to delete this note?');

    if (!confirmed) {
      return;
    }

    this.isDeleting = true;

    try {
      await deleteNote(this.note.noteId);

      this.router.transitionTo('index');
    } catch (e) {
      onError(e);
      this.isDeleting = false;
    }
  };

  get areButtonsDisabled() {
    return this.isSubmitting || this.isDeleting || !this.note.content?.length;
  }

  <template>
    <div class='Notes'>
      {{#if this.note}}
        <Form @model={{this.note}} @onSubmit={{this.handleSubmit}} as |form|>
          <div class='d-grid gap-2'>
            <form.element
              @controlType='textarea'
              @label='Note'
              @property='content'
            />

            <form.element @label='Attachment' as |el|>
              {{#if this.note.attachment}}
                <p>
                  <a
                    target='_blank'
                    rel='noopener noreferrer'
                    href={{this.note.attachmentURL}}
                  >
                    {{formatFilename this.note.attachment}}
                  </a>
                </p>
              {{/if}}

              {{! Uncontrolled file input }}
              <input
                class='form-control'
                type='file'
                {{on 'change' this.handleFileChange}}
              />
            </form.element>

            <form.submitButton
              @size='lg'
              class='btn-block'
              @defaultText='Save'
              @pendingText='Saving...'
              @fulfilledText='Saved'
              disabled={{this.areButtonsDisabled}}
            />

            <BsButton
              @size='lg'
              class='btn-block btn-danger'
              @onClick={{this.handleDelete}}
              @defaultText='Delete'
              @pendingText='Deleting...'
              @fulfilledText='Deleted'
              disabled={{this.areButtonsDisabled}}
            />

          </div>

        </Form>
      {{else}}
        <p>No note</p>
      {{/if}}
    </div>
  </template>
}

export default RouteTemplate(NotesNoteComponent);
