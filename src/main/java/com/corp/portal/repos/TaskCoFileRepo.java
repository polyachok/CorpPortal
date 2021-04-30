package com.corp.portal.repos;

import com.corp.portal.domain.PrCoFile;
import com.corp.portal.domain.TaCoFile;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Set;

public interface TaskCoFileRepo extends CrudRepository<TaCoFile, Long> {
    Set findByParent(Long id);
    PrCoFile findByName(String name);
    List<TaCoFile> findAllByParent(Long id);

}
