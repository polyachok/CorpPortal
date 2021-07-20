package com.corp.portal.repos;

import com.corp.portal.domain.Company;
import com.corp.portal.domain.Contract;
import com.corp.portal.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ContractRepo extends CrudRepository<Contract, Long> {
    List findContractByAuthor(User user);
    List findContractByAuthorAndStatus(User user, Integer status);
    List findContractByCompany1OrderByDate(Company company);
}
