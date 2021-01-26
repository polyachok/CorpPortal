package com.corp.portal.service;

import com.corp.portal.domain.PComment;
import com.corp.portal.domain.PrCoFile;
import com.corp.portal.domain.Project;
import com.corp.portal.domain.User;
import com.corp.portal.repos.PrCoFileRepo;
import com.corp.portal.repos.ProjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ProjectService {
    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private PrCoFileRepo fileRepo;

    public boolean addProject(Project project, User user){
        Project projectFromDb = projectRepo.findById(project.getId()).get();
        if (projectFromDb != null){
            return false;
        }
       // String dateCreate = new Date().toString();
        project.setAuthor(user);
        project.setDatecreate(new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).format(new Date()));
        projectRepo.save(project);
        return true;
    }

    public List findAll() {
        return (List) projectRepo.findAll();
    }

    public Project findById(Long project_id){
        Project project = projectRepo.findById(project_id).get();
        return  project;
    }
    public List findByAuthor(User author){
        return  projectRepo.findByAuthor(author);
    }


    public List<Project> getByParent(Project project) {
         List<Project> projectList = projectRepo.findAllByParent(project);
        return projectList;
    }

    public PrCoFile getFile(String fileId) {
        return fileRepo.findById(Long.parseLong(fileId)).get();
    }
}
