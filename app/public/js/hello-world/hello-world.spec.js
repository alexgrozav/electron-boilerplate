import {
  expect
} from 'chai';

import {
  greet,
  bye
} from './hello-world';

import env from '../application/env';

describe("hello world", function() {
  it("greets", function() {
    return expect(greet()).to.equal('Hello World!');
  });
  it("says goodbye", function() {
    return expect(bye()).to.equal('See ya!');
  });
  return it("should load test environment variables", function() {
    expect(env.name).to.equal('test');
    return expect(env.description).to.equal('Add here any environment specific stuff you like.');
  });
});

//# sourceMappingURL=../../maps/hello-world/hello-world.spec.js.map
