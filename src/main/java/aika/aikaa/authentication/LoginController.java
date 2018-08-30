package aika.aikaa.authentication;

import aika.aikaa.authentication.dao.AppUserDao;
import aika.aikaa.authentication.model.Role;
import aika.aikaa.authentication.model.User;

import aika.aikaa.authentication.userauth.JwtTokenProvider;
import aika.aikaa.daos.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Service
@RestController
public class LoginController {
    private AppUserDao aud;
    private UserDao ud;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    private JwtTokenProvider jwtTokenProvider;
    @Autowired private AuthenticationManager authenticationManager;

    public LoginController(@Autowired AppUserDao aud, @Autowired BCryptPasswordEncoder bCryptPasswordEncoder, @Autowired UserDao ud,
                           @Autowired JwtTokenProvider jwtTokenProvider) {
        this.aud = aud;
        this.ud = ud;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @GetMapping("/user")
    public Principal user(Principal principal) {
        System.out.println(principal.getName());
        return principal;
    }

    @PostMapping("/signup")
    public void signUp(@RequestBody User user) {
        aika.aikaa.objects.User inUser = ud.oneUserByEmail(user.getEmail());
        if (inUser != null && inUser.getUserLevel() < 4) {
            int userLevel = inUser.getUserLevel();
            List<Role> userLevels = new ArrayList<>();
            if (userLevel > 3) {
                userLevels.add(Role.ROLE_GUEST);
            }
            if (userLevel <= 3) {
                userLevels.add(Role.ROLE_USER);
            }
            if (userLevel <= 2) {
                userLevels.add(Role.ROLE_ADMIN);
            }
            if (userLevel == 1) {
                userLevels.add(Role.ROLE_SUPERADMIN);
            }
            user.setRoles(userLevels);
        } else {
            return;
        }
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        aud.save(user);
    }

    @PostMapping("/signin")
    public String signIn(@RequestBody User user) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
            return jwtTokenProvider.createToken(user.getUsername(), aud.findByUsername(user.getUsername()).getRoles());
        } catch (AuthenticationException e) {
            throw new CustomException("Invalid username/password supplied", HttpStatus.UNPROCESSABLE_ENTITY);
        }
    }
}
