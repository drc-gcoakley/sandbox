'use strict';

/**
 * Module dependencies.
 */
var utils = require('./utils');
var exec = require('child_process').exec;

var Tesseract = {
  /**
   * options default options passed to Tesseract binary
   * @type {Object}
   */
  options: {
    'l': 'eng',
    'psm': 3,
    'config': null,
    'binary': 'tesseract',
    'debug': false,
    'dpi': 300,
  },

  /**
   * Runs Tesseract binary with options
   *
   * @param {String} image
   * @param {Object} options to pass to Tesseract binary
   */
  process: function(image, options) {
    var defaultOptions = utils.merge({}, Tesseract.options);
    options = utils.merge(defaultOptions, options);

    // assemble tesseract command
    var command = [options.binary, image, 'stdout'];

    if (isDefined(options.l)) {
      command.push('-l ' + options.l);
    }

    if (isDefined(options.psm)) {
      command.push('--psm ' + options.psm);
    }

    if (isDefined(options.oem)) {
      command.push('--oem ' + options.oem);
    }

    if (isDefined(options.tessdata)) {
      command.push('--tessdata-dir ' + options.tessdata);
    }

    if (isDefined(options.dpi)) {
      command.push('--dpi ' + options.dpi);
    }

    if (isDefined(options.config)) {
      command.push(options.config);
    }

    command = command.join(' ');

    var opts = options.env || {};

    // Run the tesseract command
    return new Promise((resolve, reject) => {
      exec(command, opts, function(err, stdout) {
        if (options.debug) {
          console.log(`drc-node-tesseract: executing command '${command}'`);
        }

        if (err) {
          reject(err);
          return;
        }

        const output = stdout.toString();

        if (options.debug) {
          console.log(`drc-node-tesseract: resolving output = '${output}'`);
        }

        resolve(output);
      });
    });
  }
};

function isDefined(value) {
  return value !== undefined && value !== null;
}

var version = process.versions.node.split('.').map(function(value) {
  return parseInt(value, 10);
});

if (version[0] === 0 && (version[1] < 9 || version[1] === 9 && version[2] < 5)) {
  process.addListener('uncaughtException', function _uncaughtExceptionThrown(err) {
    throw err;
  });
}

/**
 * Module exports.
 */
module.exports.process = Tesseract.process;
