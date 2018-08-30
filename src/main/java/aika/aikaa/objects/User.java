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
    private String googleid;
    private String email;

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

    public List<String> getUserLevelAsString() {
        List<String> userLevels = new ArrayList<>();
        if (userLevel>3) {
            userLevels.add("ROLE_GUEST");
        }
        if (userLevel <= 3) {
            userLevels.add("ROLE_USER");
        }
        if (userLevel <= 2) {
            userLevels.add("ROLE_ADMIN");
        }
        if (userLevel == 1) {
            userLevels.add("ROLE_SUPERADMIN");
        }
        return userLevels;
    }


    public String getGoogleid() {
        return googleid;
    }

    public void setGoogleid(String googleid) {
        this.googleid = googleid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
