package examples.get_resource;

import com.intuit.karate.junit5.Karate;

public class GetResourceReqresInRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("getResourceReqresIn").relativeTo(getClass());
    }

}
