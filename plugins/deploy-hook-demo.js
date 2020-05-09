'use strict';

class DeployHookDemo {
    constructor() {
        this.commands = {
            deployHookDemo: {
                lifecycleEvents: ['resources', 'functions'],
            },
        };

        this.hooks = {
            'before:deployHookDemo:resources': this.beforeDeployResources,
            'deployHookDemo:resources': this.deployResources,
            'after:deployHookDemo:functions': this.afterDeployFunctions,
        };
    }

    beforeDeployResources() {
        console.log('Before DeployHookDemo plugin\'s "resources" lifecycle event.');
    }

    deployResources() {
        console.log('In DeployHookDemo plugin\'s "resources" lifecycle event.');
    }

    afterDeployFunctions() {
        console.log('After DeployHookDemo plugin\'s "functions" lifecycle event.');
    }
}

module.exports = DeployHookDemo;
