import Component from '@glimmer/component';

interface HelloSignature {
  Args: {
    name?: string;
  };
  Element: HTMLDivElement;
}

const or = <T, U>(a: T | undefined, b: U): T | U => (a === undefined ? b : a);

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class Hello extends Component<HelloSignature> {
  <template>
    <div class='text-blue-500' ...attributes>
      Hello,
      {{or @name 'World'}}!
    </div>
  </template>
}

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry {
    Hello: typeof Hello;
    hello: typeof Hello;
  }
}
