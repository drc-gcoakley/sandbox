import util.DRCLibraryPipelineSpecBase

import static org.assertj.core.api.Assertions.assertThat

class CurrentJenkinsfileSpec extends DRCLibraryPipelineSpecBase {

  def "test all library code could be loaded"() {
    when:
    pipelineTester.loader.loadFullLibrary()

    // TODO BasePipelineTest nor PipelineTestHelper or Jenkins-pipeline-unit seems to understand any of the following
    // calls/commands: pipeline, agent, tools, environment, parameters, stages.  There are undoubtably more such
    // methods which would have to be implemented for completeness. Extension points exists to do this.

//    pipelineTester.loader.loader.runScript('Jenkinsfile')

    then:
    pipelineTester.assertJobStatusSuccess()
  }

}
