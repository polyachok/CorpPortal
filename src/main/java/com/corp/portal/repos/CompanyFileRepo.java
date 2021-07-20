package com.corp.portal.repos;

import com.corp.portal.domain.Company;
import com.corp.portal.domain.CompanyFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CompanyFileRepo extends CrudRepository<CompanyFile, Long> {
    List findByCompany(Company company);
    CompanyFile findByName(String name);
}
