package aika.aikaa.daos;

import aika.aikaa.objects.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

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
        return roleList;
    }

}
