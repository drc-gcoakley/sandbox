'use strict';
const assert = require('assert');

/**
 * This acts as a variable resolver for ${path:} and ${slscfg}. Currently, it only sets a variable (with some
 * aliases) to the path of the serverless directory containing the serverless.* configuration file.
 *
 * TODO make ${file(...)} and {functions -> handler} paths relative.
 */
class PathUtil {

    constructor(serverlessObject, options) {
        this.commands = {
            path: {
                usage: 'Provides some static variable values.',
                // Lifecycle events hooked by this plugin.
                lifecycleEvents: [ 'print' ],
                commands: {
                    dump: {
                        usage: 'Displays options and values.',
                        lifecycleEvents: [ 'dump' ],
                    }
                },
                options: {
                    slscfg: {
                        usage: 'Specify the relative or absolute value for the serverless configuration directory.',
                        shortcut: '~',
                    },
                    serverlessConfiguration: {
                        usage: 'Specify the relative or absolute value for the serverless configuration directory.',
                        shortcut: '~',
                    }
                }
            }
        };
        this.serverless = serverlessObject;
        this.service = serverlessObject.service;
        this.slsOptions = options || {};
        this.config = Object.assign({}, this.serverless.config,
            this.service.custom && this.service.custom.pathUtil,
            this.service.custom.plugins && this.service.custom.plugins.pathUtil);

        this.values = {};
        this.initializeValues();
        this.hookEvents();
        this.defineVariableResolver();
    }

    initializeValues() {
        const cmdOpts = this.commands.path.options;

        // Find any command line option for the serverless config. directory.
        let serverlessConfigDir = this.config.servicePath;
        for (const optionName of Object.keys(cmdOpts)) {
            const shortcut = cmdOpts[optionName].shortcut;
            if (this.slsOptions[optionName] || this.slsOptions[shortcut]) {
                serverlessConfigDir = this.slsOptions[optionName] || this.slsOptions[shortcut];
            }
        }

        // Set variables for the serverless configuration directory path.
        for (const optionName of Object.keys(cmdOpts)) {
            this.values[optionName] = serverlessConfigDir;
            this.values[cmdOpts[optionName].shortcut] = serverlessConfigDir;
        }
    }

    hookEvents() {
        this.hooks = {
            // Hook into the standard serverless 'print' command.
            'before:print:print': this.myBeforePrint.bind(this),
            'after:print:print': this.myAfterPrint.bind(this),

            // Define our dump function.
            'path:dump:dump': this.dump.bind(this),
        };
    }

    async myResolver(variableSpec) {
        const name = variableSpec.split(':')[1];
        return Promise.resolve(
            (this.slsOptions && this.slsOptions[name]) ||
            (this.config && this.config[name]) ||
            (this.values && this.values[name])
        );
    }

    defineVariableResolver() {
        this.variableResolvers = {
            path: this.myResolver.bind(this),
            slscfg: this.myResolver.bind(this),
            // // if a variable type depends on profile/stage/region/credentials, to avoid infinite loops in
            // // trying to resolve variables that depend on themselves, specify as such by setting a
            // // dependendServiceName property on the variable getter
            // echoStageDependent: {
            //     resolver: this.getDependentEchoTestValue,
            //     serviceName: "path: that variable isn't pre-populated",
            //     isDisabledAtPrepopulation: true
            // }
        }
    }

    myBeforePrint() { // this.serverless.cli.log() does not work here.
        console.log('PathUtil: before print at ' + new Date().toLocaleString());
    }
    myAfterPrint() { // this.serverless.cli.log() does not work here.
        console.log('PathUtil: after print at ' + new Date().toLocaleString());
    }

    dump() {
        this.serverless.cli.log('PathUtil options: ' + JSON.stringify(this.slsOptions, null, 2));
        this.serverless.cli.log('PathUtil values: ' + JSON.stringify(this.values, null, 2));
    }

}

module.exports = PathUtil;
