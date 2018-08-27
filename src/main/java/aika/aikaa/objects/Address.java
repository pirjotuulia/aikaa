package aika.aikaa.objects;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;

public class Address {
    @Id
    @GeneratedValue
    private Integer id;
    private String streetAddress;
    private String postcode;
    private String country;
    private String district;

    public Address(String streetAddress, String postcode, String country, String district) {
        this.streetAddress = streetAddress;
        this.postcode = postcode;
        this.country = country;
        this.district = district;
    }

    public Address() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStreetAddress() {
        return streetAddress;
    }

    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }
}
