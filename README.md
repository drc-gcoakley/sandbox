# ECA Portal Client Library

Provides a library of Angular 5 components (written in Typescript) that can be used to decorate any application UI with the DRC INSIGHT portal.  In other words, it allows simple integration into the DRC INSIGHT portal just by importing its EcaClientModule from @eca/client-lib and adding a &lt;eca-portal&gt; tag to an application HTML block. This library will ensure that the user is properly logged into the portal before any requests may be made. 

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) using [Nrwl Nx](https://nrwl.io/nx) using the commands below. More on Nrwl is below.

This workspace is designed for development of a single library in the @eca namespace but could easily be extended to multiple support libraries. Below are the steps I used to create it:

  * $ `create-nx-workspace <project-dir-name>`
    <pre>
    create apps/lib-demo-eca-client/e2e/app.e2e-spec.ts (283 bytes)
    create apps/lib-demo-eca-client/e2e/app.po.ts (201 bytes)
    create apps/lib-demo-eca-client/e2e/tsconfig.e2e.json (405 bytes)
    create apps/lib-demo-eca-client/src/assets/nx-logo.png (71592 bytes)
    create apps/lib-demo-eca-client/src/assets/.gitkeep (0 bytes)
    create apps/lib-demo-eca-client/src/environments/environment.prod.ts (51 bytes)
    create apps/lib-demo-eca-client/src/environments/environment.ts (387 bytes)
    create apps/lib-demo-eca-client/src/favicon.ico (5430 bytes)
    create apps/lib-demo-eca-client/src/index.html (302 bytes)
    create apps/lib-demo-eca-client/src/main.ts (370 bytes)
    create apps/lib-demo-eca-client/src/polyfills.ts (2667 bytes)
    create apps/lib-demo-eca-client/src/styles.css (80 bytes)
    create apps/lib-demo-eca-client/src/tsconfig.app.json (308 bytes)
    create apps/lib-demo-eca-client/src/app/app.module.ts (450 bytes)
    create apps/lib-demo-eca-client/src/app/app.component.html (552 bytes)
    create apps/lib-demo-eca-client/src/app/app.component.spec.ts (702 bytes)
    create apps/lib-demo-eca-client/src/app/app.component.ts (258 bytes)
    create apps/lib-demo-eca-client/src/app/app.component.css (0 bytes)
    update .angular-cli.json (2823 bytes)
    </pre>
    
  * $ `ng generate lib --routing eca-client`
    <pre>
    create libs/eca-client/index.ts (80 bytes)
    create libs/eca-client/src/eca-client.module.spec.ts (183 bytes)
    create libs/eca-client/src/eca-client.module.ts (281 bytes)
    update .angular-cli.json (2015 bytes)
    </pre>
    
  * code, code, code your feature.

  * You could use the existing app.module.ts but you will need to add routing to it. Alternatively, you can use angular to create a new module with the routing included.

    $ `ng g module --routing --app lib-demo-eca-client lib-demo-eca-client`
      <pre>
      create apps/lib-demo-eca-client/src/app/lib-demo-eca-client/lib-demo-eca-client-routing.module.ts (259 bytes)
      create apps/lib-demo-eca-client/src/app/lib-demo-eca-client/lib-demo-eca-client.module.ts (322 bytes)
      </pre>

The Nrwl & Angular schematics mostly configure things. But, I had to make some changes manually. 

* .angular-cli.json
  Of all places--a hidden file which suggests it should not need to be changed manually, I had to make some changes. Assuming you have run commands such as the above and to the best of my memory, they are: 

  * In the "apps" object property you should find unnamed objects. There should be one for every library (lib.) and application (app.) that you have generated / created in the workspace. Objects that contain the properties "root", "index", "main" are for apps. 

    In the 'app' object
    * I may have had to set the value of the property <br>`"root": "app/lib-demo-eca-client/src",`<br>
    * I added the property <br>`"outDir": "dist/apps/lib-demo-eca-client",`<br>
      WHY: This tells angular where to put distributable files such as the *.d.ts and *.js.map. Note these files will not be seen when you run `ng serve` as they are only held in an in-memory file system.
    * In the "apps" -> "assets" array property I added the string "config.json".<br>
      WHY: This tells it to include the file 'config.json' in the libraries' distributable package. 
    * Set the property <br>`"tsconfig": "tsconfig.app.json",`<br>
      WHY: This file configures the Typescript compiler to build the library sources.
    * Set the property <br>`"prefix": ["eca", "app"],`<br>
      WHY: This tells Angular what the acceptable prefixes are for all [component] selectors in the libraries and applications in this workspace. Note, that it is a best practice for Angular to include a prefix on every component selector tag and  Angular lint requires it.

    In the 'lib' object.
    * Set the property <br>`"tsconfig": "tsconfig.packages.json",`<br>
      WHY: This file configures the Typescript compiler to build the library sources.

  * Added to the top-level object the property <br>`"lintFix": true,`<br>
    WHY: [optional] This tells tslint to fix any simple, obvious errors that it finds, such as single vs double quotes, missing or extraneous commas and semi-colons. 


* package.json 
  * Change the property <br>`"private": false,`
  * Add the property: `"main": "dist/@eca/client-lib/index.js",`<br>
    WHY: This tells the runtime consumers of this library what source file in the distribution provides the entry point to the library's code. 

  * [optional] Add some scripts to support building the library or make things easier / clearer. The properties / lines I added are:

    * `"start": "ng serve -v --port 4321",`<br>
      WHY: There are too many servers that start on default ports. I like to be explicit about it. If you omit the port number it will use port 4200.

    * `"build:all": "yarn build:libs && yarn build:app",`<br>
      Provides a standard build command to build both the library and the app.

    * `"build:app": "ng build --app lib-demo-eca-client --prod",`<br>
      Provides a standard build command to and shortcut for building the app. (for production).

    * `"build:libs": "yarn build:eca-client-lib && yarn copy-assets:eca-client-lib",`<br>
      WHY: Needed a second step to copy the asset file(s) (config.json) and this illustrates how more libraries can be added in a way that provides a standard build command.

    * `"build:eca-client-lib": "ng-packagr -p libs/eca-client/package.json",`<br>
      WHY: ng-packagr is a tool, written by one of the Angular developers, for bundling up angular code libraries into multiple loader formats all ready for packaging with `npm pack`.

    * `"copy-assets:eca-client-lib": "copyfiles -u 3 libs/eca-client/src/config.json dist/@eca/client-lib",`<br>
      WHY: Neither NPM nor Angular are 'build' systems. :-/ This script requires the 'copyfiles' dependency and copies the file 'config.json' to the distribution directory so that it can be included as an example to consumers of this library. I did not find a way for the library code to use this file directly. So, currently, all comsumers will need to create their own 'config.json' file in the root of their application distibution tree. 

    * `"clean": "rimraf dist/*",`<br>
      WHY: Neither NPM nor Angular are 'build' systems. :-/ This script requires the 'rimra' dependency and simply deletes all subfolders and files under the 'dist' distribution directory.

    * `"clean-start": "yarn clean && yarn build:all && yarn start",`<br>
      WHY: Provides a shortcut to perform clean build and restart of the server.

    * `"coverage": "ng test --code-coverage --watch=false",`<br>
      WHY: Provides a shortcut to run code coverage over the tests. 


  * tsconfig.json:
    * In the "@eca/*": array replace the existing value(s) with the ones below.<br> 
      WHY: This uses the files as they will be in the production distribution. This ensures that the library's demo app. (lib-demo-eca-client) tests the layout of the distibution in addition to the code. See the file for more details.

        `
      "dist/@eca/*",
      "node_modules/@eca/*"
        `
        
    * Add a path mapping for every peer dependencies that your library requires so, the compiler can find them. Here is a commonly needed example: <br>
      
      `
      "@angular/*": [
        "node_modules/@angular/*"
      ]
      `


  * tslint.json<br>
    This default version of this file just replicates a number of 'default' Angular lint rules then adds its own. Instead of doing that I added 'tslint-angular' as dependency and have this file extend the 'tslint-angular' ruleset then add its own rules. This make for a smaller file which will require less maintence. Our own rules can still be added we just need to look elsewhere for the details of doing so. 

  * karma.conf.js<br>
    Added the property: 
    <br>`"reportSlowerThan": 5000,` 
    I had to install @nrwl/schematics _locally_ before I could use Karma to run tests.<br>
    WHY: Flags any test that takes more then 5000 ms to execute.


Troubleshooting

If you are trying to use this library and you get the message 'Unassigned App. Name' that means that no app/src/config.json exists in your application's distribution tree. See the example in @eca/client-lib/src/ for what is expected.


## Quick Start & Documentation

Briefly Nrwl (pronounced like [narwal](https://en.wikipedia.org/wiki/Narwhal)) is an open source toolkit for enterprise Angular applications. which is designed to help you create and build enterprise grade Angular applications. It provides an opinionated approach to application project structure and patterns. For more information you may want to [Watch a 5-minute video on how to get started with Nx.](http://nrwl.io/nx).  

## Development server

Run `ng serve --port 4200` for a dev server then navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the app. source files. As of Apr.2018, changing the source code in the library (/libs/...) will usually require a build. 

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `-prod` flag for a production build.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io). The tests are written using [Jasmine](https://jasmine.github.io/).

## Running code coverage on unit tests

Run `ng test --code-coverage` to execute the unit tests via [Karma](https://karma-runner.github.io). The coverage report is generated by [Istanbul](https://github.com/istanbuljs/nyc) when Karma is run and will be accessible from the file ./coverage/index.html.

## Running end-to-end tests (using Protractor)

Run `ng e2e` to execute the end-to-end tests via [Protractor](http://www.protractortest.org/).
Before running the tests make sure you are serving the app via `ng serve`.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).
