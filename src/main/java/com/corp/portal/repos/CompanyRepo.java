package com.corp.portal.repos;

import com.corp.portal.domain.Company;
import org.springframework.data.repository.CrudRepository;

public interface CompanyRepo extends CrudRepository<Company, Long> {
}
