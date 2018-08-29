package aika.aikaa.controllers;

import aika.aikaa.daos.WorkDao;
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
    public List<Work> allWorks() {
        return wd.allWorks();
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
}
