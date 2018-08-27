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
        String sql = "SELECT * FROM role";
        List<Role> roleList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Role.class));
        Collections.sort(roleList);
        return roleList;
    }

    public Role oneRole(Integer id) {
        String sql = "SELECT * FROM role WHERE id=?";
        Role role = (Role) jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper(Role.class));
        return role;
    }

    public Role createRole(Role newRole) {
        String sql = "INSERT INTO role (name) VALUES (?);";
        Role role = new Role(newRole.getName());
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, role.getName());
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
        String sql = "UPDATE role SET name=? WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{role.getName(), id});
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
}
