package aika.aikaa.daos;

import aika.aikaa.objects.Role;
import aika.aikaa.objects.User;
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
public class UserDao {
    private JdbcTemplate jdbcTemplate;

    public UserDao(@Autowired JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<User> listOfAllUsers() {
        String sql = "SELECT * FROM \"user\";";
//        String sql = "SELECT * FROM user;";
        List<User> userList = jdbcTemplate.query(sql, new BeanPropertyRowMapper(User.class));
        userList.stream().forEach(u -> u.setRoles(usersRoles(u.getId())));
        return userList;
    }

    public List<User> listOfAllUsersWithRoleId(int roleId) {
        String sql = "SELECT \"user\".* from userrole JOIN user ON \"user\".id = userrole.userId JOIN role ON role.id = userrole.roleId WHERE userrole.roleId =?;";
        //String sql = "SELECT user.* from userrole JOIN user ON user.id = userrole.userId JOIN role ON role.id = userrole.roleId WHERE userrole.roleId =?;";
        List<User> roleUserList = jdbcTemplate.query(sql, new Object[]{roleId}, new BeanPropertyRowMapper(User.class));
        return roleUserList;
    }

    public User oneUser(int userId) {
        String sql = "SELECT * from \"user\" WHERE id=?";
        //String sql = "SELECT * from user WHERE id=?";
        User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{userId}, new BeanPropertyRowMapper(User.class));
        return user;
    }

    public User oneUserByName(String userName) {
        String sql = "SELECT * from \"user\" WHERE name=?";
        User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{userName}, new BeanPropertyRowMapper(User.class));
        return user;
    }

    public User oneUserByEmail(String userEmail) {
        String sql = "SELECT * from \"user\" WHERE email=?";
        User user = (User) jdbcTemplate.queryForObject(sql, new Object[]{userEmail}, new BeanPropertyRowMapper(User.class));
        return user;
    }

    public List<Role> usersRoles(int userId) {
        String sql = "SELECT role.*, rolecategory.name as category from userrole JOIN \"user\" ON \"user\".id = userrole.userId JOIN role ON role.id = userrole.roleId JOIN rolecategory ON role.categoryId = rolecategory.id WHERE userrole.userId=?;";
        //String sql = "SELECT role.*, rolecategory.name as category from userrole JOIN user ON user.id = userrole.userId JOIN role ON role.id = userrole.roleId JOIN rolecategory ON role.categoryId = rolecategory.id WHERE userrole.userId=?;";
        List<Role> roleList = jdbcTemplate.query(sql, new Object[]{userId}, new BeanPropertyRowMapper(Role.class));
        return roleList;
    }

    public User oneUserWithRoles(int userId) {
        User user = oneUser(userId);
        user.setRoles(usersRoles(userId));
        return user;
    }

    public User createUser(User user) {
        String sql = "INSERT INTO \"user\" (name, userLevel, email, addressid, phonenumber, picurl) VALUES (?,?,?,?,?,?);";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        User newUser = nullcheckUser(user);
        PreparedStatementCreator psc = connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, newUser.getName());
            ps.setInt(2, newUser.getUserLevel());
            ps.setString(3, newUser.getEmail());
            ps.setInt(4, newUser.getAddressid());
            ps.setString(5, newUser.getPhonenumber());
            ps.setString(6, newUser.getPicurl());
            return ps;
        };
        int onnistui = jdbcTemplate.update(psc, keyHolder);
        if (onnistui > 0) {
            int id = (int) keyHolder.getKeys().get("id");
            newUser.setId(id);
            if (!newUser.getRoles().isEmpty()) {
                newUser.getRoles().stream().forEach(r -> {
                    addUserRole(r.getId(), newUser.getId());
                });
            }
        }
        return newUser;
    }

    public boolean updateUser(User user, Integer id) {
        User newUser = nullcheckUser(user);//jos edestä tulee tyhjiä kenttiä, oletetaan, että tietokannasta halutaan tyhjentää kenttä.
        String sql = "UPDATE \"user\" SET name=?, userLevel=? , email=?, addressid=?, phonenumber=?, picurl=? WHERE id=?";
        //String sql = "UPDATE user SET name=?, userLevel=? WHERE id=?";
        int onnistui = jdbcTemplate.update(sql, new Object[]{newUser.getName(), newUser.getUserLevel(), newUser.getEmail(), newUser.getAddressid(),
                newUser.getPhonenumber(), newUser.getPicurl(), id});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    public boolean deleteUser(Integer id) {
        String sql = "DELETE FROM \"user\" WHERE id=?;";
        //String sql = "DELETE FROM user WHERE id=?;";
        int onnistui = jdbcTemplate.update(sql, new Object[]{id});
        if (onnistui > 0) {
            sql = "DELETE FROM userrole WHERE userid=?";
            onnistui = jdbcTemplate.update(sql, new Object[]{id});
            if (onnistui > 0)
                return true;
        }
        return false;
    }

    public boolean addUserRole(Integer roleId, Integer userId) {
        if (!userRolesAsIdList(userId).contains(roleId)) {
            String sql = "INSERT INTO userrole (roleId, userId) VALUES (?,?);";
            int onnistui = jdbcTemplate.update(sql, new Object[]{roleId, userId});
            if (onnistui > 0) {
                return true;
            }
        }
        return false;
    }

    private List<Integer> userRolesAsIdList(Integer userId) {
        String sql = "SELECT userrole.roleid from userrole JOIN \"user\" ON \"user\".id = userrole.userId WHERE userrole.userId=?;";
        List<Integer> roleList = jdbcTemplate.queryForList(sql, new Object[]{userId}, Integer.class);
        return roleList;
    }

    public boolean deleteUserRole(Integer roleId, Integer userId) {
        String sql = "DELETE FROM userrole WHERE roleid=? AND userId=?;";
        int onnistui = jdbcTemplate.update(sql, new Object[]{roleId, userId});
        if (onnistui > 0) {
            return true;
        }
        return false;
    }

    private User nullcheckUser(User user) {
        if (user.getName() == null) {
            user.setName("");
        }
        if (user.getUserLevel() == null) {
            user.setUserLevel(0);
        }
        if (user.getEmail() == null) {
            user.setEmail("");
        }
        if (user.getAddressid() == null) {
            user.setAddressid(0);
        }
        if (user.getPhonenumber() == null) {
            user.setPhonenumber("");
        }
        if (user.getPicurl() == null) {
            user.setPicurl("");
        }
        return user;
    }
}
