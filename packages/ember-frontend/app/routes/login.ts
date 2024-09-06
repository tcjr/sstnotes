import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type SessionService from 'ember-frontend/services/session';
import type RouterService from '@ember/routing/router-service';

export default class LoginRoute extends Route {
  @service declare session: SessionService;
  @service declare router: RouterService;

  // we want to redirect to the index route if the user is already authenticated
  beforeModel() {
    if (this.session.isAuthenticated) {
      this.router.transitionTo('index');
    }
  }
}
