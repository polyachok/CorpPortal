package com.corp.portal.domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class AgFile extends AbstractFile {

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "agreement")
    private Agreement agreement;

    public Agreement getAgreement() {
        return agreement;
    }

    public void setAgreement(Agreement agreement) {
        this.agreement = agreement;
    }
}
