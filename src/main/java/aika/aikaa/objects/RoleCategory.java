package aika.aikaa.objects;

import org.springframework.stereotype.Component;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Component
public class RoleCategory {
    @Id
    @GeneratedValue
    private Integer id;
    private String name;

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
}
