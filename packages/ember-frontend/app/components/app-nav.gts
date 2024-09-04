import Component from '@glimmer/component';
import { service } from '@ember/service';
import type SessionService from 'ember-frontend/services/session';
import BsNavbar from 'ember-bootstrap/components/bs-navbar';
import BsButton from 'ember-bootstrap/components/bs-button';
import { LinkTo } from '@ember/routing';
import type RouterService from '@ember/routing/router-service';

interface AppNavSignature {}

export default class AppNav extends Component<AppNavSignature> {
  @service declare session: SessionService;
  @service declare router: RouterService;

  logout = () => {
    this.session.logout();
    this.router.transitionTo('login');
  };

  <template>
    <BsNavbar
      @collapseOnSelect={{true}}
      @bg='light'
      @expand='md'
      class='mb-3 px-3'
      as |navbar|
    >
      <div class='navbar-header'>
        <navbar.toggle />
        <LinkTo
          @route='index'
          class='navbar-brand fw-bold text-muted'
        >Scratch</LinkTo>
      </div>
      <navbar.content class='justify-content-end'>
        <navbar.nav as |nav|>
          {{#if this.session.isAuthenticated}}
            <nav.item>
              {{! TODO: see if ember-bootstrap has a non-routable version of nav.linkTo }}
              <BsButton @type='light' @onClick={{this.logout}}>Logout</BsButton>
            </nav.item>
          {{else}}
            <nav.item>
              <nav.linkTo @route='signup'>Signup</nav.linkTo>
            </nav.item>
            <nav.item>
              <nav.linkTo @route='login'>Login</nav.linkTo>
            </nav.item>
          {{/if}}
        </navbar.nav>
      </navbar.content>
    </BsNavbar>
  </template>
}

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry {
    AppNav: typeof AppNav;
    'app-nav': typeof AppNav;
  }
}
