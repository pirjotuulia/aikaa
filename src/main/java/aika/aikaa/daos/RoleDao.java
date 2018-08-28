package aika.aikaa.daos;

import aika.aikaa.objects.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.Collections;
import java.util.List;

@Component
public class RoleDao {

    private JdbcTemplate jdbcTemplate;

    public RoleDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Role> allRoles() {
        String sql = "SELECT role.*, rolecategory.name as category FROM role JOIN rolecategory ON role.categoryId = rolecategory.id;";
        List<Role> roleList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Role.class));
        Collections.sort(roleList);
        return roleList;
    }

    public Role oneRole(Integer id) {
        String sql = "SELECT role.*, rolecategory.name as category FROM role JOIN rolecategory ON role.categoryId = rolecategory.id WHERE role.id=?";
        Role role = (Role) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Role.class));
        return role;
    }

    public Role createRole(Role newRole) {
        String sql = "INSERT INTO role (name, categoryId) VALUES (?,?);";
        Role role = new Role(newRole.getName());
        role.setCategory(newRole.getCategory());
        role.setCategoryId(newRole.getCategoryId());
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, role.getName());
            ps.setInt(2, role.getCategoryId());
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = keyHolder.getKey().intValue();
            role.setId(id);
        }
        return role;
    }


    public boolean updateRole(Role role, Integer id) {
        String sql = "UPDATE role SET name=?, categoryId=? WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{role.getName(), role.getCategoryId(), id});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean deleteRole(Integer id) {
        String sql = "DELETE FROM role WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, id);
        if (onnistui > 0) {
            return true;
        }
        return false;
    }


    private Integer findCategoryId(String category) {
        String sql = "SELECT id FROM rolecategory WHERE name=?";
        Integer id = (Integer) jdbcTemplate.queryForObject(sql, new Object[]{category}, new BeanPropertyRowMapper(Integer.class));
        return id;
    }

    private Integer addCategory(String category) {
        String sql = "INSERT INTO rolecategory (name) VALUES (?);";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, category);
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = keyHolder.getKey().intValue();
            return id;
        }
        return -1;
    }
}
