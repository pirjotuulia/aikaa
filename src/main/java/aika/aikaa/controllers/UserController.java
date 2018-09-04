package aika.aikaa.controllers;

import aika.aikaa.daos.UserDao;
import aika.aikaa.objects.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/api/users/{id}")
    public User oneUser(@PathVariable Integer id) {
        return ud.oneUserWithRoles(id);
    }

    @PostMapping("/api/users")
    public User addUser(@RequestBody User user) {
        return ud.createUser(user);
    }

    @PutMapping("/api/users/{id}")
    public boolean updateUser(@RequestBody User user, @PathVariable Integer id) {
        return ud.updateUser(user, id);
    }

    @DeleteMapping("/api/users/{id}")
    public boolean deleteUser(@PathVariable Integer id) {
        return ud.deleteUser(id);
    }

    @PostMapping("/api/userrole/{id}/{roleId}")
    public boolean addUserRole(@PathVariable Integer id, @PathVariable Integer roleId) {
        return ud.addUserRole(roleId,id);
    }

    @DeleteMapping("/api/userrole/{id}/{roleId}")
    public boolean deleteUserRole(@PathVariable Integer id, @PathVariable Integer roleId) {
        return ud.deleteUserRole(roleId,id);
    }
}