package aika.aikaa.objects;

import org.springframework.stereotype.Component;

import javax.persistence.*;
import javax.persistence.Id;
import java.util.List;

@Component
public class Work {
    @Id
    @GeneratedValue
    private Integer id;
    private String work;
    private String composer;
    private String Instrumentation;
    private Integer musicians;//minimum number of musicians needed;
    private Integer durationInMinutes;
    private List<Role> roleList;

    public Work() {
    }

    public Work(String work, String composer, String instrumentation, Integer musicians, Integer durationInMinutes) {
        this.work = work;
        this.composer = composer;
        Instrumentation = instrumentation;
        this.musicians = musicians;
        this.durationInMinutes = durationInMinutes;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getWork() {
        return work;
    }

    public void setWork(String work) {
        this.work = work;
    }

    public String getComposer() {
        return composer;
    }

    public void setComposer(String composer) {
        this.composer = composer;
    }

    public String getInstrumentation() {
        return Instrumentation;
    }

    public void setInstrumentation(String instrumentation) {
        Instrumentation = instrumentation;
    }

    public Integer getMusicians() {
        return musicians;
    }

    public void setMusicians(Integer musicians) {
        this.musicians = musicians;
    }

    public Integer getDurationInMinutes() {
        return durationInMinutes;
    }

    public void setDurationInMinutes(Integer durationInMinutes) {
        this.durationInMinutes = durationInMinutes;
    }

    public List<Role> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Role> roleList) {
        this.roleList = roleList;
    }

    @Override
    public String toString() {
        return "Work{" +
                "id=" + id +
                ", work='" + work + '\'' +
                ", composer='" + composer + '\'' +
                ", Instrumentation='" + Instrumentation + '\'' +
                ", musicians=" + musicians +
                ", durationInMinutes=" + durationInMinutes +
                ", roleList=" + roleList +
                '}';
    }
}
