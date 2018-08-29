package aika.aikaa.daos;

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
import java.util.List;

@Component
public class WorkDao {
    private JdbcTemplate jdbcTemplate;

    public WorkDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Work> allWorks() {
        String sql = "SELECT * FROM work;";
        List<Work> listOfWorks = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Work.class));
        return listOfWorks;
    }

    public Work oneWork(Integer id) {
        String sql = "SELECT * FROM work WHERE id=?;";
        Work work = (Work) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Work.class));
        return work;
    }

    public Work createWork(Work newWork) {
        String sql = "INSERT INTO work (work, composer, instrumentation, musicians, durationinminutes) VALUES (?,?,?,?,?);";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, newWork.getWork());
            ps.setString(2, newWork.getComposer());
            ps.setString(3, newWork.getInstrumentation());
            ps.setInt(4, newWork.getMusicians());
            ps.setInt(5, newWork.getDurationInMinutes());
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = keyHolder.getKey().intValue();
            newWork.setId(id);
        }
        return newWork;
    }

    public boolean updateWork(Work work, Integer id) {
        String sql = "UPDATE work SET work=?, composer=?, instrumentation=?, musicians=?, durationinminutes=? WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{work.getWork(), work.getComposer(), work.getInstrumentation(), work.getMusicians(), work.getDurationInMinutes(), id});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean deleteWork(Integer id) {
        String sql = "DELETE FROM work WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, id);
        if (onnistui > 0) {
            return true;
        }
        return false;
    }
}

