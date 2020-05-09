'use strict';
const assert = require('assert');

class PathUtil {

    constructor(serverlessObject, options) {
        this.commands = {
            path: {
                usage: 'Provides some static variable values.',
                // Lifecycle events hooked by this plugin.
                lifecycleEvents: [ 'print' ],
                commands: {
                    mydump: {
                        usage: 'Displays options and values.',
                        lifecycleEvents: [ 'mydump' ],
                    },
                    myprint: {
                        usage: 'Wraps the standard "print" command.',
                        // Lifecycle events hooked by this plugin.
                        lifecycleEvents: [ 'myprint' ],
                    }
                },
                options: {
                    root: {
                        usage: 'Specify the value for "root" (e.g. "--root value")',
                        shortcut: '/',
                        required: false,
                    }
                }
            }
        };
        this.serverless = serverlessObject;
        this.service = serverlessObject.service;
        this.slsOptions = options || {};
        this.config = (this.service.custom.plugins && this.service.custom.plugins.pathUtil) ||
            (this.service.custom.pathUtil) || {};

        this.values = {};
        this.initializeValues();
        this.hookEvents();
        this.defineVariableResolver();
    }

    initializeValues() {
        this.values['root'] = this.values['_root_'] = this.values['_'] = this.values[''] =
            this.slsOptions.root || this.slsOptions['/'];

        for (const name of ['_root_', 'root', '_', '', null]) {
            if (! this.values[name]) {
                this.values[name] = `This is the value of "${name}" at ${Date.now()}`;
            }
        }
    }

    hookEvents() {
        this.hooks = {
            // Hook into the standard serverless 'print' command.
            'before:print:print': async () => { this.myBeforePrint.bind(this) },
            'after:print:print': async () => { this.myAfterPrint.bind(this) },

            // Define our dump function.
            'path:mydump': this.dump.bind(this),
            // 'path:mydump:mydump': this.dump.bind(this),
        };
    }

    async myResolver(variableSpec) {
        assert.ok(variableSpec.startsWith('path:'));
        const name = variableSpec.substr(5);
        return (this.slsOptions && this.slsOptions[name]) ||
            (this.config && this.config[name]) ||
            (this.values && this.values[name]);
    }

    defineVariableResolver() {
        this.variableResolvers = {
            path: this.myResolver.bind(this),
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

    myBeforePrint() { this.serverless.cli.log('PathUtil: before print at ' + Date.now()); }
    myAfterPrint() { this.serverless.cli.log('PathUtil: after print at ' + Date.now()); }

    dump() {
        this.serverless.cli.log('PathUtil options: ' + JSON.stringify(this.slsOptions, null, 2));
        this.serverless.cli.log('PathUtil values: ' + JSON.stringify(this.values, null, 2));
    }

}

module.exports = PathUtil;
