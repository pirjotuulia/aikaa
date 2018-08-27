package aika.aikaa.daos;

import aika.aikaa.objects.Event;
import aika.aikaa.objects.SubEvent;
import aika.aikaa.objects.Work;
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

    public EventDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public Event oneEvent(int eventId) {
        String sql = "SELECT * from event WHERE id=?";
        Event event = (Event) jdbcTemplate.queryForObject(sql, new Object[]{eventId}, new BeanPropertyRowMapper(Event.class));
        return event;
    }

    public Event oneEventWithWorks(int eventId) {
        Event event = oneEvent(eventId);
        String sql = "SELECT work.* FROM eventwork JOIN event, work WHERE eventId =? AND eventwork.eventId = event.id AND eventwork.workId = work.id;";
        List<Work> workList = jdbcTemplate.query(sql, new Object[]{eventId}, new BeanPropertyRowMapper(Work.class));
        event.setWorks(workList);
        return event;
    }

    public Event oneEventWithEverything(int eventId) {
        Event event = oneEventWithWorks(eventId);
        event.setSubEvents(listOfSubEvents(eventId));
        return event;
    }

    public List<Event> listOfAllEvents() {
        String sql = "SELECT * FROM event";
        List<Event> eventList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Event.class));
        return eventList;
    }

    public List<SubEvent> listOfSubEvents(int eventId) {
        String sql = "SELECT * FROM subevent WHERE eventid=?";
        List<SubEvent> subEventList = jdbcTemplate.query(sql, new Object[]{eventId}, new BeanPropertyRowMapper(SubEvent.class));
        return subEventList;
    }

    public List<Event> allEventsWithEverything() {
        List<Event> listOfEvents = new ArrayList<>();
        listOfAllEvents().stream().forEach(e -> listOfEvents.add(oneEventWithEverything(e.getId())));
        System.out.println(listOfEvents.get(1));
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
            int id = keyHolder.getKey().intValue();
            event.setId(id);
        }
        return event;
    }

    public boolean updateEvent(Event event, Integer id) {
        String sql = "UPDATE event SET name=? WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{event.getName(), id});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean deleteEvent(Integer id) {
        String sql = "DELETE FROM event WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, id);
        if (onnistui > 0) {
            return true;
        }
        return false;
    }
}
