package com.corp.portal.repos;

import com.corp.portal.domain.Route;
import com.corp.portal.domain.Sequence;
import com.corp.portal.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SequenceRepo extends CrudRepository<Sequence, Long> {

    List findByRoute(Route route);



}

