package com.corp.portal.domain;

import javax.persistence.Entity;

@Entity
public class PrCoFile extends AbstractFile {

    private Long parent;

    public Long getParent() {
        return parent;
    }

    public void setParent(Long parent) {
        this.parent = parent;
    }
}
