import Component from '@glimmer/component';
import config from 'ember-frontend/config/environment';

interface EnvInfoSignature {
  // Args: { };
  Element: HTMLDivElement;
}

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class EnvInfo extends Component<EnvInfoSignature> {
  <template>
    <div ...attributes>
      <h1>Environment Info</h1>
      <ul>
        <li>s3.REGION: {{config.s3.REGION}}</li>
        <li>apiGateway.API_URL: {{config.apiGateway.URL}}</li>
        <li>s3.BUCKET: {{config.s3.BUCKET}}</li>
        <li>cognito.USER_POOL_ID: {{config.cognito.USER_POOL_ID}}</li>
        <li>cognito.IDENTITY_POOL_ID: {{config.cognito.IDENTITY_POOL_ID}}</li>
        <li>cognito.APP_CLIENT_ID:
          {{config.cognito.APP_CLIENT_ID}}</li>
      </ul>
    </div>
  </template>
}

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry {
    EnvInfo: typeof EnvInfo;
    'env-info': typeof EnvInfo;
  }
}
