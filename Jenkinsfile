#!/usr/bin/env groovy
@Library('DRC_Global_Pipeline_Libraries@v1.6.0') _
// TODO Always use the LATEST or HEAD DRC library version. Is that possible?
// Use DRC_Global_Pipeline_Libraries@develop ?
import java.lang.reflect.Array

// Ref:
//     https://jenkins.io/blog/2017/02/01/pipeline-scalability-best-practice/
// TODO sooner:
// • Ensure built branch artifacts cannot be named the same as others.
//      ○ (Put in a branch subdirectory?)
// • Avoid the 20 minute wait for objects to show up in artifactory.
//      ○ If not directly the workspace can be stashed and unstashed to each node for deployment.
// • Create list of recent N builds from artifactory to display in UI or figure out how Jenkins and artifactory integrate.
// • Add changelog functionality to builds.
// Future changes:
// • Use the multi-level plugin to select the repository, then branch? This may require a script.
//      @see: https://www.coveros.com/generate-parameter-values-dynamically-jenkins/
// • Use a script to get the possible version choices from Jenkins api ( url:.../$job-name/api/json )
//      @see: https://medium.com/@rijoalvi/jenkins-dynamic-parameters-using-extended-choice-parameter-plugin-and-groovy-1a6ffc41063f
// • Read the list of AWS regions from serverless configuration?

// CONSTANTS - Do not declare them with 'def' or a type.

GENERIC_NODE_AGENT = 'coel7_agent'
ARTIFACTORY_NODE_AGENT = 'coel7_agent'
NODE_AGENT_LABEL_DEV = 'coel7_agent_aws&&aws&&role_dev'
NODE_AGENT_LABEL_PROD = 'coel7_agent_aws&&aws&&role_prod'
// NODE_AGENT_LABEL is NODE_AGENT_LABEL_DEV or NODE_AGENT_LABEL_PROD as set in generateDeployTasks()

DEV_PERMISSION_ACK_DURATION = 14400 // 4 hrs
PROD_PERMISSION_ACK_DURATION = 3600 // 1 hr
NODEJS_VERSION = 'NODE_8_LTS'
PROD_ACCOUNT_ENVS = ['stg', 'prod']
PROD_ACCOUNT_BRANCHES = ['master', 'staging']
LOWER_ACCOUNT_BRANCHES = ['develop', 'sqa', 'loadtest']
BRANCHES_ALWAYS_BUILT = [''] + LOWER_ACCOUNT_BRANCHES + PROD_ACCOUNT_BRANCHES
ARTIFACTORY_ROOT = 'http://artifactory.datarecognitioncorp.com/artifactory'
ARTIFACTORY_DEV_SEGMENT = 'drc-dev'
ARTIFACTORY_PROD_SEGMENT = 'drc-release'
REGIONS = ['us-east-1', 'us-east-2']
S3_DEPLOY_PATH = 'all/eca-local-scanning-web-ui'

s3_BucketMap = [
        'dev'     : 'us-east-2-cdn-app-91h49n5i-dev.drcedirect.com',
        'sqa'     : 'us-east-2-cdn-app-717py9n0-sqa.drcedirect.com',
        'stg'     : 'us-east-2-cdn-app-6g11bd3h-stg.drcedirect.com',
        'loadtest': 'us-east-2-cdn-app-914552xb-loadtest.drcedirect.com',
        'td'      : 'us-east-2-cdn-app-s226ke91-td.drcedirect.com',
        'prod'    : 'us-east-2-cdn-app-1a28588f-prod.drcedirect.com'
]

// Project specific constants.
//
// LRC doesn't have a branch for each env. so, this resets the branch lists.
PROD_ACCOUNT_BRANCHES = ['master']
BRANCHES_ALWAYS_BUILT = ['', 'develop'] + PROD_ACCOUNT_BRANCHES
DEV_TEAM_CHAT_URL = 'https://chat.googleapis.com/v1/spaces/AAAARqVi1KU/messages?key=AIzaSyDdI0hCZtE6vySjMm-WEfRq3CPzqKqqsHI&token=6yglYc02qH8R_QEPa4GPyubfYe_-rzrkg0ZIcb9XkDI%3D'

