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

    async beforeDeployResources() {
        console.log('Before DeployHookDemo plugin\'s "resources" lifecycle event.');
    }

    async deployResources() {
        console.log('In DeployHookDemo plugin\'s "resources" lifecycle event.');
    }

    async afterDeployFunctions() {
        console.log('After DeployHookDemo plugin\'s "functions" lifecycle event.');
    }
}

module.exports = DeployHookDemo;
