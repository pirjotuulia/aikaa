package aika.aikaa.authentication.dao;

import aika.aikaa.authentication.model.Role;
import aika.aikaa.authentication.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

@Component
public class AppUserDao {
    private JdbcTemplate jdbcTemplate;

    public AppUserDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public boolean existsByUsername(String username) {
        String sql = "SELECT * FROM appuser WHERE username=?";
        User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{username}, new BeanPropertyRowMapper(User.class));
        if (user != null) {
            return true;
        }
        return false;
    }

    public User findByUsername(String username) {
        String sql = "SELECT appuser.* FROM appuser WHERE username=?";
        User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{username}, new BeanPropertyRowMapper(User.class));
        sql = "SELECT userrole FROM appuserrole WHERE userid=?";
        List<Role> roles = jdbcTemplate.query(sql, new Object[]{user.getId()}, new RoleMapper());
        user.setRoles(roles);
        return user;
    }

    private static final class RoleMapper implements RowMapper<Role> {

        public Role mapRow(ResultSet rs, int rowNum) throws SQLException {
            String roleAsAString = rs.getString("userrole");
            if (roleAsAString.equals("ROLE_SUPERADMIN")) {
                return Role.ROLE_SUPERADMIN;
            }
            if (roleAsAString.equals("ROLE_USER")) {
                return Role.ROLE_USER;
            }
            if (roleAsAString.equals("ROLE_ADMIN")) {
                return Role.ROLE_ADMIN;
            }
            return Role.ROLE_GUEST;
        }
    }

    @Transactional
    public void deleteByUsername(String username) {
        String sql = "SELECT id FROM appuser WHERE username=?";
        Integer userid = (Integer) jdbcTemplate.queryForObject(sql, new Object[]{username}, new BeanPropertyRowMapper(Integer.class));
        sql = "DELETE FROM appuserrole WHERE userid=?";
        jdbcTemplate.update(sql, new Object[]{userid});
        sql = "DELETE FROM appuser WHERE username=?";
        jdbcTemplate.update(sql, new Object[]{username});
    }

    public List<User> saveAll(List<User> users) {
        for (User u : users) {
            String sql = "INSERT INTO appuser (username, email, password) VALUES (?,?,?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            PreparedStatementCreator psc = connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, u.getUsername());
                ps.setString(2, u.getEmail());
                ps.setString(3, u.getPassword());
                return ps;
            };
            int onnistui = jdbcTemplate.update(psc, keyHolder);
            if (onnistui > 0) {
                int id = (int) keyHolder.getKeys().get("id");
                u.setId(id);
                if (!u.getRoles().isEmpty()) {
                    for (Role r : u.getRoles()) {
                        String sql2 = "INSERT INTO appuserrole (userid, userrole) VALUES (?,?)";
                        onnistui = jdbcTemplate.update(sql2, new Object[]{u.getId(), r.getAuthority()});
                    }
                }
            }
        }
        return users;
    }

    public User save(User user) {
        String sql = "INSERT INTO appuser (username, email, password) VALUES (?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = (int) keyHolder.getKeys().get("id");
            user.setId(id);
            if (!user.getRoles().isEmpty()) {
                for (Role r : user.getRoles()) {
                    String sql2 = "INSERT INTO appuserrole (userid, userrole) VALUES (?,?)";
                    onnistui = jdbcTemplate.update(sql2, new Object[]{user.getId(), r.getAuthority()});
                }
            }
        }
        return user;
    }
}

