import util.DRCLibraryPipelineSpecBase

import static org.assertj.core.api.Assertions.assertThat

class DRCLibrary_getAccountNumSpec extends DRCLibraryPipelineSpecBase {

  def "test library code was downloaded"() {
    when:
    Script script = pipelineTester.loadScript("drc_getAccountNumber.groovy")

    then:
    pipelineTester.assertJobStatusSuccess()
  }

  def "test a library method can be called"() {
    when:
    Script script = pipelineTester.loadScript("drc_getAccountNumber.groovy")
    def result = script.invokeMethod('call', [env:'dev'])

    then:
    pipelineTester.assertJobStatusSuccess()
    assertThat(result. is('177429746880'))
  }
}
