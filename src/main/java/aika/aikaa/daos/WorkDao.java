package aika.aikaa.daos;

import aika.aikaa.objects.Role;
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
public class WorkDao {
    private JdbcTemplate jdbcTemplate;

    public WorkDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Work> allMusicalWorks() {
        String sql = "SELECT * FROM work WHERE musicians >0;";
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
            int id = (int) keyHolder.getKeys().get("id");
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

    public boolean addWorkRole(Integer workid, Integer roleid) {
        String sql = "INSERT INTO workrole (workid, roleid) VALUES (?,?);";
        int onnistui = jdbcTemplate.update(sql, new Object[]{workid, roleid});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean addAllWorkRoles(Integer workid, List<Integer> roleids) {
        List<Object[]> parameterList = new ArrayList<>();
        roleids.stream().forEach(rid -> parameterList.add(new Object[]{workid, rid}));
        String sql = "INSERT INTO workrole (workid, roleid) VALUES (?,?)";
        int onnistui = jdbcTemplate.update(sql, parameterList);
        if (onnistui == roleids.size()) {
            return true;
        }
        return false;
    }

    public boolean modifyWorkRole(Integer workid, Integer previousRoleid, Integer newRoleid) {
        String sql = "UPDATE workrole SET roleid=? WHERE workid=? AND roleid=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{newRoleid, workid, previousRoleid});
        if (onnistui == 1) {
            return true;
        }
        return false;
    }

    public boolean deleteWorkRole(Integer workid, Integer roleid) {
        String sql = "DELETE FROM workrole WHERE workid=? AND roleid=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{workid, roleid});
        if (onnistui == 1) {
            return true;
        }
        return false;
    }

    public List<Work> allWorksWithRoleDetails() {
        String sql = "SELECT * FROM work;";
        List<Work> listOfWorks = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Work.class));
        listOfWorks.stream().forEach(w-> w.setRoleList(allRolesByWorkId(w.getId())));
        return listOfWorks;
    }

    public List<Role> allRolesByWorkId(Integer workid) {
        String sql = "SELECT workrole.*, role.name as name, role.categoryid as categoryId, rolecategory.name as category FROM workrole JOIN role ON role.id = workrole.roleid JOIN rolecategory ON rolecategory.id = role.categoryid WHERE workid=?;";
        List<Role> listOfRoles = jdbcTemplate.query(sql, new Object[]{workid}, new BeanPropertyRowMapper(Role.class));
        return listOfRoles;
    }
}

