package aika.aikaa.daos;

import aika.aikaa.objects.Booking;
import aika.aikaa.objects.SubEvent;
import aika.aikaa.objects.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BookingDao {
    private JdbcTemplate jdbcTemplate;
    private EventDao ed;
    private UserDao ud;

    public BookingDao(@Autowired JdbcTemplate jdbcTemplate, @Autowired EventDao ed, @Autowired UserDao ud) {
        this.jdbcTemplate = jdbcTemplate;
        this.ed = ed;
        this.ud = ud;
    }

    public List<Booking> allBookings() {
        String sql = "SELECT event.id as eventid, subeventcast.id as id, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.ending as ending, \"user\".name as username, \"user\".id as userid, " +
                "role.name as rolename, work.work as workname, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN \"user\" ON \"user\".id = subeventcast.userid" +
                " JOIN workrole ON workrole.id = subeventcast.workroleid" +
                " JOIN role ON role.id = workrole.roleid" +
                " JOIN work ON work.id = workrole.workid" +
                " JOIN place ON place.id = subevent.placeid" +
                " JOIN event ON subevent.eventid = event.id ;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Booking.class));
        return bookingList;
    }

    public List<Booking> userBookings(Integer id) {
        String sql = "SELECT event.id as eventid, subeventcast.id as id, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.ending as ending, \"user\".name as username, subeventcast.userid as userid, " +
                "role.name as rolename, work.work as workname, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN \"user\" ON \"user\".id = subeventcast.userid" +
                " JOIN workrole ON workrole.id = subeventcast.workroleid" +
                " JOIN role ON role.id = workrole.roleid" +
                " JOIN work ON work.id = workrole.workid" +
                " JOIN place ON place.id = subevent.placeid " +
                " JOIN event ON subevent.eventid = event.id WHERE subeventcast.userid=?;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper(Booking.class));
        bookingList = bookingList.stream().sorted((b1, b2) -> b1.getBegin().compareTo(b2.getBegin())).collect(Collectors.toList());
        return bookingList;
    }

    public List<Booking> placeBookings(Integer id) {
        String sql = "SELECT DISTINCT event.id as eventid, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.ending as ending, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN place ON place.id = subevent.placeid" +
                " JOIN event ON subevent.eventid = event.id WHERE place.id=?;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new Object[]{id}, new BeanPropertyRowMapper(Booking.class));
        return bookingList;
    }

    public List<Booking> userBookingsByDay(String day, Integer id) {
        LocalDate dayRequested = LocalDate.parse(day);
        String sql = "SELECT event.id as eventid, subeventcast.id as id, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.ending as ending, \"user\".name as username, \"user\".id as userid, " +
                "role.name as rolename, work.work as workname, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN \"user\" ON \"user\".id = subeventcast.userid" +
                " JOIN workrole ON workrole.id = subeventcast.workroleid" +
                " JOIN role ON role.id = workrole.roleid" +
                " JOIN work ON work.id = workrole.workid" +
                " JOIN place ON place.id = subevent.placeid " +
                " JOIN event ON subevent.eventid = event.id WHERE subeventcast.userid=? AND DATE(subevent.begin)=?;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new Object[]{id, dayRequested}, new BeanPropertyRowMapper(Booking.class));
        bookingList = bookingList.stream().sorted((b1, b2) -> b1.getBegin().compareTo(b2.getBegin())).collect(Collectors.toList());
        return bookingList;
    }

    public Booking userBookingByBookingId(Integer id) {
        String sql = "SELECT event.id as eventid, subeventcast.id as id, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.ending as ending, \"user\".name as username, \"user\".id as userid, " +
                "role.name as rolename, work.work as workname, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN \"user\" ON \"user\".id = subeventcast.userid" +
                " JOIN workrole ON workrole.id = subeventcast.workroleid" +
                " JOIN role ON role.id = workrole.roleid" +
                " JOIN work ON work.id = workrole.workid" +
                " JOIN place ON place.id = subevent.placeid " +
                " JOIN event ON subevent.eventid = event.id WHERE subeventcast.id=?;";
        Booking booking = (Booking) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Booking.class));
        return booking;
    }

    public Booking bookUser(Integer subeventId, Integer userId, Integer workroleId) {
        String sql = "INSERT INTO subeventcast (subeventid, userid, workroleid) VALUES (?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, subeventId == null ? 0 : subeventId);
            ps.setInt(2, userId == null ? 0 : userId);
            ps.setInt(3, workroleId == null ? null : workroleId);
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = (int) keyHolder.getKeys().get("id");
            Booking booking = userBookingByBookingId(id);
            return booking;
        }
        return null;
    }

    public List<User> freeUserForASubEvent(Integer subeventId) {
        SubEvent subEvent = ed.oneSubEventById(subeventId);
        LocalDateTime begin = subEvent.getBegin();
        LocalDateTime ending = subEvent.getEnding();
        String sql = "SELECT DISTINCT \"user\".id from \"user\" LEFT JOIN subeventcast ON subeventcast.userid = \"user\".id " +
                "LEFT JOIN subevent ON subeventcast.subeventid = subevent.id " +
                "WHERE (subevent.begin BETWEEN ? AND ?) OR (subevent.ending BETWEEN ? AND ?);";//haetaan varatut userit
        List<Integer> bookedUsers = jdbcTemplate.queryForList(sql, new Object[]{begin, ending, begin, ending}, Integer.class);
        List<User> allUsers = ud.listOfAllUsers();
        List<User> freeUsers = allUsers.stream().filter(user -> !bookedUsers.contains(user.getId())).collect(Collectors.toList()); //valitaan ne, jotka eivät ole varattuja
        return freeUsers;
    }

    public List<Booking> allSubEventBookingsById(Integer subeventid) {
        String sql = "SELECT event.id as eventid, subeventcast.id as id, subevent.id as subeventid, subevent.name as name, subevent.type as type, " +
                "subevent.begin as begin, subevent.ending as ending, \"user\".name as username, \"user\".id as userid, " +
                "role.name as rolename, work.work as workname, place.name as placename" +
                " FROM subeventcast JOIN subevent ON subevent.id = subeventcast.subeventid" +
                " JOIN \"user\" ON \"user\".id = subeventcast.userid" +
                " JOIN workrole ON workrole.id = subeventcast.workroleid" +
                " JOIN role ON role.id = workrole.roleid" +
                " JOIN work ON work.id = workrole.workid" +
                " JOIN place ON place.id = subevent.placeid" +
                " JOIN event ON subevent.eventid = event.id WHERE subeventid=?;";
        List<Booking> bookingList = jdbcTemplate.query(sql, new Object[]{subeventid}, new BeanPropertyRowMapper(Booking.class));
        return bookingList;
    }
}

