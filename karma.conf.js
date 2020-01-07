// Karma configuration file, see link for more information
// https://karma-runner.github.io/2.0/config/configuration-file.html

const { makeSureNoAppIsSelected } = require('@nrwl/schematics/src/utils/cli-config-utils');
// Nx only supports running unit tests for all apps and libs.
makeSureNoAppIsSelected();
// Uncomment to change the output directory root.
//const path = require('path');

module.exports = function (config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine', '@angular/cli'],
    plugins: [
      // Link for more information: https://karma-runner.github.io/2.0/config/plugins.html
      require('karma-jasmine'),
      require('karma-chrome-launcher'),
      require('karma-jasmine-html-reporter'),
      require('karma-coverage-istanbul-reporter'),
      require('@angular/cli/plugins/karma')
    ],
    client:{
      clearContext: false // leave Jasmine Spec Runner output visible in browser
    },
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome_no_plugins'],
    // you can define custom flags
    customLaunchers: {
      Chrome_no_plugins: {
        base: 'Chrome',
        // Don't waste time starting extensions / plugins or loading history.
        flags: ['--disable-plugins --incognito']
      }
    },
    singleRun: false,
    angularCli: {
      environment: 'dev'
    },
    reporters: ['progress', 'kjhtml'],
    reportSlowerThan: 5000,
    coverageIstanbulReporter: {
      // https://www.npmjs.com/package/karma-coverage-istanbul-reporter
      // base output directory. If you include %browser% in the path it will be replaced with the karma browser name
      reports: [ 'html', 'lcovonly' ],
        // Uncomment to change the output directory root.
        //dir: path.join(__dirname, 'coverage'),
        // Most reporters accept additional config options. You can pass these through the `report-config` option
        "report-config": {
          // all options available at: https://github.com/istanbuljs/istanbuljs/blob/aae256fb8b9a3d19414dcf069c592e88712c32c6/packages/istanbul-reports/lib/html/index.js#L135-L137
          html: {
            // outputs the report in ./coverage/html
            subdir: 'html_report'
          }
        },
      fixWebpackSourcePaths: true,

      // Enforce percentage thresholds. Anything under these percentages will cause karma to fail
      // with an exit code of 1 if not running in watch mode.
      thresholds: {
        // Set emitWarning to `true` to not fail the test command when thresholds are not met.
        emitWarning: true, // TODO add more test coverage then set this to false. -GlenC Apr'18.
        global: { // thresholds for all files
          statements: 90,
          lines: 90,
          branches: 90,
          functions: 90
        },
        each: { // thresholds per file
          statements: 90,
          lines: 90,
          branches: 90,
          functions: 90,
          overrides: {
            'libs/**/*.js': { // No checking apps since this workspace is just for the library.
              statements: 90
            }
          }
        }
      }
    }
  });
};
