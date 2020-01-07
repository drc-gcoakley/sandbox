package util

import org.junit.Test

import static org.assertj.core.api.Assertions.assertThat

class DRCLibraryPipelineTestBaseTest extends DRCLibraryPipelineTestBase {

    @Test
    void testExecuteWithLibrary() {
        loader.loadFullLibrary()
        // TODO devise a way to make straight forward calls such as this:
//        def result = loader.executeWithLibrary("drc_SharedPipelineCanary('human')")
//        assertThat(result, is("Hello, human."))
    }

}
