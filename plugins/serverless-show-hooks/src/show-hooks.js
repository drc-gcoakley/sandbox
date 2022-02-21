class ShowHooks {
  constructor(serverless, options) {
    this.commands = {
      hooks: {
        usage: 'Lists hooks that plugins provide and attach to.' +
          ' Note some default hooks provided by Serverless may not be shown.' +
          ' See: https://gist.github.com/HyperBrain/50d38027a8f57778d5b0f135d80ea406',
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

  stringListToString(prefixForEach, stringList, infix) {
    return stringList.map((e) => `${prefixForEach}:${e}`).join(infix);
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
    let prefix = this.slsOptions.verbose ? '    ' : '';
    let infix = '\n' + prefix;

    this.serverless.cli.log('Serverless plugin lifecycle events and subscriptions ("hooks") legend:');
    if (! this.slsOptions.verbose) {
      this.serverless.cli.log('    (<PluginName>) {provides} "<commandName> [subCommandName]" -> {publishes}' +
        ' <lifecycleEventName>');
      this.serverless.cli.log('    (<PluginName>) <- {subscribes to} <lifecycleEventName>');
    }
    this.serverless.cli.log('');

    for (let plugin of Object.values(this.serverless.pluginManager.plugins)) {
      const pluginName = plugin.constructor.name;
      const pluginHookList = this.findPluginHooks(pluginName);

      for (let commandName of Object.keys(plugin.commands || {})) {
        const command = plugin.commands[commandName];

        if (command.lifecycleEvents) {
          if (this.slsOptions.verbose) {
            this.serverless.cli.log(`plugin '${pluginName}' provides command '${commandName}' which emits` +
              `${this.hasAnyItems(command.lifecycleEvents) ? '' : ' no'} lifecycleEvents:\n` +
              prefix + this.stringListToString(
                `${this.slsOptions.verbose ? 'event:' : '->'} ${commandName}`,
                command.lifecycleEvents, infix));
          } else {
            this.serverless.cli.log(prefix + this.stringListToString(
              `(${pluginName}) "${commandName}" -> ${commandName}`, command.lifecycleEvents, infix));
          }
        }

        for (let subcommandName of Object.keys(command.commands || {})) {
          const subcommand = command.commands[subcommandName];
          if (subcommand.lifecycleEvents) {
            if (this.slsOptions.verbose) {
              this.serverless.cli.log(`plugin '${pluginName}' provides command '${commandName}', ` +
                `subcommand '${subcommandName}' which emits` +
                `${this.hasAnyItems(subcommand.lifecycleEvents) ? '' : ' no'} lifecycleEvents:\n` +
                prefix + this.stringListToString(
                  prefix + `${this.slsOptions.verbose ? 'event:' : '->'} ${commandName}:${subcommandName}`,
                  subcommand.lifecycleEvents, infix));
            } else {
              this.serverless.cli.log(prefix + this.stringListToString(
                prefix + `(${pluginName}) "${commandName} ${subcommandName}" -> ${commandName}:${subcommandName}`,
                subcommand.lifecycleEvents, infix));
            }
          }
        }
      }

      if (pluginHookList) {
        if (this.slsOptions.verbose) {
          this.serverless.cli.log(`plugin '${pluginName}' attaches to:`);
        }
        for (let pluginHook of pluginHookList) {
          if (this.slsOptions.verbose) {
            this.serverless.cli.log(prefix + `hook: ${pluginHook.hookName}`);
          } else {
            this.serverless.cli.log(`(${pluginName}) <- ${pluginHook.hookName}`);
          }
        }
      }
    }

    this.serverless.cli.log('\nEach lifecycleEvent may have a "before:"* and/or an "after:"* event(s).')
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
