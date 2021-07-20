package com.corp.portal.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {

    USER, ADMIN, CONTRACT;

    @Override
    public String getAuthority() {
        return name();
    }
}
