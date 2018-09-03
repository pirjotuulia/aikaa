package aika.aikaa.objects;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
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
    private List<Role> roles = new ArrayList<>();
    private String email;
    private Integer addressid;
    private String phonenumber;
    private String picurl;

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

    @JsonIgnore
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

    public Integer getAddressid() {
        return addressid;
    }

    public void setAddressid(Integer addressid) {
        this.addressid = addressid;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getPicurl() {
        return picurl;
    }

    public void setPicurl(String picurl) {
        this.picurl = picurl;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", roles=" + roles +
                '}';
    }
}
