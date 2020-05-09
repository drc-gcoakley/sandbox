class ShowHooks {
    constructor(serverless, options) {
        this.commands = {
            hooks: {
                usage: 'Provides hooks that plugins provide and attach to.',
                lifecycleEvents: [ 'hooks' ],
            }
        }

        this.serverless = serverless;
        this.slsOptions = options || {};
        this.defineHooks();
    }

    defineHooks() {
        this.hooks = {
            // Define our dump function.
            'hooks:hooks': this.showHooks.bind(this),
        }
    }

    stringListToString(stringList) {
        return stringList.map((e) => `'${e}'`).join(', ');
    }

    showHooks() {
        const pluginManager = this.serverless.pluginManager;

        // for (let hookName of Object.keys(pluginManager.hooks)) {
        //     if (this.isIterable(pluginManager.hooks[hookName])) {
        //         for (let pluginName of pluginManager.hooks[hookName]) {
        //             this.serverless.cli.log(`plugin '${pluginName}' attaches to hook '${hookName}'.`);
        //         }
        //     }
        // }

        for (let plugin of Object.values(pluginManager.plugins)) {
            const pluginName = plugin.constructor.name;

            if (this.isIterable(plugin.hooks)) {
                for (let hookName of plugin.hooks) {
                    this.serverless.cli.log(`plugin '${pluginName}' attaches to hook '${hookName}'.`);
                }
            }

            for (let commandName of Object.keys(plugin.commands || {})) {
                const command = plugin.commands[commandName];

                if (command.lifecycleEvents) {
                    this.serverless.cli.log(`plugin '${pluginName}', command '${commandName}' provides lifecycleEvents: ` +
                        this.stringListToString(command.lifecycleEvents));
                }
                for (let subcommandName of Object.keys(command.commands || {})) {
                    const subcommand = command.commands[subcommandName];
                    if (subcommand.lifecycleEvents) {
                        this.serverless.cli.log(`plugin '${pluginName}', command '${commandName}', ` +
                            `subcommand '${subcommandName}' provides lifecycleEvents: ` +
                            this.stringListToString(subcommand.lifecycleEvents));
                    }
                }
            }
        }

    }

    isIterable(obj) {
        // Checks for null and undefined.
        if (obj == null) {
            return false;
        }
        return typeof obj[Symbol.iterator] === 'function';
    }
}

module.exports = ShowHooks;
