package com.corp.portal.repos;

import com.corp.portal.domain.AgFile;
import com.corp.portal.domain.Agreement;
import com.corp.portal.domain.PrCoFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Set;

public interface AgFileRepo extends CrudRepository<AgFile, Long> {
    List findByAgreement(Agreement agreement);
    PrCoFile findByName(String name);
}
