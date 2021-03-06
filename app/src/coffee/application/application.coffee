# Here is the starting point for your application code.
# All stuff below is just to show you how it works. You can delete all of it.

# Use new ES6 modules syntax for everything.
import os from 'os' # native node.js module
import { remote } from 'electron' # native electron module
import jetpack from 'fs-jetpack' # module loaded from npm
import { greet } from '../hello-world/hello-world' # code authored by you in this project
import env from './env'

console.log('Loaded environment variables:', env)

app = remote.app
appDir = jetpack.cwd(app.getAppPath())
pack = appDir.read('package.json', 'json')

# Holy crap! This is browser window with HTML and stuff, but I can read
# here files like it is node.js! Welcome to Electron world :)
console.log('The author of this app is:', pack.author)

document.addEventListener 'DOMContentLoaded', ->
    document.getElementById('greet').innerHTML = greet()
    document.getElementById('platform-info').innerHTML = os.platform()
    document.getElementById('env-name').innerHTML = env.name
