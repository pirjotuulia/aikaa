package aika.aikaa.daos;

import aika.aikaa.objects.Event;
import aika.aikaa.objects.SubEvent;
import aika.aikaa.objects.Work;
import aika.aikaa.objects.dtos.SubEventDtoIn;
import aika.aikaa.objects.dtos.SubEventDtoOut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Component
public class EventDao {
    private JdbcTemplate jdbcTemplate;
    private WorkDao wd;

    public EventDao(@Autowired JdbcTemplate jdbcTemplate, @Autowired WorkDao wd) {
        this.jdbcTemplate = jdbcTemplate;
        this.wd = wd;
    }

    public Event oneEvent(int eventId) {
        String sql = "SELECT * from event WHERE id=?";
        Event event = (Event) jdbcTemplate.queryForObject(sql, new Object[]{eventId}, new BeanPropertyRowMapper(Event.class));
        return event;
    }

    public Event oneEventWithWorks(int eventId) {
        Event event = oneEvent(eventId);
        String sql = "SELECT work.* FROM eventwork JOIN event ON eventwork.eventId = event.id JOIN work ON eventwork.workId = work.id WHERE eventId =?;";
        List<Work> workList = jdbcTemplate.query(sql, new Object[]{eventId}, new BeanPropertyRowMapper(Work.class));
        event.setWorks(workList);
        workList.stream().forEach(work -> work.setRoleList(wd.allRolesByWorkId(work.getId())));
        return event;
    }

    public Event oneEventWithEverything(int eventId) {
        Event event = oneEventWithWorks(eventId);
        event.setSubEvents(listOfSubEventsByEventId(eventId));
        return event;
    }

    public List<Event> listOfAllEvents() {
        String sql = "SELECT * FROM event";
        List<Event> eventList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Event.class));
        return eventList;
    }

    public SubEvent oneSubEventById(Integer id) {
        String sql = "SELECT subevent.*, place.name as place FROM subevent " +
                "JOIN place ON place.id = subevent.placeid " +
                "WHERE subevent.id=?;";
        SubEvent subEvent = (SubEvent) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(SubEvent.class));
        return subEvent;
    }

    public SubEventDtoOut oneSubEventDtoOutById(Integer id) {
        String sql = "SELECT subevent.*, place.name as placename, event.name as eventname, work.work as workname FROM subevent " +
                "JOIN place ON place.id = subevent.placeid " +
                "JOIN event ON event.id = subevent.eventid " +
                "JOIN work ON work.id = subevent.workid " +
                "WHERE subevent.id=?;";
        SubEventDtoOut subEventOut = (SubEventDtoOut) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(SubEventDtoOut.class));
        return subEventOut;
    }

    public List<SubEventDtoOut> allSubEvents() {
        String sql = "SELECT subevent.*, place.name as placename, event.name as eventname, work.work as workname FROM subevent " +
                "JOIN place ON place.id = subevent.placeid " +
                "JOIN event ON event.id = subevent.eventid " +
                "JOIN work ON work.id = subevent.workid;";
        List<SubEventDtoOut> subEventList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(SubEventDtoOut.class));
        return subEventList;
    }

    public List<SubEvent> listOfSubEventsByEventId(int eventId) {
        String sql = "SELECT subevent.*, place.name as place FROM subevent JOIN place ON place.id = subevent.placeid " +
                "JOIN event ON event.id = subevent.eventid WHERE eventid=?;";
        List<SubEvent> subEventList = jdbcTemplate.query(sql, new Object[]{eventId}, new BeanPropertyRowMapper(SubEvent.class));
        return subEventList;
    }

    public List<Event> allEventsWithEverything() {
        List<Event> listOfEvents = new ArrayList<>();
        listOfAllEvents().stream().forEach(e -> listOfEvents.add(oneEventWithEverything(e.getId())));
        return listOfEvents;
    }

    public Event createEvent(Event newEvent) {
        String sql = "INSERT INTO event (name) VALUES (?);";
        Event event = new Event(newEvent.getName());
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, event.getName());
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = (int) keyHolder.getKeys().get("id");
            event.setId(id);
        }
        return event;
    }

    public boolean updateEvent(Event event, Integer id) {
        String sql = "UPDATE event SET name=? WHERE id=?;";
        int onnistui = jdbcTemplate.update(sql, new Object[]{event.getName(), id});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean deleteEvent(Integer id) {
        String sql = "DELETE FROM event WHERE id=?;";
        int onnistui = jdbcTemplate.update(sql, id);
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public SubEvent createSubEvent(SubEventDtoIn newSubEvent) {
        String sql = "INSERT INTO subevent (name, begin, ending, placeid, eventid, type, workid) VALUES (?,?,?,?,?,?,?);";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, newSubEvent.getName());
            ps.setObject(2, newSubEvent.getBegin());
            ps.setObject(3, newSubEvent.getEnding());
            ps.setInt(4, newSubEvent.getPlaceId());
            ps.setInt(5, newSubEvent.getEventId());
            ps.setString(6, newSubEvent.getType());
            if (newSubEvent.getWorkId() != null) {
                ps.setInt(7, newSubEvent.getWorkId());
            } else {
                ps.setObject(7, null);
            }
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        SubEvent created = new SubEvent();
        if (onnistui > 0) {
            int id = (int) keyHolder.getKeys().get("id");
            created = oneSubEventById(id);
        }
        return created;
    }

    public boolean updateSubEvent(SubEventDtoIn subEvent, Integer id) {
        String sql = "UPDATE subevent SET name=?, begin=?, ending=?, placeid=?, eventid=?, type=?, workid=? WHERE id=?;";
        int onnistui = jdbcTemplate.update(sql, new Object[]{subEvent.getName(), subEvent.getBegin().toString(), subEvent.getEnding().toString(),
                subEvent.getPlaceId(), subEvent.getEventId(), subEvent.getType(), subEvent.getWorkId(), id});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean deleteSubEvent(Integer id) {
        String sql = "DELETE FROM subevent WHERE id=?;";
        int onnistui = jdbcTemplate.update(sql, id);
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean addWorkToEvent(Integer eventid, Integer workid) {
        String sql = "INSERT INTO eventwork (eventid, workid) VALUES (?,?);";
        int onnistui = jdbcTemplate.update(sql, new Object[]{eventid, workid});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }
}
