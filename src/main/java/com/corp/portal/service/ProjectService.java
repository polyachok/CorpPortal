package com.corp.portal.service;

import com.corp.portal.domain.Project;
import com.corp.portal.domain.User;
import com.corp.portal.repos.ProjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ProjectService {
    @Autowired
    private ProjectRepo projectRepo;

    public boolean addProject(Project project, User user){
        Project projectFromDb = projectRepo.findByName(project.getName());
        if (projectFromDb != null){
            return false;
        }
        Date dateCreate = new Date();
        project.setAuthor(user);
        project.setDateCreate(dateCreate);

        projectRepo.save(project);

        return true;
    }

    public List findAll() {
        return (List) projectRepo.findAll();
    }


}
