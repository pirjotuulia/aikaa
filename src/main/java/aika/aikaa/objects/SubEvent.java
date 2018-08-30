package aika.aikaa.objects;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class SubEvent {
    @Id
    @GeneratedValue
    private Integer id;
    private String name;
    private String type;
    private LocalDateTime begin;
    private LocalDateTime ending;
    private Place place;
    private Event event;
    private List<User> castAndCrew;
    private Work work;

    public SubEvent(String name, String type, LocalDateTime begin, LocalDateTime ending, Place place, Event event, List<User> castAndCrew, Work work) {
        this.name = name;
        this.type = type;
        this.begin = begin;
        this.ending = ending;
        this.place = place;
        this.event = event;
        this.castAndCrew = castAndCrew;
        this.work = work;
    }

    public SubEvent(String name, String type, Event event) {
        this(name, type, null, null, null, event, new ArrayList(), null);
    }

    public SubEvent() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public LocalDateTime getBegin() {
        return begin;
    }

    public void setBegin(LocalDateTime begin) {
        this.begin = begin;
    }

    public LocalDateTime getEnding() {
        return ending;
    }

    public void setEnding(LocalDateTime ending) {
        this.ending = ending;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public List<User> getCastAndCrew() {
        return castAndCrew;
    }

    public void setCastAndCrew(List<User> castAndCrew) {
        this.castAndCrew = castAndCrew;
    }

    public Work getWork() {
        return work;
    }

    public void setWork(Work work) {
        this.work = work;
    }

    @Override
    public String toString() {
        return "SubEvent{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", begin=" + begin +
                ", ending=" + ending +
                ", place=" + place +
                ", event=" + event +
                ", castAndCrew=" + castAndCrew +
                ", work=" + work +
                '}';
    }
}
