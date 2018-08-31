package aika.aikaa.controllers;

import aika.aikaa.daos.RoleDao;
import aika.aikaa.objects.Role;
import aika.aikaa.objects.RoleCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

@RestController
public class RoleController {
    private RoleDao rd;

    public RoleController(@Autowired RoleDao roleDao) {
        this.rd = roleDao;
    }

    @GetMapping("/api/roles")
    public List<Role> allRoles() {
        return rd.allRoles();
    }

    @GetMapping("/api/roles/{id}")
    public Role roleById(@PathVariable Integer id) {
        return rd.oneRole(id);
    }
    @PostMapping("/api/roles")
    public Role addRole(@RequestBody Role role) {
        return rd.createRole(role);
    }

    @PutMapping("/api/roles/{id}")
    public boolean updateRole(@RequestBody Role role, @PathVariable Integer id) {
        return rd.updateRole(role, id);
    }

    @DeleteMapping("/api/roles/{id}")
    public boolean deleteRole(@PathVariable Integer id) {
        return rd.deleteRole(id);
    }

    @GetMapping("/api/rolecategories")
    public List<RoleCategory> allRoleCategories() {
        return rd.getAllRoleCategories();
    }
}
