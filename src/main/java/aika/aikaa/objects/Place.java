package aika.aikaa.objects;

import org.springframework.stereotype.Component;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Component
public class Place {
    @Id
    @GeneratedValue
    private Integer id;
    private String name;
    private Address address;
    private String mapurl;

    public Place(String name, Address address) {
        this.name = name;
        this.address = address;
    }

    public Place(String name) {
        this(name, null);
    }

    public Place() {
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

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getMapurl() {
        return mapurl;
    }

    public void setMapurl(String mapurl) {
        this.mapurl = mapurl;
    }
}
