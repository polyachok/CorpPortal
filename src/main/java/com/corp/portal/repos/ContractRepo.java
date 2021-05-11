package com.corp.portal.repos;

import com.corp.portal.domain.Contract;
import org.springframework.data.repository.CrudRepository;

public interface ContractRepo extends CrudRepository<Contract, Long> {
}
