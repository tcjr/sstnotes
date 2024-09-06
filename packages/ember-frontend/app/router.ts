import EmberRouter from '@ember/routing/router';
import config from 'ember-frontend/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('login');
  this.route('signup');
  this.route('notes', function () {
    this.route('new');
    this.route('note', { path: '/:note_id' });
  });
  this.route('not-found', { path: '/*path' });
});
