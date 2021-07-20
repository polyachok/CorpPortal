package com.corp.portal.repos;

import com.corp.portal.domain.Company;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CompanyRepo extends CrudRepository<Company, Long> {
    Company findByNameAndType(String name, Integer type);
    List findByTypeNot(int type);

    List findByType(int Type);
}
