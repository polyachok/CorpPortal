package com.corp.portal.repos;

import com.corp.portal.domain.AgFile;
import com.corp.portal.domain.Contract;
import com.corp.portal.domain.ContractFile;
import com.corp.portal.domain.PrCoFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ContractFileRepo extends CrudRepository<ContractFile, Long> {
    List findByContract(Contract contract);
    PrCoFile findByName(String name);
}
