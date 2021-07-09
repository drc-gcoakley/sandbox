class ServerlessShowHooks {
  constructor(serverless, options) {
    this.commands = {
      hooks: {
        usage: 'Provides hooks that plugins provide and attach to.' + 
               '   Note that the default hooks provided by Serverless are not all shown.',
               '   See: https://gist.github.com/HyperBrain/50d38027a8f57778d5b0f135d80ea406',
        lifecycleEvents: ['hooks'],
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

  stringListToString(prefixForEach, stringList) {
    return stringList.map((e) => `'${prefixForEach}${e}'`).join(',\n\t');
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
    return pluginHooks;
    ``
  }

  hasAnyItems(list) {
    return list && list.length > 0;
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
          this.serverless.cli.log(`plugin '${pluginName}', command '${commandName}' provides` +
            `${this.hasAnyItems(command.lifecycleEvents) ? '' : ' no'} lifecycleEvents: \n\t` +
            this.stringListToString(`${pluginName}:${commandName}:`, command.lifecycleEvents));
        }
        for (let subcommandName of Object.keys(command.commands || {})) {
          const subcommand = command.commands[subcommandName];
          if (subcommand.lifecycleEvents) {
            this.serverless.cli.log(`plugin '${pluginName}', command '${commandName}', subcommand '${subcommandName}' provides` +
                `${this.hasAnyItems(subcommand.lifecycleEvents) ? '' : ' no'} lifecycleEvents: \n\t` +
              this.stringListToString(`${pluginName}:${commandName}:${subcommandName}:`, subcommand.lifecycleEvents));
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
