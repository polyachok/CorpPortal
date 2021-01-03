package com.corp.portal.repos;

import com.corp.portal.domain.AbstractProject;
import com.corp.portal.domain.Project;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProjectRepo extends CrudRepository<Project, Long> {
    Project findByName(String name);
}
