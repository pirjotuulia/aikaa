package aika.aikaa.controllers;

import aika.aikaa.daos.EventDao;
import aika.aikaa.objects.Event;
import aika.aikaa.objects.SubEvent;
import aika.aikaa.objects.dtos.SubEventDtoIn;
import aika.aikaa.objects.dtos.SubEventDtoOut;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@RestController
public class EventController{
    private EventDao ed;

    public EventController(@Autowired EventDao eventDao) {
        this.ed = eventDao;
    }

    @GetMapping("/api/events")
    public List<Event> allEventsWithDetails() {
        return ed.allEventsWithEverything();
    }

    @GetMapping("/api/events/{id}")
    public Event oneEventById(@PathVariable Integer id) {
        return ed.oneEventWithEverything(id);
    }

    @PostMapping("/api/events")
    public Event createEvent(@RequestBody Event event) {
        return ed.createEvent(event);
    }

    @PutMapping("/api/events/{id}")
    public boolean updateEvent(@RequestBody Event event, @PathVariable Integer id) {
        return ed.updateEvent(event, id);
    }

    @DeleteMapping("/api/events/{id}")
    public boolean deleteEvent(@PathVariable Integer id) {
        return ed.deleteEvent(id);
    }

    @PostMapping("/api/events/{eventid}/works/{workid}")
    public boolean addWorkToEvent(@PathVariable Integer eventid, @PathVariable Integer workid) {
        return ed.addWorkToEvent(eventid, workid);
    }
    @DeleteMapping("/api/events/{eventid}/works/{workid}")
    public boolean deleteWorkFromEvent(@PathVariable Integer eventid, @PathVariable Integer workid) {
        return ed.deleteWorkFromEvent(eventid, workid);
    }

    @GetMapping("/api/subevents")
    public List<SubEventDtoOut> allSubEvents() {
        return ed.allSubEvents();
    }

    @GetMapping("/api/subevents/{id}")
    public SubEventDtoOut oneSubEventById(@PathVariable Integer id) {
        return ed.oneSubEventDtoOutById(id);
    }

    @PostMapping("/api/subevents")
    public SubEvent createSubEvent(@RequestBody SubEventDtoIn subEventDtoIn) {
        return ed.createSubEvent(subEventDtoIn);
    }

    @PutMapping("/api/subevents/{id}")
    public boolean updateSubEvent(@RequestBody SubEventDtoIn subEvent, @PathVariable Integer id) {
        return ed.updateSubEvent(subEvent, id);
    }

    @DeleteMapping("/api/subevents/{id}")
    public boolean deleteSubEvent(@PathVariable Integer id) {
        return ed.deleteSubEvent(id);
    }
}