//
// VARIABLES - Don't declare them with 'def' or a type.
//
buildBranch = '' // Will be chosenBranch or triggeredBranch
buildStatus = 'successful'
buildCause = ''
buildInstigator = ''
chosenBranch = ''
contributers = ''
dryRunPrefix = ''
repositoryShortName = getRepositoryShortName()
gitParamRepoRE = ".*${repositoryShortName}.git"
isAutoBuild = false // False implies the build was started from the Jenkins UI.
tasksToExec = [:]
triggeredBranch = ''

pipeline {
    options {
        ansiColor('xterm')
        // TODO keep the first failure if the build currently, still fails.
        // NOTE we keep a larger number of builds but this always clears the large output directories after every build.
        buildDiscarder(logRotator(numToKeepStr: '25', artifactNumToKeepStr: '25'))
    }

    triggers {
        issueCommentTrigger('.*test this please.*')
    }

    tools {
        nodejs NODEJS_VERSION
    }

    agent {
        node {
            label GENERIC_NODE_AGENT
        }
    }

    parameters {
        // The names of these parameters are shown on the UI.
        // If you want something fancier or with more style ro flexibility consider adding an Extended Choice that uses
        // JSON configuration and building that configuration using https://github.com/json-editor/json-editor as
        // referenced by: https://wiki.jenkins.io/display/JENKINS/Extended+Choice+Parameter+plugin

        choice(name: 'Choose_branch_from_common_list',
                description: 'Build- (Option 1 of 2) Select a common branch name to build',
                choices: BRANCHES_ALWAYS_BUILT)
        // useRepository is key to making this work even if there is only one URL used! This might have something to do
        // with using the DRC @Library which is pulled from a git repository.
        gitParameter(name: 'Choose_branch_from_git',
                description: 'Build- Select from all branches or tags',
                type: 'PT_BRANCH', branchFilter: 'origin/(.*)',
                quickFilterEnabled: true, sortMode: 'ASCENDING_SMART',
                selectedValue: 'NONE',
                useRepository: gitParamRepoRE)
        // useRepository is key to making this work even if there is only one URL used! This might have something to do
        // with using the DRC @Library which is pulled from a git repository.
        gitParameter(name: 'Choose_tag_to_deploy',
                description: 'Select from an existing tag to deploy or leave blank for the latest',
                type: 'PT_TAG', tagFilter: '*',
                quickFilterEnabled: true, sortMode: 'DESCENDING_SMART',
                selectedValue: 'NONE',
                useRepository: gitParamRepoRE)

        booleanParam(name: 'Run_unit_tests', description: 'Stage- (Recommended) Run unit tests', defaultValue: true)
        booleanParam(name: 'Run_functional_tests', description: 'Stage- (Recommended) Run end-to-end tests', defaultValue: true)
        booleanParam(name: 'Run_verification', description: 'Stage- (Recommended) Run verification (incl. vulnerability) checks', defaultValue: true)
        booleanParam(name: 'Publish_to_artifactory', description: 'Create a published version and put it in artifactory', defaultValue: isAutoBuild)

        // This is a brief overview of the functionality of this plugin:
        //   https://jenkinsci.datarecognitioncorp.com/user/gcoakley/my-views/view/Experimenting/job/glen-pipeline/pipeline-syntax/html
        //   Drill down to: Steps Reference > DSL Reference/Steps > properties > parameters > parameterDefinitions > extendedChoice
        // Sadly the most useful reference for this plugin is the source code:
        //   https://github.com/jenkinsci/extended-choice-parameter-plugin/blob/master/src/main/java/com/cwctravel/hudson/plugins/extended_choice_parameter/ExtendedChoiceParameterDefinition.java#L344
        // This seems like a good example of some powerful things this plugin can do, if you can decipher them.
        //   https://wiki.jenkins.io/display/JENKINS/Extended+Choice+Parameter+plugin
        extendedChoice(name: 'Deploy_to_environments',
                description: 'Choose environment(s) to deploy to',
                type: 'PT_CHECKBOX',
                multiSelectDelimiter: ',',
                value: 'dev,sqa,loadtest,stg,prod',
                descriptionPropertyValue: 'Development,Quality Assurance,Load Test,Staging,Production',
                defaultValue: 'dev,sqa'
        )

        extendedChoice(name: 'Deploy_to_AWS_regions',
                description: 'Choose region(s) to deploy to',
                type: 'PT_MULTI_SELECT',
                multiSelectDelimiter: ',',
                value: 'us-east-1,us-east-2',
                descriptionPropertyValue: 'us-east-1 / N. Virginia,us-east-2 / Ohio',
                defaultValue: 'us-east-1,us-east-2',
                visibleItemCount: 2
        )

        booleanParam(name: 'Reload_parameters_dry_run',
                description: 'Provides a dry-run through the script. It will examine configuration and executge ' +
                        'conditions but not perform any tasks that change data. Some parameter configuration data ' +
                        'are only stored (for display in the UI) after a successful run of a job.\n Therefore, build ' +
                        'parameter changes may not be reflected until the following run of a job.',
                defaultValue: true)
    }

    environment { // runs after SCM checkout
        buildDate = new Date().format('yyyy-MM-dd_HH.mm.ss')
        SCM_URL = scm.getUserRemoteConfigs()[0].getUrl()
    }


    stages {
        stage('Intialization') {
            steps {
                wrap([$class: 'BuildUser']) {
                    script {
                        initializeState()

                        printGlobalVariables('Finished initialization step')
                        sh "./scripts/jenkins/dump-working-env.sh"
                    }
                }
                sendToChat("Build started by ${buildInstigator}")
            }
        }

        stage('Build') {
            steps {
                withEnv(getNodeEnv()) {
                    script {
                        sh "git log -n1 $GIT_COMMIT"
                        // ref: https://wiki.jenkins.io/display/JENKINS/Git+Parameter+Plugin
                        checkout([$class                           : 'GitSCM',
                                  branches                         : [[name: "${buildBranch}"]],
                                  doGenerateSubmoduleConfigurations: false,
                                  extensions                       : [],
                                  gitTool                          : 'Default',
                                  submoduleCfg                     : [],
                                  userRemoteConfigs                : [[url          : "${GIT_URL}",
                                                                       credentialsId: '45ee37ec-f327-4ffd-84bb-c155c86087b5']]
                        ])
                        sh "${dryRunPrefix} ./scripts/jenkins/build.sh"
                    }
                }
            }
        }

        stage('Quality verification') {
            parallel {
                stage('Unit Tests') {
                    when {
                        beforeAgent true // Check conditions before starting agent because we don't need it yet.
                        expression { Run_unit_tests }
                    }
                    steps {
                        withEnv(getNodeEnv()) {
                            script {
                                assumeRole('dev')
                                sh "${dryRunPrefix} ./scripts/jenkins/test.sh"
                            }
                        }
                    }
                }

                stage('End-to-End (E2E) (Functional/feature) Tests') {
                    when {
                        beforeAgent true // Check conditions before starting agent because we don't need it yet.
                        expression { Run_functional_tests }
                    }
                    steps {
                        withEnv(getNodeEnv()) {
                            script {
                                assumeRole('dev')
                                sh "${dryRunPrefix} ./scripts/jenkins/e2e_tests.sh"
                            }
                        }
                    }
                }

                stage('Check Vulnerabilities') {
                    when {
                        beforeAgent true // Check conditions before starting agent because we don't need it yet.
                        expression { Run_verification }
                    }
                    steps {
                        withEnv(getNodeEnv()) {
                            script {
                                try {
                                    sh "${dryRunPrefix} ./scripts/jenkins/verify.sh"
                                } catch (exitCode) {
                                    complainIfVulerabilitiesExist()
                                }
                            }
                        }
                    }
                }

            } // end of parallel
        } // end of 'Quality verification' stages


        stage('Coverage Reporting') {
            steps {
                script {
                    publishHTML allowMissing: true, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'coverage',
                            reportFiles: 'index.html', reportName: 'Code Coverage Report', reportTitles: ''
                    publishHTML allowMissing: true, alwaysLinkToLastBuild: false, keepAll: true, reportDir: '.',
                            reportFiles: 'unitTestReport.html', reportName: 'Unit Test Report', reportTitles: ''
                    if (!dryRunPrefix) {
                        cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'coverage/cobertura*.xml',
                                conditionalCoverageTargets: '80, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0',
                                maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
                    }
                }
            }
        }


        stage('Package Artifacts') {
            when {
                expression { Publish_to_artifactory }
            }
            steps {
                withEnv(getNodeEnv()) {
                    sh "${dryRunPrefix} ./scripts/jenkins/package.sh $repositoryShortName $BUILD_NUMBER $SCM_URL"
                }
            }
        }

        stage('Publish to Artifactory') {
            when {
                expression { Publish_to_artifactory }
            }
            steps {
                withEnv(getNodeEnv()) {
                    script {
                        def pkgJson = null;
                        try {
                            pkgJson = readJSON(file: "./package.json")
                        } catch (FileNotFoundException) {
                            error "package.json file not found in workspace root. ls: "
                            sh "ls"
                        }
                        def artifactVersion = "${pkgJson.version}.${BUILD_NUMBER}"
                        def artifactFilename = "${repositoryShortName}-${artifactVersion}.zip"

                        if (dryRunPrefix) {
                            echo "Would deploy to artifactory: ${artifactFilename}"
                        } else {
                            uploadToArtifactory([repo     : artifactoryBucket,
                                                 pattern  : artifactFilename,
                                                 git_proj : repositoryShortName,
                                                 arti_url : ARTIFACTORY_ROOT,
                                                 isYumRepo: false])
                        }
                    }
                }
            }
            post {
                failure {
                    sendToChat("Failed to publish to artifactory.")
                }
            }
        }

        stage('Tag Branch') {
            when {
                expression { Publish_to_artifactory }
            }
            steps {
                withEnv(getNodeEnv()) {
                    withCredentials([[$class          : 'UsernamePasswordMultiBinding',
                                      credentialsId   : '45ee37ec-f327-4ffd-84bb-c155c86087b5',
                                      usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD']]) {
                        sh "${dryRunPrefix} ./scripts/jenkins/tag.sh $BUILD_NUMBER $buildDate $SCM_URL"
                    }
                }
            }
        }


        stage('Generate deployments') {
            when {
                // To be clear: if it (is NOT an AutoBuild) or
                // (it is an AutoBuild and the branch == 'develop')
                expression { !isAutoBuild || buildBranch in BRANCHES_ALWAYS_BUILT }
            }
            steps {
                script {
                    // TODO move the generation of deploy tasks to its on stage then run the deploy
                    // script tasks in parallel during 'this' stage.
                    tasksToExec = generateDeployTasks(Deploy_to_environments)
                    println tasksToExec
                }
            }
        }

        stage('Execute deployments') {
            steps {
                script { // It is imperative to have this block around the call to 'parallel' to be
                    // able to execute dynamically generated stages in this script. Other, simpler
                    // scripts do not require such.
                    parallel tasksToExec
                }
            }
        }

    }

    post { // after all stages have run
        always {
            script {
                if (buildBranch in BRANCHES_ALWAYS_BUILT) {
                    sendToChat("Build by ${buildInstigator} finished with status: ${buildStatus}")
                }
                // Delete build-created directories that take up a lot of space on the disk.
                // Do not delete (test and coverage) output which is in 'artifacts/'.
                sh 'rm -rf ./build ./dist ./node_modules'
            }
        }
    }
}


/////////////////////////////////////////////////
//            Project functions
/////////////////////////////////////////////////

/**
 * @return String[] set of environment variables as would be returned by 'env' or 'printenv'.
 */
List<String> getNodeEnv() {
    return [
            "PATH=./:./node_modules/.bin:${env.PATH}",
            "BUILD_NUMBER=${env.BUILD_NUMBER}",
            "BUILD_DATE=${buildDate}"
    ]
}

void sendToChat(String messageText) {
    def msg = "Would send chat message: " + messageText +
            " for build: job= '${env.JOB_NAME}', number= ${env.BUILD_NUMBER}, (<${env.BUILD_URL}|Link>)"
    if (dryRunPrefix) {
        echo msg
    } else {
        googlechatnotification(message: msg, url: DEV_TEAM_CHAT_URL)
    }
}

boolean iterablesIntersect(something, another) {
    something.each {
        if (it in another) {
            return true
        }
    }
    return false
}

boolean isDeployingToUpperEnv(environments) {
    return iterablesIntersect(environments, PROD_ACCOUNT_ENVS)
}

void askForPermissionInUpperEnvs(environments) {
    def askForPermission = isDeployingToUpperEnv(environments)
    if (askForPermission) {
        sendToChat("${buildInstigator} needs approval to deploy to ${environments}")
        drc_AskForPermission([message    : "Confirm",
                              name       : "Deploy to ${environments}?",
                              description: 'Type "yes" to proceed',
                              to_time    : 10,
                              to_unit    : 'MINUTES',
                              id         : "Deploy_to_${environments}",
                              submitter  : contributers])
    }
    println "Current build status after ask for permission for deploy = ${currentBuild.result}"
}

/**
 *
 * @param environment :String - the AWS account to use: 'dev' for lower environments, 'prod' for upper.
 * @param deployTargetsArray Array<Object> - signature: {*        env: String,
 *        regions?: Array<String>,
 *        askForPermission: boolean,
 *        clients?: Array<String>
 *}*        example: {*          env: "dev",
 *          regions: REGIONS,
 *          askForPermission: false,
 *          clients: CLIENTS
 *}* @return
 */
Map<String, Closure> generateDeployTasks(deployTargetsArray) {

    // deployTasks will contain the list of jobs to execute.
    def deployTasks = [:]

    deployTargetsArray.each { deploy ->
        println "Generating deploy for environment: ${deploy}."
        def deployStage = deploy

        if (currentBuild.result == 'ABORTED') {
            sendToChat("Deployment by ${buildInstigator} to ${deployStage} aborted")
            println "Exiting aborted Stage"
            return
        } else if (Choose_tag_to_deploy) {

            if (dryRunPrefix) {
                echo "Would pull files from Artifactory and push them to S3 '${S3_DEPLOY_PATH}'. "
            } else {

                sendToChat("Deployment by ${buildInstigator} to ${deployStage} is approved")

                // This assumeRole() and the chat notifications appear to run on the master (not on the slave nodes) so, the
                // queries for permission will always happen. TODO: Ensure this does not tie up the master jenkins node or the job.
                assumeRole(deployStage)

                def nodeDescriptor = (true || isUpperEnv(deployStage) ? NODE_AGENT_LABEL_PROD : NODE_AGENT_LABEL_DEV)
                REGIONS.each { region ->
                    // define each deploy task as a closure so it defers execution.
                    deployTasks["${deployStage} - ${region}"] = makeDeployStage(nodeDescriptor, deployStage, region)
                }
            }
        }
    }
    return deployTasks
}

// Using @NonCPS here causes a NullPointerException
def makeDeployStage(String nodeDescriptor, String deployStage, String region) {
    return {
        node(nodeDescriptor) {
            stage("Retrieve Artifacts. deploy to ${region} for ${deployStage}") {
//              For some reason Jenkins doesn't like this 'when' statement here.
//              Instead, I added an 'if' in generateDeployTasks().
//                when { expression { env.Choose_tag_to_deploy } }
                withEnv(getNodeEnv()) {
                    script {
                        deployAssetsTask(deployStage, region)
                    }
                }
            }
        }
    }
}

@NonCPS
// https://jenkins.io/redirect/pipeline-cps-method-mismatches/
void deployAssetsTask(String deployStage, String region) {
    echo "STARTING deployAssets to environment: ${deployStage}, region: ${region}"

    checkRPMArtifactory([arti_repo    : artifactoryBucket,
                         context      : 'all',
                         app_name     : repositoryShortName,
                         ctx_dilimiter: '-',
                         version      : env.Choose_tag_to_deploy])

    sh "${dryRunPrefix} ./scripts/jenkins/deploy.sh ${deployStage} ${region}"
    s3Bucket = s3_BucketMap[deployStage]

    assumeRole(deployStage)

    setupConfig(deployStage)
    sh "${dryRunPrefix} cat ./dist/config.json"

    // This could also be done with the AWS CLI.
    withAWS(region: "${region}") {
        s3Delete(
                bucket: "${s3Bucket}",
                path: S3_DEPLOY_PATH
        )
        s3Upload(
                bucket: "${s3Bucket}",
                file: "dist",
                path: S3_DEPLOY_PATH,
                excludePathPattern: "dist/index.html"
        )
        s3Upload(
                bucket: "${s3Bucket}",
                file: "dist/index.html",
                path: "${S3_DEPLOY_PATH}/index.html",
                cacheControl: "public, must-revalidate, proxy-revalidate, max-age=0"
        )
    }
    echo "deployAssets END  - ${deployStage} - ${region}"
}

void setupConfig(env) {
    sh "${dryRunPrefix}" + ' sed -i.bak s:\\<base\\ href=\\"/\\"\\>:\\<base\\ href=\\"/all/eca-local-scanning-web-ui/\\"\\>:g dist/index.html'

    def configJson = "`ts-node -e 'import {environment} from \"./src/environments/environment.${env}\"; console.log(JSON.stringify(environment));' `"

    // TODO Delete these keys?: 'production', 'protractor', 'localapi', 'hmr'
    configJson["client"] = 'TABE'

    writeJSON(file: './dist/config.json', json: configJson, pretty: 2)
}


/////////////////////////////////////////////////
//             Utility functions
/////////////////////////////////////////////////

/**
 * Assume the role needed to perform operations in the specified environment.
 *
 * @param environment :String - the AWS account to use: 'dev' for lower environments, 'prod' for upper.
 * @return
 */
void assumeRole(String environment) {
    def roleAccount = getAccountForEnv(environment)
    if (roleAccount == getAccountForEnv('dev')) {
        return // Prevent trying to assume the current role.
    }
    def duration = (environment in PROD_ACCOUNT_ENVS) ? PROD_PERMISSION_ACK_DURATION : DEV_PERMISSION_ACK_DURATION

    println "Assuming role for ${environment} with Account: ${roleAccount}"
    drc_AwsAssumeRole([acctNum: roleAccount,
                       appName: 'eca-form-recognition-service',
                       bldNum : env.BUILD_NUMBER,
                       timeout: duration])
}

void complainIfVulerabilitiesExist() {
    if (env.BRANCH_NAME in PROD_ACCOUNT_BRANCHES) {
        sendToChat("NPM dependency VULNERABILITIES found and need approval to continue")
        drc_AskForPermission([name       : "Bypass vulnerabilities",
                              to_time    : 20,
                              to_unit    : 'MINUTES',
                              id         : "VulnCheck${env.JOB_ID}",
                              message    : "Bypass High/Critical vulnerabilities or abort?",
                              submitter  : contributers,
                              description: 'Approve? Type "yes" to proceed'])
        if (currentBuild.result == 'ABORTED') {
            error 'Aborting build because NPM dependency vulnerabilities were found and not accepted.'
        }
    } else {
        error 'NPM dependency vulnerabilities found.'
    }
}

def ensureIsList(Object object, List defaultValue = null) {
    def result = object
    if (object) {
        if (object instanceof Array) {
            result = object as List
        } else if (object instanceof String) {
            result = object.split(',')
        }
    } else {
        result = defaultValue
    }
    println "Object as list: [ ${result.join(' | ')} ]"
    return result
}

boolean isUpperEnv(String environment) {
    return environment in PROD_ACCOUNT_ENVS
}

boolean isLowerEnv(String environment) {
    return !isUpperEnv
}

String getAccountForEnv(String environment) {
    return isUpperEnv(environment) ? drc_getAccountNumber([env: 'prod']) : drc_getAccountNumber([env: 'dev'])
}

void initializeState() {
    if (!Deploy_to_environments) {
        Deploy_to_environments = [BRANCH_NAME]
    } else {
        // Note: cannot assign to params.Deploy_to_environments.
        Deploy_to_environments = ensureIsList(Deploy_to_environments)
    }
    askForPermissionInUpperEnvs(Deploy_to_environments)

    if (env.Reload_parameters_dry_run) {
        dryRunPrefix = 'echo Would run: '
    }

    contributers = sh(script: "if [ -r CONTRIBUTERS ]; then cat CONTRIBUTERS; fi", returnStdout: true).trim()
    // Set instigator for when a build is trigger via commit, PR creation or PR merge.
    buildInstigator = sh(script: "git log -1 --format='%an' ${env.GIT_COMMIT}", returnStdout: true).trim()

    buildCause = getBuildCause()
    isAutoBuild = buildCause != 'User'

    if (!isAutoBuild && env.BUILD_USER_LAST_NAME) {
        // Remove commas from names which are in the format "LastName, FirstName".
        buildInstigator = "${env.BUILD_USER_LAST_NAME} ${env.BUILD_USER_FIRST_NAME.replace(',', '')}"
    }

    triggeredBranch = GIT_BRANCH ?: BRANCH_NAME
    buildBranch = getBuildBranch()
    if (!buildBranch) {
        error 'No source branch was set.'
    }

    artifactoryBucket = buildBranch in PROD_ACCOUNT_BRANCHES ?
            ARTIFACTORY_PROD_SEGMENT : ARTIFACTORY_DEV_SEGMENT

    if (isAutoBuild) {
        Publish_to_artifactory = buildBranch in BRANCHES_ALWAYS_BUILT
    }
}

void printGlobalVariables(String message = '') {
    println "${message}"
    println "Parameters: ${params.entrySet().join('\n\t')}"
    println "Contibuters: ${contributers}"
    println "Triggered branch: ${triggeredBranch}"
    println "Build branch: ${buildBranch}"
    println "Is automatic build: ${isAutoBuild}"
    println "Build date: ${buildDate}"
    println "Build cause: ${buildCause}"
    println "Build instigator: ${buildInstigator}"
    println "Deploy to envs: ${Deploy_to_environments}"
    println "gitParamRepoRE: ${gitParamRepoRE}"
    int counter = 1
    scm.getUserRemoteConfigs().each { println "SCM URL ${counter++}: ${it.getUrl()}" }
}

void printParams(message = '') {
    println message
    println "Choose_branch_by_typing: ${env.Choose_branch_by_typing}"
    println "Choose_branch_from_git: ${env.Choose_branch_from_git}"
    println "Choose_branch_or_tag_from_git: ${env.Choose_branch_or_tag_from_git}"
    println "Choose_branch_from_common_list: ${env.Choose_branch_from_common_list}"
    println "Build branch: ${buildBranch}\n"
}

String getRepositoryShortName() {
    def matcher = scm.getUserRemoteConfigs().first() =~ /.*github.com.*\/([^\/]*)\.git/
    if (matcher.find()) {
        return matcher.group(1)
    } else {
        println('ERROR: Could not find repository name; using "personal-testing".')
        return null
    }
}

String getBuildBranch() {
    chosenBranch = [env.Choose_branch_by_typing, env.Choose_branch_from_git, env.Choose_branch_or_tag_from_git, env.Choose_branch_from_common_list]
            .findResult { it ? it : null }
    printParams('Set buildBranch from user selections.')
    buildBranch = chosenBranch ?: [env.GIT_BRANCH, BRANCH_NAME]
            .findResult { it in BRANCHES_ALWAYS_BUILT ? it : null }
    printParams('If not unset, set buildBranch from Jenkins-SCM environment variable.')
    return buildBranch
}

String getBuildCause() {
    println('Build causes: ' + currentBuild.getBuildCauses().toString())

    // Get the set of build causes matching each of the given class names.

    // Build was started by a commit.
    if (currentBuild.getBuildCauses('jenkins.branch.BranchEventCause')) {
        return 'SCM'
    }
    // Build was started manually in the Jenkins UI by user.
    else if (currentBuild.getBuildCauses('hudson.model.Cause$UserIdCause')) {
        return 'User'
    }
    // Build was started by a timer / periodically scheduled build.
    else if (currentBuild.getBuildCauses('hudson.triggers.TimerTrigger$TimerTriggerCause')) {
        return 'Timer'
    }
    return ''
}
