var env;

import jetpack from 'fs-jetpack';

env = jetpack.cwd(__dirname).read('config/env.json', 'json');

console.log("ENV IS", env);

export default env;

//# sourceMappingURL=../../maps/application/env.js.map
