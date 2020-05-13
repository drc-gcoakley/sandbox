const path = require('path');
const fs = require('fs');
const assert = require('assert');
const uuid = require('node-uuid');

/**
 * Include this as the FIRST plugin in the serverless configuration file.
 * This is to ensure that all other plugins pick up the definition of 'servicePath' set by this.
 *
 * NOTE: This is creates symlinks for directories because hard links appear to be deprecated (at least, on MacOS).
 *       This is creates hard links for files because Serverless, its AWS provider plugin, etc. don't allow/check for
 *       symbolic links. (Utils.js:fileExistsSync() among others).
 *
 * FUTURE:
 *  * Should this have an option to just link all directory entries that are a peer of serverless.*?
 */
class ServerlessParallelSupport {

  constructor(serverless, options) {
    this.SLS_ORIG_CFG_DIR = serverless.config.servicePath;
    this.absoluteUniqueWorkDir = ''; // Set later.
  }

  attachHooks() {
    // TODO hook to run only at start of necessary operations.
    // TODO hook to run at exit too remove the created symlink.
    // this.hooks = {
    //   'before:deploy:initialize':
    //   'before:package:initialize':
    //
    //   'before:deploy:finalize':
    //   'before:package:finalize':
    // }
  }

  async doCreateLinks() {
    this.SLS_ORIG_CFG_DIR = serverless.config.servicePath;

    const stage = (serverless.custom && serverless.custom.stage) || options.stage;
    const region = (serverless.custom && serverless.custom.region) || options.region;
    // Using the slsInstanceId requires waiting for its promise to resolve. Since we just need a unique value,
    // a uuid works fine without the need to restructure code.
    // const slsInstanceId = serverless.variables.getValueFromSls('sls:instanceId');
    const uniqueIdentifier = uuid.v4();
    const uniqueBuildRelativeDir = 'slsWorkDir_' + ((stage && region) ? stage + '_' + region : uniqueIdentifier);
    this.absoluteUniqueWorkDir = path.resolve(serverless.config.servicePath, 'tmp', uniqueBuildRelativeDir);

    this.setNewWorkDirectory(this.absoluteUniqueWorkDir);
    // TODO Provide this as a variable, say: ${parallelSupportDir}.
    serverless.custom.parallelSupportWorkingDirectory = this.absoluteUniqueWorkDir;

    for (let dirEntry of fs.readdirSync(this.SLS_ORIG_CFG_DIR)) {
      this.linkEntry(serverless, dirEntry, this.absoluteUniqueWorkDir);
    }

    serverless.config.servicePath = this.absoluteUniqueWorkDir;
  }

  async doRemoveLinks() {

  }

  setNewWorkDirectory(uniqueWorkDir) {
    fs.mkdirSync(uniqueWorkDir, {recursive: true});
    // Keep this console.log() so scripts can be created to part the serverless output for the directory name.
    console.log('ParallelSupport created working directory: ' + uniqueWorkDir);
    process.chdir(uniqueWorkDir);
  }

  linkEntry(serverless, dirEntry, uniqueWorkDir) {
    // console.log('ParallelSupport checking: ' + serverless.config.servicePath + ' and ' + dirEntry);
    const sourceEntry = path.join(serverless.config.servicePath, dirEntry);
    const targetEntry = path.join(uniqueWorkDir, dirEntry);
    const sourceExists = fs.existsSync(sourceEntry);
    const targetExists = fs.existsSync(targetEntry);

    if (sourceExists && !targetExists) {
      // console.log(`ParallelSupport linking: ${path.join(serverless.config.servicePath, dirEntry)} `);
      // console.log(`ParallelSupport          ${path.join(uniqueWorkDir, dirEntry)} `);
      const sourceStats = fs.lstatSync(sourceEntry);
      fs.symlinkSync(sourceEntry, targetEntry);
    }
    // } else if (!sourceExists) {
    //     console.log('ParallelSupport: source file does not exist: ' + sourceEntry);
    // } else if (targetExists) {
    //     console.log('ParallelSupport: target file already exists: ' + targetEntry);
  }

}

module.exports = ServerlessParallelSupport;
