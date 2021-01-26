package com.corp.portal.repos;

import com.corp.portal.domain.PrCoFile;
import org.springframework.data.repository.CrudRepository;

import java.util.Set;

public interface PrCoFileRepo extends CrudRepository<PrCoFile, Long> {
    Set findByParent(Long id);
    PrCoFile findByName(String name);


}
