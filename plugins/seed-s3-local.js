'use strict';

const AWS = require('aws-sdk');
const fs = require('fs');

const LogPlease = require('logplease');
const logger = LogPlease.create('seed-s3-local',
    {useColors: true, showTimestamp: true, useLocalTime: true, showLevel: true});
process.env.ENV = 'local';

class S3LocalSeederPlugin {
  constructor(serverless, options) {
    this.serverless = serverless;
    this.service = serverless.service;
    this.config = this.service.custom && this.service.custom.seedS3local || {};
    this.options = options;
    this.commands = {};
    this.hooks = {
      'before:offline:start:init': this.seedHandler.bind(this),
    };

    LogPlease.setLogLevel('INFO');
    AWS.config.logger = logger
  }

  seedHandler() {
    this.serverless.cli.log('S3LocalSeederPlugin: Starting...');

    if (this.config && this.config.sources) {
      this.config.sources.forEach((config) => {
        let bucketName = config.bucketName;
        let sourceDirectory = config.sourceDirectory;
        let targetS3Folder = config.targetS3Folder;
        let omitSuffix = config.omitSuffix;
        let allowedFileTypes = config.fileTypes? config.fileTypes.split(',') : null;
        let fileCount = 0;

        this.serverless.cli.log(`S3LocalSeederPlugin: Loading files from directory '${sourceDirectory}' into S3 bucket '${bucketName}'.`);

        fs.readdirSync(sourceDirectory).forEach(async (file) => {
          let fileExt = file.substring(file.toLocaleLowerCase().lastIndexOf('.') + 1);
          if (allowedFileTypes && !allowedFileTypes.includes(fileExt)) {
            console.log(`Skipping seeding of unspecified file type of ${fileExt} which is not included in ${allowedFileTypes}`);
          } else {
            let filePath = `${sourceDirectory}/${file}`;
            let id = `${targetS3Folder}/${omitSuffix ? file.substring(0, file.lastIndexOf('.')) : file}`;
            this.upload(fs.readFileSync(filePath), id, bucketName);
            fileCount++;
          }
        });

        if (fileCount === 0) {
          this.serverless.cli.log(`S3LocalSeederPlugin: No files processed!`);
        } else {
          this.serverless.cli.log(`S3LocalSeederPlugin: Done reading ${fileCount} file(s)'.`);
        }
      });
    }

    this.serverless.cli.log('S3LocalSeederPlugin: Complete!');
  }

  getS3ObjectLocal() {
    return new AWS.S3({
      accessKeyId: 'S3RVER' ,
      secretAccessKey: 'S3RVER' ,
      endpoint: 'http://127.0.0.1:9000' ,
      s3ForcePathStyle: true,
      signatureVersion: 'v4',
    });
  }

  async upload(file, id, bucket = null) {

    bucket = bucket || process.env.BUCKET_NAME;
    console.log(`uploading to bucket: ${bucket.length}  -  ${id}`);
    return await this.getS3ObjectLocal().putObject({
      Bucket: bucket,
      Key: `${id}`,
      Body: file,
    }).promise();
  }
}

module.exports = S3LocalSeederPlugin;
