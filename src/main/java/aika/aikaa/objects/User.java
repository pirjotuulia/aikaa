package aika.aikaa.objects;

import org.springframework.stereotype.Component;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.util.ArrayList;
import java.util.List;

@Component
public class User {
    @Id
    @GeneratedValue
    private Integer id;
    private String name;
    private Integer userLevel;
    private List<Role> roles;

    public User(String name, Integer userLevel, List<Role> roles) {
        this.name = name;
        this.userLevel = userLevel;
        this.roles = roles;
    }

    public User(String name, Integer userLevel) {
        this(name, userLevel, new ArrayList<>());
    }

    public User() {
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

    public Integer getUserLevel() {
        return userLevel;
    }

    public void setUserLevel(Integer userLevel) {
        this.userLevel = userLevel;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", userLevel=" + userLevel +
                ", roles=" + roles +
                '}';
    }
}
