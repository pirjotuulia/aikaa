package aika.aikaa.controllers;

import aika.aikaa.daos.WorkDao;
import aika.aikaa.objects.Role;
import aika.aikaa.objects.Work;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class WorkController {
    private WorkDao wd;

    public WorkController(@Autowired WorkDao wd) {
        this.wd = wd;
    }

    @GetMapping("/api/works")
    public List<Work> allMusicalWorks() {
        return wd.allMusicalWorks();
    }

    @GetMapping("/api/works/{id}")
    public Work oneWork(@PathVariable Integer id) {
        return wd.oneWork(id);
    }

    @PostMapping("/api/works")
    public Work createWork(@RequestBody Work work) {
        return wd.createWork(work);
    }

    @PutMapping("/api/works/{id}")
    public boolean updateWork(@RequestBody Work work, @PathVariable Integer id) {
        return wd.updateWork(work, id);
    }

    @DeleteMapping("/api/works/{id}")
    public boolean deleteWork(@PathVariable Integer id) {
        return wd.deleteWork(id);
    }

    @GetMapping("/api/workroles")
    public List<Work> allWorksWithRoleDetails() {
        return wd.allWorksWithRoleDetails();
    }

    @GetMapping("/api/workroles/{id}")
    public Work worksWithRoleDetails(@PathVariable Integer id) {
        return wd.oneWorkWithRoleDetails(id);
    }

    @PostMapping("/api/workroles/{id}")
    public List<Role> addRoleDetailsToWorkById(@RequestBody List<Integer> roleList, @PathVariable Integer id) {
        return wd.addRoleDetailsToWorkById(roleList, id);
    }

    @DeleteMapping("/api/workroles/{id}")
    public boolean deleteRolesFromWorkById(@RequestBody List<Integer> roleList, @PathVariable Integer workid) {
        return wd.deleteRolesFromWork(roleList, workid);
    }
}
