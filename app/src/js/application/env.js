var env;

import jetpack from 'fs-jetpack';

env = jetpack.cwd(__dirname).read('config/env.json', 'json');

export default env;
