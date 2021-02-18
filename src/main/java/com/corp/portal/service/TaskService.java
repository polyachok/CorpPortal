package com.corp.portal.service;

import com.corp.portal.domain.Project;
import com.corp.portal.domain.TaCoFile;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import com.corp.portal.repos.TaskCoFileRepo;
import com.corp.portal.repos.TaskRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class TaskService {

    @Autowired
    private TaskRepo taskRepo;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private TaskCoFileRepo taskCoFileRepo;

    @Autowired
    private FileService fileService;

    public List findByAuthor(User author) throws ParseException {
       List<Task> taskList = taskRepo.findByAuthor(author);
       for (Task task: taskList){
           task.setDeadLineStatus(checkDeadline(task.getDeadline()));
       }
        return taskList;
    }

    public List projectList(User user){
       return projectService.findByAuthorOrTeam(user);
    }

    public void createTask(User user, Task task) throws ParseException {
        task.setAuthor(user);
        task.setDeadLineStatus(checkDeadline(task.getDeadline()));
       // projectService.updateTeamProject(parentId(task), task.getResponsible(), (HashSet) task.getTeam());
        String parentPath;
       if (task.getParentT() != 0){
           parentPath = findById(task.getParentT()).getPath();
       }else {
          parentPath =  projectService.findById(task.getParentP()).getPath();
       }
       task.setPath(fileService.createTaskPath(task, parentPath));

       taskRepo.save(task);
    }

    public Long parentId(Task task){
        if (task.getParentP() == 0){
            Task parent = findById(task.getParentT());
            parentId(parent);
        }
        return task.getParentP();
    }

    public boolean checkDeadline(String deadline) throws ParseException {
        System.out.println("TaskService.checkDeadline");
        Date format = new SimpleDateFormat("dd.MM.yyyy").parse(deadline);
        System.out.println("TaskService.checkDeadline");
        if (format.before(new Date())){
            return true;
        }else {
            return false;
        }
    }

    public List<Task> getByParentTask(Task task){
        List<Task> taskList = taskRepo.findByParentT(task.getId());
        return taskList;
    }

    public List<Task> getByParentProject(User user, Project project){
        List<Task> taskList = taskRepo.findByParentP(project.getId());
        return checkAccessTask(taskList,user);
    }

    public List<Task> checkAccessTask(List<Task> taskList, User user){
        List<Task> finalTaskList = new ArrayList<>();
        for (Task task : taskList){
            if (task.getTeam().size() == 0){
                if (task.getAuthor().getId().equals(user.getId()) || task.getResponsible().getId().equals(user.getId())){
                    finalTaskList.add(task);
                }
            }else {
                for (User team : task.getTeam()) {
                    if (task.getAuthor().getId().equals(user.getId()) || task.getResponsible().getId().equals(user.getId()) || team.getId().equals(user.getId())) {
                        finalTaskList.add(task);
                    }
                }
            }
        }
        return finalTaskList;
    }

    public TaCoFile getFile(String fileId) {
        return taskCoFileRepo.findById(Long.parseLong(fileId)).get();
    }

    public Task findById(Long taskId){
        return taskRepo.findById(taskId).get();
    }

    public List findByTeam(User user) {
        return taskRepo.findByTeam(user);
    }

    public List findByAuthorOrTeamOrResponsible(User user){
        User author = user;
        User team = user;
        User responsible = user;
        return taskRepo.findByAuthorOrTeamOrResponsible(author, team, responsible);
    }

    public List findBuTeamOrResponsible(User user){
        User team = user;
        User responsible = user;
        return taskRepo.findByTeamOrResponsible(team, responsible);
    }

    public List findProjectByAuthorOrTeam(User user){
       return projectService.findByAuthorOrTeam(user);
    }
}
