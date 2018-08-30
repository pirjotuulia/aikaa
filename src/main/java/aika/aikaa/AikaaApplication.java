package aika.aikaa;

import aika.aikaa.authentication.userauth.CustomAuthenticationProvider;
import aika.aikaa.authentication.userauth.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.security.authentication.AuthenticationManager;

import java.util.Arrays;

@SpringBootApplication
public class AikaaApplication {

    public static void main(String[] args) {
        SpringApplication.run(AikaaApplication.class, args);
    }

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(@Autowired CustomAuthenticationProvider customAuthenticationProvider) throws Exception {
        return new ProviderManager(Arrays.asList(customAuthenticationProvider));
    }

}
