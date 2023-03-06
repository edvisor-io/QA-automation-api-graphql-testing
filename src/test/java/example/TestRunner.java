package example;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TestRunner {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:example")
                //.outputCucumberJson(true)
                .parallel(1);
                System.out.println("minha env: ");
                System.out.println(System.getenv("karate.env"));
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}