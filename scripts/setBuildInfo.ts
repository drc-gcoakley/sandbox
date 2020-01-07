/*tslint:disable*/
const replaceInFile = require('replace-in-file');

async function setBuildInfo() {
  const files = 'src/app/app.build-info.ts';
  const replacements = {
    __BUILD_NUMBER__: process.env.BUILD_NUMBER,
    __BUILD_DATE__: process.env.BUILD_DATE,
  };
  const from = [];
  const to = [];

  Object.keys(replacements).forEach((key) => {
    const replacementValue = replacements[key];

    if (!replacementValue) {
      throw new Error(`setBuildInfo: missing build info, no value found for ${key.replace(new RegExp('__', 'g'), '')}`);
    }

    from.push(new RegExp(`${key}`, 'g'));
    to.push(replacementValue);
  });

  const options = {
    files,
    from,
    to,
  };

  const results = await replaceInFile(options);
  console.log('setBuildInfo: Replacement results:', results);
}

setBuildInfo().catch((error) => {
  console.log(error);
  process.exit(1);
});

