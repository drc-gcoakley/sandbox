@Library('DRC_Global_Pipeline_Libraries@v1.3.0')

// CONSTANTS
//
def leAcctNum = "177429746880"
def prodAcctNum = "385888483640"
def prodAccountBranches = ['master', 'staging']
def branchesAlwaysBuilt = ['develop', 'sqa'] + prodAccountBranches
def clients = ['tabe']
def regions = ['us-east-1', 'us-east-2']
def stageDataList = [
	{ name: 'runUnitTests', defaultAutoValue: true, defaultManualValue: true },
	{ name: 'runIntTests',  defaultAutoValue: true, defaultManualValue: true },
	{ name: 'runVulnCheck', defaultAutoValue: true, defaultManualValue: true },
//	{ name: 'runStaticAnalysis', defaultAutoValue: true,  defaultManualValue: true },
	{ name: 'uploadMasterFormImages', defaultAutoValue: true,  defaultManualValue: true },
]

// When I declared this with 'def' it was not seen as having a value in all places.
devTeamChatUrl = 'https://chat.googleapis.com/v1/spaces/AAAARqVi1KU/messages?key=AIzaSyDdI0hCZtE6vySjMm-WEfRq3CPzqKqqsHI&token=6yglYc02qH8R_QEPa4GPyubfYe_-rzrkg0ZIcb9XkDI%3D'

// VARIABLES
//
def buildInstigator = ''
def isAutoBuild = false;

boolean isCollectionOrArray(object) {
    [Collection, Object[]].any { it.isAssignableFrom(object.getClass()) }
}

pipeline {
  tools {
    nodejs 'NODE_8_LTS'
  }

  environment {
    SCM_URL = scm.getUserRemoteConfigs()[0].getUrl()
    buildInstigator = sh(returnStdout: true, script: "git log -1 --format='%an' ${env.GIT_COMMIT}").trim()
  }

  parameters {
	booleanParam(description: 'Run Unit Tests', 		name: 'runUnitTests',  defaultValue: isAutoBuild)
	booleanParam(description: 'Run integration Tests', name: 'runIntTests',   defaultValue: isAutoBuild)
	booleanParamdescription: 'Run vulnerability check', name: 'runVulnCheck',  defaultValue: isAutoBuild)
//	booleanParam()description: 'Run static analysis', 	name: 'runStaticAnalysis', defaultValue: isAutoBuild)
	booleanParam(description: 'Please only upload master form images if some have changed',
		name: 'uploadMasterFormImages',  defaultValue: isAutoBuild)
    choice(description: 'Select a common branch', name: 'branchSelected', choices: branchesAlwaysBuilt, defaultValue: '')
	gitParameter(description: 'Select a branch', name: 'GIT_BRANCH',
				 branchFilter: 'refs/heads/(.*)', tagFilter: '*', type: 'PT_BRANCH_TAG'
				 branch: ${branchTyped || branchSelected || env.GIT_BRANCH},
				 quickFilterEnabled: true, sortMode: 'ASCENDING_SMART')
//	string(description: 'Enter a custom branch', name: 'branchTyped', defaultValue: '')
  }

    // TODO: Change default back to false when we are no longer expiring master forms every 14 days.
    booleanParam(defaultValue: true, description: 'Please only upload master form images if some have changed', name: 'uploadMasterFormImages')
  }

  options {
    ansiColor('xterm')
    buildDiscarder(logRotator(daysToKeepStr: '7', artifactNumToKeepStr: '50'))
  }

  triggers {
    issueCommentTrigger('.*test this please.*')
  }

  agent {
    node {
      label 'coel7_agent_aws&&aws&&role_prod'
    }
  }

  stages {
	stage('Conditional execution') {
		// https://jenkins.io/doc/book/pipeline/syntax/#when
		when {
			beforeAgent true // Check conditions before starting agent
			anyOf {
				expression { BRANCH_NAME in branchesAlwaysBuilt }
				tag "release-*";
			}
		}
		steps {
			echo "Conditionally executing stage."
		}
	}
  }
  post {
    failure {
      script {
        if (GIT_BRANCH == 'develop' || GIT_BRANCH == 'master') {
          googlechatnotification(message: "Build started by ${buildInstigator} failed for " +
            "${env.JOB_NAME} [${env.BUILD_NUMBER}], (<${env.BUILD_URL}|Link>)", url: devTeamChatUrl)
        }
      }
    }
    success {
      script {
        if ((GIT_BRANCH == 'develop' || GIT_BRANCH == 'master') && currentBuild?.getPreviousBuild()?.result == 'FAILURE') {
          googlechatnotification(message: "Build started by ${buildInstigator} was successful for " +
            "${env.JOB_NAME} [${env.BUILD_NUMBER}], (<${env.BUILD_URL}|Link>)", url: devTeamChatUrl)
        }
      }
    }
  }
}
