package aika.aikaa.authentication.model;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    ROLE_SUPERADMIN, ROLE_ADMIN, ROLE_USER, ROLE_GUEST;

    public String getAuthority() {
        return name();
    }



}
