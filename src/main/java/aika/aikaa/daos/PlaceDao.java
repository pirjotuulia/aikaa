package aika.aikaa.daos;

import aika.aikaa.objects.Address;
import aika.aikaa.objects.Place;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import javax.xml.transform.Result;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Component
public class PlaceDao {
    private JdbcTemplate jdbcTemplate;

    public PlaceDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Place> listOfAllPlaces() {
        String sql = "SELECT place.*, address.streetaddress, address.postcode, address.country, address.district FROM place JOIN address WHERE place.addressId = address.id;";
        List<Place> placeList = jdbcTemplate.query(sql, new PlaceMapper());
        return placeList;
    }

    public Place onePlace(Integer id) {
        String sql = "SELECT place.*, address.streetaddress, address.postcode, address.country, address.district FROM place JOIN address WHERE place.id=? AND place.addressId = address.id;";
        Place place = (Place) jdbcTemplate.queryForObject(sql, new Object[]{id}, new PlaceMapper());
        return place;
    }

    public Place createPlace(Place place) {
        if (place.getAddress().getId() == null) {
            place.getAddress().setId(addAddress(place.getAddress()).getId());
        }
        String sql = "INSERT INTO place (name, addressId) VALUES (?,?);";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, place.getName());
            ps.setInt(2, place.getAddress().getId());
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = keyHolder.getKey().intValue();
            place.setId(id);
        }
        return place;
    }

    public boolean updatePlace(Place place, Integer id) {
        if (place.getAddress().getId() == null && place.getAddress() != null) {
            place.getAddress().setId(addAddress(place.getAddress()).getId());
        } else if (place.getAddress().getId()!=null) {
            updateAddress(place.getAddress(), place.getAddress().getId());
        }
        String sql = "UPDATE place SET name=?, addressId=? WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{place.getName(), place.getAddress().getId(), id});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean deletePlace(Integer id) {
        String sql = "DELETE FROM place WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, id);
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    private Address addAddress(Address address) {
        String sql = "INSERT INTO address (streetaddress, postcode, country, district) VALUES (?,?,?,?);";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, address.getStreetAddress());
            ps.setString(2, address.getPostcode());
            ps.setString(3, address.getCountry());
            ps.setString(4, address.getDistrict());
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = keyHolder.getKey().intValue();
            address.setId(id);
        }
        return address;
    }

    private boolean updateAddress(Address address, Integer id) {
        String sql = "UPDATE address SET streetaddress=?, postcode=?, country=?, district=? WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{address.getStreetAddress(),
                address.getPostcode(), address.getCountry(), address.getDistrict(), id});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    private static final class PlaceMapper implements RowMapper<Place> {

        public Place mapRow(ResultSet rs, int rowNum) throws SQLException {
            Place place = new Place();
            place.setId(rs.getInt("id"));
            place.setName(rs.getString("name"));
            place.setAddress(new Address());
            place.getAddress().setId(rs.getInt("addressId"));
            place.getAddress().setStreetAddress(rs.getString("streetaddress"));
            place.getAddress().setPostcode(rs.getString("postcode"));
            place.getAddress().setCountry(rs.getString("country"));
            place.getAddress().setDistrict(rs.getString("district"));
            return place;
        }
    }
}
