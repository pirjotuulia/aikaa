package aika.aikaa.controllers;

import aika.aikaa.daos.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@RestController
public class LoginController {
    private UserDao ud;

    public LoginController(@Autowired UserDao userDao) {
        this.ud = userDao;
    }

    @GetMapping("/user")
    public Principal user(Principal principal) {
        System.out.println(principal.getName());
        return principal;
    }
}
