path = require('path')
jetpack = require('fs-jetpack')
rollup = require('rollup').rollup

nodeBuiltInModules = [
  'assert'
  'buffer'
  'child_process'
  'cluster'
  'console'
  'constants'
  'crypto'
  'dgram'
  'dns'
  'domain'
  'events'
  'fs'
  'http'
  'https'
  'module'
  'net'
  'os'
  'path'
  'process'
  'punycode'
  'querystring'
  'readline'
  'repl'
  'stream'
  'string_decoder'
  'timers'
  'tls'
  'tty'
  'url'
  'util'
  'v8'
  'vm'
  'zlib'
]
electronBuiltInModules = [ 'electron' ]

generateExternalModulesList = =>
  appManifest = jetpack.read('./package.json', 'json')
  [].concat nodeBuiltInModules, electronBuiltInModules, Object.keys(appManifest.dependencies), Object.keys(appManifest.devDependencies)

cached = {}

module.exports = (src, dest, opts) =>
  opts = opts or {}
  opts.rollupPlugins = opts.rollupPlugins or []

  rollup(
    entry: src
    external: generateExternalModulesList()
    cache: cached[src]
    plugins: opts.rollupPlugins)
  .then (bundle) =>
    cached[src] = bundle
    jsFile = path.basename(dest)
    mapDest = path.resolve(__dirname, '..', '..', 'application', 'assets', 'maps', jsFile)

    result = bundle.generate(
      format: 'cjs'
      sourceMap: true
      sourceMapFile: jsFile
    )

    # Wrap code in self invoking function so the variables don't
    # pollute the global namespace.
    isolatedCode = '(function () {' + result.code + '\n}());'
    Promise.all [
      jetpack.writeAsync(dest, isolatedCode + '\n//# sourceMappingURL=' + mapDest + '.map')
      jetpack.writeAsync(mapDest + '.map', result.map.toString())
    ]
