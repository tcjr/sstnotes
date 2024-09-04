import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import './index.css';

class MyRouteComponent extends Component {
  <template>
    <div class='Home'>
      <div class='lander'>
        <h1>Scratch</h1>
        <p class='text-muted'>A simple note taking app</p>
      </div>
    </div>
  </template>
}

export default RouteTemplate(MyRouteComponent);
