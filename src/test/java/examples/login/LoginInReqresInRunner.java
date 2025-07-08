package examples.login;

import com.intuit.karate.junit5.Karate;

public class LoginInReqresInRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("loginInReqresIn").relativeTo(getClass());
    }

}
