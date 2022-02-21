'use strict';

class ShowServerlessConfigurationPlugin {
  constructor(serverless, options) {
    this.serverless = serverless;
    this.service = serverless.service;
    this.config = this.service.custom && this.service.custom.showConfig || {};
    this.options = options;
    this.commands = {};
    this.hooks = {
      'before:print:print': this.showConfiguration.bind(this),
    };
  }

  handler() {
    this.serverless.cli.log('Show Serverless Configuration');

    if (this.config) {
      this.serverless.cli.log('Displaying configuration trees.');
      this.config.forEach((key) => {
        this.serverless.cli.log(`Serverless Configuration for ${key}: ${JSON.stringify(this.config.key, null, 2)}`);
      });
    } else {
      this.serverless.cli.log('No "showConfig" configuration.');
    }
  }
}

module.exports = ShowServerlessConfigurationPlugin;
