package aika.aikaa.controllers;

import aika.aikaa.daos.RoleDao;
import aika.aikaa.objects.Role;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class RoleController {
    private RoleDao rd;

    @GetMapping("/api/roles")
    public List<Role> allRoles() {
        return rd.allRoles();
    }
}
