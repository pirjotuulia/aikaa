package aika.aikaa.objects.dtos;

import java.time.LocalDateTime;

public class SubEventDtoIn {

    private String name;
    private String type;
    private LocalDateTime begin;
    private LocalDateTime ending;
    private Integer placeId;
    private Integer eventId;
    private Integer workId;

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

    public Integer getPlaceId() {
        return placeId;
    }

    public void setPlaceId(Integer placeId) {
        this.placeId = placeId;
    }

    public Integer getEventId() {
        return eventId;
    }

    public void setEventId(Integer eventId) {
        this.eventId = eventId;
    }

    public Integer getWorkId() {
        return workId;
    }

    public void setWorkId(Integer workId) {
        this.workId = workId;
    }

    @Override
    public String toString() {
        return "SubEventDtoIn{" +
                "name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", begin=" + begin +
                ", ending=" + ending +
                ", placeId=" + placeId +
                ", eventId=" + eventId +
                ", workId=" + workId +
                '}';
    }
}
