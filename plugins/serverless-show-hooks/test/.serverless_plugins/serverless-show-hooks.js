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

    findPluginHooks(pluginName) {
      const pluginManager = this.serverless.pluginManager;
      const pluginHooks = [];

      for (const hookName of Object.keys(pluginManager.hooks)) {
        if (this.isIterable(pluginManager.hooks[hookName])) {
          for (const plugin of pluginManager.hooks[hookName]) {
            if (plugin.pluginName === pluginName) {
              pluginHooks.push({plugin: plugin, hookName: hookName});
            }
          }
        } else if (typeof pluginManager.hooks[hookName] === 'object') {
          pluginHooks.push({plugin: pluginManager.hooks[hookName], hookName: hookName});
        }
      }
      return pluginHooks;``
    }

    showHooks() {
        for (let plugin of Object.values(this.serverless.pluginManager.plugins)) {
            const pluginName = plugin.constructor.name;
            const pluginHookList = this.findPluginHooks(pluginName);

            if (pluginHookList) {
              for (let pluginHook of pluginHookList) {
                this.serverless.cli.log(`plugin '${pluginName}' attaches to hook '${pluginHook.hookName}'.`);
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
