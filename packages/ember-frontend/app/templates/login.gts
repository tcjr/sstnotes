import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Form from 'ember-bootstrap/components/bs-form';
import { Auth } from 'aws-amplify';
import { service } from '@ember/service';
import type SessionService from 'ember-frontend/services/session';
import type RouterService from '@ember/routing/router-service';
import { pageTitle } from 'ember-page-title';
import './login.css';

class LoginComponent extends Component {
  @service declare session: SessionService;
  @service declare router: RouterService;
  @tracked email = '';
  @tracked password = '';
  @tracked isSubmitting = false;

  get isVaidForm() {
    return this.email.length > 0 && this.password.length > 0;
  }

  get isSubmitDisabled() {
    return !this.isVaidForm || this.isSubmitting;
  }

  handleSubmit = async () => {
    const { email, password } = this;
    console.log(`Email: ${email}, Password: ${password}`);
    this.isSubmitting = true;
    try {
      await Auth.signIn(email, password);
      // alert('Logged in');
      this.session.isAuthenticated = true;
      this.router.transitionTo('index');
    } catch (error) {
      // Prints the full error
      console.error(error);
      if (error instanceof Error) {
        alert(error.message);
      } else {
        alert(String(error));
      }
    } finally {
      this.isSubmitting = false;
    }
  };

  <template>
    {{pageTitle 'Login'}}
    <div class='Login'>
      <Form @model={{this}} @onSubmit={{this.handleSubmit}} as |form|>

        <div class='d-grid gap-2'>
          <form.element
            @controlType='email'
            @label='Email'
            @placeholder='Email'
            @property='email'
          />
          <form.element
            @controlType='password'
            @label='Password'
            @placeholder='Password'
            @property='password'
          />

          <form.submitButton
            @size='lg'
            class='btn-block'
            @defaultText='Login'
            @pendingText='Logging in...'
            @fulfilledText='Logged in'
            disabled={{this.isSubmitDisabled}}
          />
        </div>
      </Form>
    </div>
  </template>
}

export default RouteTemplate(LoginComponent);
