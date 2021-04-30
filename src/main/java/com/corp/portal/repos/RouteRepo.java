package com.corp.portal.repos;

import com.corp.portal.domain.Route;
import com.corp.portal.domain.Sequence;
import org.springframework.data.repository.CrudRepository;

public interface RouteRepo extends CrudRepository<Route, Long> {
    Route findByName(String name);


}

