package com.corp.portal.service;

import com.corp.portal.domain.PrCoFile;
import com.corp.portal.domain.Project;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import com.corp.portal.repos.PrCoFileRepo;
import com.corp.portal.repos.ProjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;

@Service
public class ProjectService {
    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private PrCoFileRepo fileRepo;

    @Autowired
    private FileService fileService;

    @Autowired
    private TaskService taskService;

    @Autowired
    private MailService mailService;

    public boolean addProject(Project project, User user)  {
        if (project.getId() != null){
            return false;
        }
        project.setDatecreate(new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).format(new Date()));
        String parent;
        if (project.getParent() != 0){
             parent = findById(project.getParent()).getPath();
        }else {
            parent = "";
        }
        project.setPath(fileService.createProjectPath(project, parent));
        project.setAuthor(user);
        projectRepo.save(project);
        mailService.sendNewProjectMessage(project.getTeam(), project);
        return true;
    }

    public boolean updateProject(Project project)  {
        String parent;
        if (project.getParent() != 0){
            parent = findById(project.getParent()).getPath();
        }else {
            parent = "";
        }
        Project projectDb = projectRepo.findById(project.getId()).get();
        if (project.getName() != projectDb.getName()) {
            projectDb.setName(project.getName());
            projectDb.setPath(fileService.updateProjectPath(projectDb, parent));
        }

        projectDb.setDescription(project.getDescription());
        projectDb.setTeam(project.getTeam());
        projectDb.setStatus(project.getStatus());
        projectDb.setParent(project.getParent());

        projectRepo.save(projectDb);
        return true;
    }

    public boolean updateTeamProject(Long projectId, User responsible, HashSet team){
    return true;
    }

    public List findAll() {
        return (List) projectRepo.findAll();
    }

    public List findByAuthorOrTeam(User user){
        User author = user;
        List<Project> projectListByTeam = projectRepo.findByTeam(user);
        List<Project> projectList = projectRepo.findByAuthor(user);
        projectList.addAll(projectListByTeam);
        System.out.println("ProjectService.findByAuthorOrTeam");
        return projectList;
    }

    public Project findById(Long project_id){
        Project project = projectRepo.findById(project_id).get();
        return  project;
    }

    public List findByAuthor(User author){
        return  projectRepo.findByAuthor(author);
    }

    public List<Project> getByParent(Project project) {
         List<Project> projectList = projectRepo.findAllByParent(project.getId());
        return projectList;
    }

    public PrCoFile getFile(String fileId) {
        return fileRepo.findById(Long.parseLong(fileId)).get();
    }

    public boolean checkPath(String path){
        File dir = new File(path);
        if (dir.exists()){
            return true;
            }
        return false;
    }

    public List<Task> getByParentProject(User user, Project project) {
        List<Task> taskList = taskService.getByParentProject(user, project);
        return taskList;
    }



}
