var env;

import jetpack from 'fs-jetpack';

env = jetpack.cwd(__dirname).read('env.json', 'json');

export default env;
