package aika.aikaa.objects;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;

public class Role implements Comparable<Role> {
    @Id
    @GeneratedValue
    private Integer id;
    private String name;
    private String category;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Role(String name) {
        this.name = name;
    }

    public Role() {
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

    @Override
    public int compareTo(Role r) {
        if (this.category.equals(r.category)) {
            return this.name.compareTo(r.name);
        } else  {
            return this.category.compareTo(r.category);
        }
    }
}
