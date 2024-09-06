import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { onError } from 'ember-frontend/utils/error';
import { API } from 'aws-amplify';
import type { BillingType } from 'ember-frontend/models/billing';
import { loadStripe } from '@stripe/stripe-js';
import config from 'ember-frontend/config/environment';
import './settings.css';

const stripePromise = loadStripe(config.STRIPE_KEY);

function billUser(details: BillingType) {
  return API.post('notes', '/billing', {
    body: details,
  });
}

class SettingsComponent extends Component {
  @tracked isLoading = false;
  <template>
    <div class='Settings'>
      SETTINGS HERE
    </div>
  </template>
}

export default RouteTemplate(SettingsComponent);
