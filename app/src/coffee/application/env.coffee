# Simple wrapper exposing environment variables to rest of the code.

import jetpack from 'fs-jetpack'

# The variables have been written to `env.json` by the build process.
env = jetpack.cwd(__dirname).read('config/env.json', 'json')
export default env
