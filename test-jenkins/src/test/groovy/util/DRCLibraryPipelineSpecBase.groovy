package util

import spock.lang.Specification

class DRCLibraryPipelineSpecBase extends Specification {

  public DRCLibraryPipelineTestBase pipelineTester = new DRCLibraryPipelineTestBase()

  /**
   * Performs configuration for unit tests automatically. If this methods needs to be overridden by a subclass then
   * its setUp() should call this class' setUpDrcLibrary() before calling super.setUp().
   * @throws Exception
   */
  void setup() throws Exception {
    pipelineTester.setUp()
  }

}
