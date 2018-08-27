package aika.aikaa.daos;

import aika.aikaa.objects.Role;
import aika.aikaa.objects.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.util.List;
@Component
public class UserDao {
    private JdbcTemplate jdbcTemplate;

    public UserDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<User> listOfAllUsers() {
        String sql = "SELECT * FROM user";
        List<User> userList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(User.class));
        return userList;
    }

    public List<User> listOfAllUsersWithRole(int roleId) {
        String sql = "SELECT user.* from userrole JOIN user, role WHERE userrole.roleId =? AND user.id = userrole.userId AND role.id = userrole.roleId;";
        List<User> roleUserList = jdbcTemplate.query(sql, new Object[]{roleId}, new BeanPropertyRowMapper(User.class));
        return roleUserList;
    }

    public User oneUser(int userId) {
        String sql = "SELECT * from user WHERE id=?";
        User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{userId}, new BeanPropertyRowMapper(User.class));
        return user;
    }

    public User oneUserWithRoles(int userId) {
        User user = oneUser(userId);
        String sql = "SELECT role.* from userrole JOIN user, role WHERE userrole.userId=? AND user.id = userrole.userId AND role.id = userrole.roleId;";
        List<Role> roleList = jdbcTemplate.query(sql, new Object[]{userId}, new BeanPropertyRowMapper(Role.class));
        user.setRoles(roleList);
        return user;
    }
}
