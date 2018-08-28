package aika.aikaa.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
public class LoginController {

    @GetMapping("/user")
    public Principal user(Principal principal) {
        System.out.println(principal.getName());
        return principal;
    }
    @PostMapping("/auth")
    public void login(@RequestBody String idToken) {
//        userAuth.check(idToken);
    }
}
