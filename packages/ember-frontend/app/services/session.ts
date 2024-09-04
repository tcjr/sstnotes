import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { Auth } from 'aws-amplify';

export default class SessionService extends Service {
  @tracked isAuthenticated = false;
  // isAuthenticating is not currently used in the ui
  @tracked isAuthenticating = false;

  load = async () => {
    console.log('[session] loading Amplify session');
    this.isAuthenticating = true;
    try {
      await Auth.currentSession();
      this.isAuthenticated = true;
    } catch (e) {
      if (e !== 'No current user') {
        alert(e);
      }
    } finally {
      this.isAuthenticating = false;
    }
  };

  logout = async () => {
    await Auth.signOut();
    this.isAuthenticated = false;
  };
}

// Don't remove this declaration: this is what enables TypeScript to resolve
// this service using `Owner.lookup('service:session')`, as well
// as to check when you pass the service name as an argument to the decorator,
// like `@service('session') declare altName: SessionService;`.
declare module '@ember/service' {
  interface Registry {
    session: SessionService;
  }
}
