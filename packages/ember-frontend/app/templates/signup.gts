import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Form from 'ember-bootstrap/components/bs-form';
import { service } from '@ember/service';
import type SessionService from 'ember-frontend/services/session';
import type RouterService from '@ember/routing/router-service';
import './signup.css';

const sleep = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));

interface SignupFormSignature {
  Args: {
    data: SignupComponent; // probably need better types here
    onSignupSubmit: () => Promise<void>;
  };
  Element: HTMLDivElement;
}

const SignupForm = class extends Component<SignupFormSignature> {
  <template>
    <div ...attributes>
      <Form @model={{@data}} @onSubmit={{@onSignupSubmit}} as |form|>

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
          <form.element
            @controlType='password'
            @label='Confirm Password'
            @placeholder='Confirm Password'
            @property='confirmPassword'
          />

          <form.submitButton
            @size='lg'
            class='btn-block'
            @defaultText='Signup'
            @pendingText='Signing up...'
            @fulfilledText='Signed up'
          />
        </div>
      </Form>
    </div>
  </template>
};

interface ConfirmationFormSignature {
  Args: {
    data: SignupComponent; // probably need better types here
    onConfirmationSubmit: () => Promise<void>;
  };
  Element: HTMLDivElement;
}

const ConfirmationForm = class extends Component<ConfirmationFormSignature> {
  <template>
    <div ...attributes>
      <Form @model={{@data}} @onSubmit={{@onConfirmationSubmit}} as |form|>

        <div class='d-grid gap-2'>
          <form.element
            @controlType='tel'
            @label='Confirmation Code'
            @placeholder='Confirmation Code'
            @property='confirmationCode'
          />

          <form.submitButton
            @size='lg'
            class='btn-block'
            @defaultText='Verify'
            @pendingText='Verifying...'
            @fulfilledText='Verified'
          />
        </div>
      </Form>
    </div>
  </template>
};

class SignupComponent extends Component {
  @tracked email = '';
  @tracked password = '';
  @tracked confirmPassword = '';
  @tracked newUser: string | null = null;
  @tracked confirmationCode = '';

  handleSignupSubmit = async () => {
    await sleep(2000);
    this.newUser = 'test';
  };

  handleConfirmationSubmit = async () => {
    await sleep(2000);
  };

  <template>
    <div class='Signup'>
      {{#if this.newUser}}
        <ConfirmationForm
          @data={{this}}
          @onConfirmationSubmit={{this.handleConfirmationSubmit}}
        />
      {{else}}
        <SignupForm
          @data={{this}}
          @onSignupSubmit={{this.handleSignupSubmit}}
        />
      {{/if}}
    </div>
  </template>
}

export default RouteTemplate(SignupComponent);
