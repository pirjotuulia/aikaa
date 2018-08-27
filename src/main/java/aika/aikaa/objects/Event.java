package aika.aikaa.objects;

import org.springframework.stereotype.Component;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.util.List;

@Component
public class Event {
    @Id
    @GeneratedValue
    private Integer id;
    private String name;
    private List<SubEvent> subEvents;
    private List<Work> works;

    public Event(String name, List<SubEvent> subEvents, List<Work> works) {
        this.name = name;
        this.subEvents = subEvents;
        this.works = works;    }

    public Event() {
    }

    public Event(String name) {
        this.name = name;
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

    public List<SubEvent> getSubEvents() {
        return subEvents;
    }

    public void setSubEvents(List<SubEvent> subEvents) {
        this.subEvents = subEvents;
    }

    public List<Work> getWorks() {
        return works;
    }

    public void setWorks(List<Work> works) {
        this.works = works;
    }

    @Override
    public String toString() {
        return "Event{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", subEvents=" + subEvents +
                ", works=" + works +
                '}';
    }
}
