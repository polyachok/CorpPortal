package com.corp.portal.domain;

import javax.persistence.Entity;

@Entity
public class Contract extends AbstractContract {
    private Integer type;

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
