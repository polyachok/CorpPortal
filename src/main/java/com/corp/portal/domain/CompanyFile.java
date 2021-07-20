package com.corp.portal.domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class CompanyFile extends AbstractFile {

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "company")
    private Company company;

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }
}
