package com.corp.portal.domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class ContractFile extends AbstractFile {

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "contract")
    private Contract contract;

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }
}
