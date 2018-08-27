package aika.aikaa.controllers;

import aika.aikaa.daos.UserDao;
import aika.aikaa.objects.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserController {
    private UserDao ud;

    public UserController(@Autowired UserDao userDao) {
        this.ud = userDao;
    }

    @GetMapping("/api/users")
    public List<User> allUsers() {
        return ud.listOfAllUsers();
    }
}