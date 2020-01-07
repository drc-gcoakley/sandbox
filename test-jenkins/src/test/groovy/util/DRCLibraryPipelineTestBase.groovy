package util

import com.lesfurets.jenkins.unit.BasePipelineTest
import org.junit.Before

class DRCLibraryPipelineTestBase extends BasePipelineTest {

  public static DRCLibraryPipelineTestAdapter loader

  /**
   * Performs configuration for unit tests automatically. If this methods needs to be overridden by a subclass then
   * its setUp() should call this class' setUpDrcLibrary() before calling super.setUp().
   * @throws Exception
   */
  @Override
  @Before
  void setUp() throws Exception {
    loader = new DRCLibraryPipelineTestAdapter()
    loader.setUpDrcLibrary(this)
    super.setUp()
  }

}
