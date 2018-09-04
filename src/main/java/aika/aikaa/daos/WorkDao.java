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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public Work oneWorkWithRoleDetails(Integer workid) {
        String sql = "SELECT * FROM work WHERE id=?;";
        Work oneWork = (Work) jdbcTemplate.queryForObject(sql, new Object[]{workid}, new BeanPropertyRowMapper(Work.class));
        oneWork.setRoleList(allRolesByWorkId(oneWork.getId()));
        return oneWork;
    }

    public List<Work> allWorksWithRoleDetails() {
        String sql = "SELECT * FROM work;";
        List<Work> listOfWorks = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Work.class));
        listOfWorks.stream().forEach(w-> w.setRoleList(allRolesByWorkId(w.getId())));
        return listOfWorks;
    }

    public List<Role> allRolesByWorkId(Integer workid) {
        String sql = "SELECT workrole.id as workroleId, workrole.roleid as id, workrole.number, role.name as name, role.categoryid as categoryId, rolecategory.name as category FROM workrole JOIN role ON role.id = workrole.roleid JOIN rolecategory ON rolecategory.id = role.categoryid WHERE workid=?;";
        List<Role> listOfRoles = jdbcTemplate.query(sql, new Object[]{workid}, new BeanPropertyRowMapper(Role.class));
        return listOfRoles;
    }

    public boolean addWorkRole(Integer workid, Integer roleid) {
        String sql = "INSERT INTO workrole (workid, roleid, number) VALUES (?,?,?);";
        int onnistui = jdbcTemplate.update(sql, new Object[]{workid, roleid});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean addAllWorkRoles(Integer workid, Map<Integer, Integer> roleData) {
        List<Object[]> parameterList = new ArrayList<>();
        roleData.keySet().stream().forEach(rid -> {
            parameterList.add(new Object[]{workid, rid, roleData.get(rid)});
        } );
        System.out.println(parameterList);
        String sql = "INSERT INTO workrole (workid, roleid, number) VALUES (?,?,?)";
        int[] onnistui = jdbcTemplate.batchUpdate(sql, parameterList);
        if (onnistui.length == roleData.keySet().size()) {
            return true;
        }
        return false;
    }

    public List<Role> addRoleDetailsToWorkById(List<Integer> roleList, Integer workId) {
        System.out.println(roleList);
        Map<Integer, Integer> roleNumbers = new HashMap<>();
        roleList.stream().forEach(r-> {
            roleNumbers.putIfAbsent(r, 0);
            roleNumbers.put(r, roleNumbers.get(r)+1);
        });
        addAllWorkRoles(workId, roleNumbers);
        return allRolesByWorkId(workId);
    }

    public boolean modifyWorkRole(Integer workroleid, Integer newRoleid, Integer newNumber) {
        String sql = "UPDATE workrole SET roleid=?, number=? WHERE workroleid=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{newRoleid, newNumber, workroleid});
        if (onnistui == 1) {
            return true;
        }
        return false;
    }

    public boolean deleteWorkRole(Integer workroleid) {
        String sql = "DELETE FROM workrole WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{workroleid});
        if (onnistui == 1) {
            return true;
        }
        return false;
    }

//    public boolean deleteRoleFromWork(Integer workroleid) {//EI KÄYTÖSSÄ EIKÄ KUNNOLLA TOTEUTETTU
//        List<Object[]> parameterList = new ArrayList<>();
//        roleList.stream().forEach(wrid -> {
//            parameterList.add(new Object[]{workroleid});
//        } );
//        System.out.println(parameterList);
//        String sql = "INSERT INTO workrole (workid, roleid, number) VALUES (?,?,?)";
//        int[] onnistui = jdbcTemplate.batchUpdate(sql, parameterList);
//        if (onnistui.length == roleData.keySet().size()) {
//            return true;
//        }
//        return false;
//    }
}

