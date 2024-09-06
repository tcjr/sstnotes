import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { service } from '@ember/service';
import type SessionService from 'ember-frontend/services/session';
import type { NoteType } from 'ember-frontend/models/note';
import { onError } from 'ember-frontend/utils/error';
import { API } from 'aws-amplify';
import { LinkTo } from '@ember/routing';
import './index.css';

function firstLine(str: string) {
  return str.trim().split('\n')[0];
}

function formatDate(str: undefined | string) {
  return !str ? '' : new Date(str).toLocaleString();
}

interface IndexRouteSignature {
  Args: {
    model: {
      notes: NoteType[];
    };
  };
}

class IndexComponent extends Component<IndexRouteSignature> {
  @service declare session: SessionService;

  get notes(): NoteType[] {
    return this.args.model.notes;
  }

  <template>
    <div class='Home'>
      {{#if this.session.isAuthenticated}}
        <div class='notes'>
          <h2 class='pb-3 mt-4 mb-3 border-bottom'>Your Notes</h2>
          <div class='list-group'>

            <LinkTo
              @route='notes.new'
              class='py-3 text-nowrap text-truncate list-group-item list-group-item-action'
            >
              <svg
                xmlns='http://www.w3.org/2000/svg'
                width='16'
                height='16'
                fill='currentColor'
                class='bi bi-pencil-square'
                viewBox='0 0 16 16'
              >
                <path
                  d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'
                />
                <path
                  fill-rule='evenodd'
                  d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'
                />
              </svg>
              <span class='ms-2 fw-bold'>Create a new note</span>
            </LinkTo>
            {{#each this.notes as |note|}}
              <LinkTo
                @route='notes.note'
                @model={{note.noteId}}
                class='text-nowrap text-truncate list-group-item list-group-item-action'
              >
                <span class='fw-bold'>
                  {{firstLine note.content}}</span>
                <br />
                <span class='text-muted'>
                  Created:
                  {{formatDate note.createdAt}}
                </span>
              </LinkTo>
            {{/each}}
          </div>
        </div>
      {{else}}
        <div class='lander'>
          <h1>Scratch</h1>
          <p class='text-muted'>A simple note taking app</p>
        </div>
      {{/if}}
    </div>
  </template>
}

export default RouteTemplate(IndexComponent);
