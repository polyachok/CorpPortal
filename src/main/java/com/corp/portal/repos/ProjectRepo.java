package com.corp.portal.repos;

import com.corp.portal.domain.Project;
import com.corp.portal.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;


public interface ProjectRepo extends CrudRepository<Project, Long> {
    Project findByName(String name);
    List findByAuthor(User author);
    List findAllByParent(Long id);
    List findByTeam(User team);
}