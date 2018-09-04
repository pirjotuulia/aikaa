package aika.aikaa.controllers;

import aika.aikaa.daos.EventDao;
import aika.aikaa.daos.WorkDao;
import aika.aikaa.objects.Role;
import aika.aikaa.objects.Work;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class WorkController {
    private WorkDao wd;
    private EventDao ed;

    public WorkController(@Autowired WorkDao wd, @Autowired EventDao ed) {
        this.wd = wd;
        this.ed = ed;
    }

    @GetMapping("/api/works")
    public List<Work> allMusicalWorks() {
        return wd.allMusicalWorks();
    }

    @GetMapping("/api/works/{id}")
    public Work oneWork(@PathVariable Integer id) {
        return wd.oneWorkWithRoleDetails(id);
    }

    @PostMapping("/api/works")
    public Work createWork(@RequestBody Work work, @RequestParam("event") boolean event, @RequestParam("eventid") Integer eventid) {
        Work created = wd.createWork(work);
        if (event) {
            boolean onnistui = ed.addWorkToEvent(eventid, created.getId());
        }
        return created;
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
    public boolean deleteRoleFromWorkByWorkroleId(@PathVariable Integer id) {
        return wd.deleteWorkRole(id);
    }
}
