const path = require('path');
const slsw = require('serverless-webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');

function concat(iterable, item) {
  var array = [];
  for (var index = 0; index < iterable.length; ++index) {
    array.push(elem);
  }
  array.push(item);
  return array;
}

// const pathToSvrlsDir = slsw.lib.serverless.config.servicePath;
const pathToSvrlsDir = '..';

module.exports = {
  mode: slsw.lib.webpack.isLocal ? 'development' : 'production',
  optimization: {
    minimize: false
  },
  entry: slsw.lib.entries,
  devtool: 'source-map',
  resolve: {
    extensions: ['.js', '.jsx', '.json', '.ts', '.tsx'],
  },
  output: {
    libraryTarget: 'commonjs',
    path: path.resolve(__dirname, '.webpack'),
    filename: '[name].js',
  },
  target: 'node',
  module: {
    rules: [
      // all files with a `.ts` or `.tsx` extension will be handled by `ts-loader`
      { test: /\.tsx?$/, loader: 'ts-loader' },
    ],
  },
  plugins: [
    new CopyWebpackPlugin([
      { from: path.resolve(pathToSvrlsDir, '/serverless/models/*.json'), to: 'models/', flatten: true },
      { from: path.resolve(pathToSvrlsDir, '/serverless/swagger.json') },
      { from: path.resolve(pathToSvrlsDir, '/stacks-map.js') },
    ]),
  ],
};
