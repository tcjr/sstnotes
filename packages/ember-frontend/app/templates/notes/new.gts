import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { on } from '@ember/modifier';
import Form from 'ember-bootstrap/components/bs-form';
import { service } from '@ember/service';
import type RouterService from '@ember/routing/router-service';
import { onError } from 'ember-frontend/utils/error';
import config from 'ember-frontend/config/environment';
import { NoteType } from 'ember-frontend/models/note';
import { API } from 'aws-amplify';
import { s3Upload } from 'ember-frontend/utils/aws';
import { pageTitle } from 'ember-page-title';
import './new.css';

function createNote(note: NoteType) {
  return API.post('notes', '/notes', { body: note });
}

class NotesNewComponent extends Component {
  @service declare router: RouterService;
  @tracked content = '';
  @tracked isSubmitting = false;
  @tracked file = null;

  handleFileChange = (Event) => {
    if (event.currentTarget.files === null) {
      return;
    }
    this.file = event.currentTarget.files[0];
  };

  handleSubmit = async () => {
    const { content, file } = this;
    console.log('content:', content);
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
      const attachment = file ? await s3Upload(file) : undefined;

      await createNote({ content, attachment });

      this.router.transitionTo('index');
    } catch (error) {
      onError(error);
    } finally {
      this.isSubmitting = false;
    }
  };

  get isSubmitDisabled() {
    return this.isSubmitting || !this.content?.length;
  }

  <template>
    {{pageTitle 'New Note'}}
    <div class='NewNote'>
      <Form @model={{this}} @onSubmit={{this.handleSubmit}} as |form|>
        <div class='d-grid gap-2'>

          <form.element
            @controlType='textarea'
            @label='Note'
            @property='content'
          />

          <form.element @label='Attachment' as |el|>
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
            @defaultText='Create'
            @pendingText='Creating...'
            @fulfilledText='Created'
            disabled={{this.isSubmitDisabled}}
          />
        </div>
      </Form>
    </div>
  </template>
}

export default RouteTemplate(NotesNewComponent);
