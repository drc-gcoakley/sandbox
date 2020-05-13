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
        const stage = (serverless.custom && serverless.custom.stage) || options.stage;
        const region = (serverless.custom && serverless.custom.region) || options.region;
        // Using the slsInstanceId requires waiting for its promise to resolve. Since we just need a unique value,
        // a uuid works fine without the need to restructure code.
        // const slsInstanceId = serverless.variables.getValueFromSls('sls:instanceId');
        const uniqueIdentifier = uuid.v4();
        const uniqueBuildRelativeDir = 'slsWorkDir_' + ((stage && region) ? stage + '_' + region : uniqueIdentifier);
        const absoluteUniqueWorkDir = path.resolve(serverless.config.servicePath, 'tmp', uniqueBuildRelativeDir);
        const myConfig = this.findMyServiceConfigBlock(serverless.service.custom);

        if (myConfig) {
          let allEntriesToLink = this.getEntriesToLink(myConfig);

          this.setNewWorkDirectory(absoluteUniqueWorkDir);
          myConfig.workingDirectory = absoluteUniqueWorkDir;

          // Link the set of files and directories that serverless needs.
          for (const dirEntry of allEntriesToLink) {
            this.linkEntry(serverless, dirEntry, absoluteUniqueWorkDir);
          }
          serverless.config.servicePath = absoluteUniqueWorkDir;
        }
    }

    setNewWorkDirectory(uniqueWorkDir) {
        fs.mkdirSync(uniqueWorkDir, {recursive: true});
        // Keep this console.log() so scripts can be created to part the serverless output for the directory name.
        console.log('ParallelSupport created working directory: ' + uniqueWorkDir);
        process.chdir(uniqueWorkDir);
    }

    getEntriesToLink(myConfig) {
        let allEntriesToLink = [
            'node_modules',         // The project's dependent modules
            '.serverless.yml',      // Possible serverless configuration file
            '.serverless.yaml',     // Possible serverless configuration file
            '.serverless.json',     // Possible serverless configuration file
            '.serverless.js',       // Possible serverless configuration file
            '.serverless_plugins',  // Location of our project's serverless configuration files.
            'src',                  // Project's source files.
            'package.json',         // NPM configuration
            'package-lock.json',    // NPM configuration cache
        ];

        if (myConfig && myConfig.linkEntries) {
            // console.log('ParallelSupport will link: ' +
            // customConfig.plugins.parallelSupport.linkEntries.join(', '))
            allEntriesToLink.push(...myConfig.linkEntries);
        }
        return allEntriesToLink;
    }

    findMyServiceConfigBlock(customConfig) {
        if (customConfig && customConfig.plugins && customConfig.plugins.parallelSupport &&
            customConfig.plugins.parallelSupport.linkEntries) {
            return customConfig.plugins.parallelSupport;

        } else if (customConfig && customConfig && customConfig.parallelSupport &&
            customConfig.parallelSupport.linkEntries) {
            return customConfig.parallelSupport;
        }
        return null;
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
            if (sourceStats.isFile()) {
                fs.symlinkSync(sourceEntry, targetEntry);
            } else if (sourceStats.isDirectory()) {
                fs.symlinkSync(sourceEntry, targetEntry);
            }
            // } else if (!sourceExists) {
            //     console.log('ParallelSupport: source file does not exist: ' + sourceEntry);
            // } else if (targetExists) {
            //     console.log('ParallelSupport: target file already exists: ' + targetEntry);
        }
    }

}

module.exports = ServerlessParallelSupport;
