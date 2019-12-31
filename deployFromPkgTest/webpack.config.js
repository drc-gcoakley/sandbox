// const _ = require('lodash');
let nodeExternals = require('webpack-node-externals');
const slsw = require('serverless-webpack');

module.exports = {
    entry: slsw.lib.entries,
    mode: slsw.lib.webpack.isLocal ? "development" : "production",
    target: 'node',
    // we use webpack-node-externals to excludes all node deps.
    // You can manually set the externals too.
    externals: [nodeExternals()],
    // module: {
    //   loaders: [ ... ]
    // }
  };
