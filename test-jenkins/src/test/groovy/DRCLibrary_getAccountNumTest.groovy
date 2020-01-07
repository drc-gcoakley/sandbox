
import org.junit.Test
import util.DRCLibraryPipelineTestBase

import static org.assertj.core.api.Assertions.assertThat

class DRCLibrary_getAccountNumTest extends DRCLibraryPipelineTestBase {

  @Test
  void "test library code was downloaded"() throws Exception {
    Script script = loadScript("drc_getAccountNumber.groovy")
    assertJobStatusSuccess()
  }

  @Test
  void "test a library method can be called"() throws Exception {
    Script script = loadScript("drc_getAccountNumber.groovy")
    def result = script.invokeMethod('call', [env:'dev'])
    assertJobStatusSuccess()
    assertThat(result. is('177429746880'))
  }
}
