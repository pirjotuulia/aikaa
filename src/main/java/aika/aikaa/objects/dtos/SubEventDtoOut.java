package aika.aikaa.objects.dtos;

import java.time.LocalDateTime;

public class SubEventDtoOut {
    private int id;
    private String name;
    private String type;
    private LocalDateTime begin;
    private LocalDateTime ending;
    private String placename;
    private Integer placeid;
    private String eventname;
    private Integer eventid;
    private String workname;
    private Integer workid;

    public Integer getWorkid() {
        return workid;
    }

    public void setWorkid(Integer workid) {
        this.workid = workid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
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

    public String getPlacename() {
        return placename;
    }

    public void setPlacename(String placename) {
        this.placename = placename;
    }

    public Integer getPlaceid() {
        return placeid;
    }

    public void setPlaceid(Integer placeid) {
        this.placeid = placeid;
    }

    public String getEventname() {
        return eventname;
    }

    public void setEventname(String eventname) {
        this.eventname = eventname;
    }

    public Integer getEventid() {
        return eventid;
    }

    public void setEventid(Integer eventid) {
        this.eventid = eventid;
    }

    public String getWorkname() {
        return workname;
    }

    public void setWorkname(String workname) {
        this.workname = workname;
    }
}
