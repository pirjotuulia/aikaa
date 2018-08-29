package aika.aikaa.daos;

import aika.aikaa.objects.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BookingDao {
    private JdbcTemplate jdbcTemplate;

    public BookingDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Booking> allBookings() {
        String sql = "SELECT event.id as eventid, subeventcast.id as id, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.end as end, \"user\".name as username, \"user\".id as userid, " +
                "role.name as rolename, work.work as workname, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN \"user\" ON \"user\".id = subeventcast.userid" +
                " JOIN role ON role.id = subeventcast.roleid" +
                " JOIN work ON work.id = subeventcast.workid" +
                " JOIN place ON place.id = subevent.placeid" +
                " JOIN event ON subevent.eventid = event.id ;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Booking.class));
        return bookingList;
    }

    public List<Booking> userBookings(Integer id) {
        String sql = "SELECT event.id as eventid, subeventcast.id as id, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.end as end, \"user\".name as username, \"user\".id as userid, " +
                "role.name as rolename, work.work as workname, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN \"user\" ON \"user\".id = subeventcast.userid" +
                " JOIN role ON role.id = subeventcast.roleid" +
                " JOIN work ON work.id = subeventcast.workid" +
                " JOIN place ON place.id = subevent.placeid " +
                " JOIN event ON subevent.eventid = event.id WHERE subeventcast.userid=?;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper(Booking.class));
        bookingList = bookingList.stream().sorted((b1, b2) -> b1.getBegin().compareTo(b2.getBegin())).collect(Collectors.toList());
        return bookingList;
    }

    public List<Booking> placeBookings(Integer id) {
        String sql = "SELECT DISTINCT event.id as eventid, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.end as end, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN place ON place.id = subevent.placeid" +
                " JOIN event ON subevent.eventid = event.id WHERE place.id=?;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper(Booking.class));
        return bookingList;
    }

    public List<Booking> userBookingsByDay(String day, Integer id) {
        LocalDate dayRequested = LocalDate.parse(day);
        String sql = "SELECT event.id as eventid, subeventcast.id as id, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.end as end, \"user\".name as username, \"user\".id as userid, " +
                "role.name as rolename, work.work as workname, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN \"user\" ON \"user\".id = subeventcast.userid" +
                " JOIN role ON role.id = subeventcast.roleid" +
                " JOIN work ON work.id = subeventcast.workid" +
                " JOIN place ON place.id = subevent.placeid " +
                " JOIN event ON subevent.eventid = event.id WHERE subeventcast.userid=? AND DATE(subevent.begin)=?;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new Object[]{id, dayRequested}, new BeanPropertyRowMapper(Booking.class));
        bookingList = bookingList.stream().sorted((b1, b2) -> b1.getBegin().compareTo(b2.getBegin())).collect(Collectors.toList());
        return bookingList;
    }
}
