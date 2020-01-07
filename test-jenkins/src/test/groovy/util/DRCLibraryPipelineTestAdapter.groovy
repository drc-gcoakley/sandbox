package util

import com.lesfurets.jenkins.unit.BasePipelineTest
import com.lesfurets.jenkins.unit.PipelineTestHelper
import com.lesfurets.jenkins.unit.global.lib.GitSource
import com.lesfurets.jenkins.unit.global.lib.LibraryConfiguration
import groovy.io.FileType

/**
 * After invoking the setup of adapter in a test can use the following to call a method from the library. First,
 * load the source file containing the method, then call it can call/invoke a method using 'invokeMethod'.
 *
 *     Script script = loadScript("drc_getAccountNumber.groovy")
 *     def result = script.invokeMethod('call', [env:'dev'])
 *
 * The *PipelineTest object that needs to be injected into this class provides some helpful methods for setup and
 * verification of the pipline under test.
 *
 * NOTES: To use this you'll primarily need to have a build tool to include the necessary libraries. This repository
 * uses ' gradle' and the 'build.gradle' script in the root to do this. The build.gradle in the root of this project
 * only supports these Pipeline tests so, it may be copied unchanged into your own. Note, gradle does not know how to
 * use Java v12 on a Mac. Version 8 does work. I have not tried version 10.
 *
 * To add gradle to your project:
 *    1. ` brew install gradle `
 *    2. In your workspace root: ` gradle init `
 *    3. Run this to find your installed java versions: ` /usr/libexec/java_home --verbose `
 *    4. Create a script in that same directory, perhaps, called 'grj8' with contents like this:
 *        ```
 *        export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home
 *        ./gradlew
 *        ```
 *    5. Make the script executable: ` chmod ugo+x grj8`
 *
 * FUTURE: This class could preload all of the source files from the library.
 */
class DRCLibraryPipelineTestAdapter {

  static String LOCAL_LIB_PATH = './build/classes/groovy/test/'
  static String REPO_URL = 'https://github.com/DataRecognitionCorporation/drc_jenkins.git'
  static String REPO_NAME = 'drc_jenkins'
  static String BRANCH_OR_TAG = 'develop' // Could also use some version tag, such as 'v1.6.0'.

  private BasePipelineTest basePipelineTest
  private Binding libraryBinding

  /**
   * This is called automatically by all test classes which subclass this. Must be called before BasePipelineUnit.setUp().
   * @throws Exception
   */
  void setUpDrcLibrary(BasePipelineTest basePipelineTest) throws Exception {
    this.basePipelineTest = basePipelineTest;

    GitSource jenkinsRepo = retreiveLibrary()
    registerLibraryForTest(jenkinsRepo)
    configureLoaderForTest()
  }

  PipelineTestHelper getLoader() {
    assert basePipelineTest.helper.isInitialized()
    return basePipelineTest.helper
  }

  void loadFullLibrary() {
    def scriptNames = FileTreeNameCollector.collectFrom(LOCAL_LIB_PATH, FileType.FILES, { it =~ /.*\.groovy/ })
    libraryBinding = new Binding();
    scriptNames.each { basePipelineTest.helper.loadScript(it, scriptContext) }
  }

  Object executeWithLibrary(File groovyScriptFile) {
    return basePipelineTest.helper.runScript(groovyScriptFile)
  }

  ///////////////////////////////////////////////
  // Methods below should rarely be needed.
  ///////////////////////////////////////////////

  GitSource retreiveLibrary() {
    new File(LOCAL_LIB_PATH).mkdirs()

    // Download the repository for the shared library. I don't know the purpose of passing jenkinsRepo to 'retriever()'
    // in the 'library()' builder call below but, it certainly doesn't invoke the retrieve().
    GitSource jenkinsRepo = GitSource.gitSource(REPO_URL)
    jenkinsRepo.retrieve(REPO_NAME, BRANCH_OR_TAG, LOCAL_LIB_PATH)
    return jenkinsRepo
  }

  void registerLibraryForTest(GitSource jenkinsRepo) {
    def library = LibraryConfiguration.library()
            .name(REPO_NAME)
            .allowOverride(false)
            .retriever(jenkinsRepo)
            .targetPath(LOCAL_LIB_PATH)
            .defaultVersion(BRANCH_OR_TAG)
            .implicit(true)
            .build()
    basePipelineTest.helper.registerSharedLibrary(library)
  }

  void configureLoaderForTest() {
    String localLibDirName = "${LOCAL_LIB_PATH}${REPO_NAME}@${BRANCH_OR_TAG}/"
    String[] possibleLibSrcPaths = ['./', 'vars/', 'src/', 'src/main/', 'src/main/groovy/'].collect {
      return localLibDirName + it
    }
    basePipelineTest.setScriptRoots(possibleLibSrcPaths)
    basePipelineTest.setScriptExtension('groovy')
  }

}
