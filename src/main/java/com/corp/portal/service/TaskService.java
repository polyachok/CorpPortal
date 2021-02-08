package com.corp.portal.service;

import com.corp.portal.domain.TaCoFile;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import com.corp.portal.repos.TaskCoFileRepo;
import com.corp.portal.repos.TaskRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class TaskService {

    @Autowired
    private TaskRepo taskRepo;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private TaskCoFileRepo taskCoFileRepo;

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

    public void createTask(User user, Map<String, String> form, Task task) throws ParseException {
        task.setAuthor(user);
        task.setDeadLineStatus(checkDeadline(task.getDeadline()));
        taskRepo.save(task);
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

    public List<Task> getByParent(Task task){
        List<Task> taskList = taskRepo.findByParentT(task.getId());
        return taskList;
    }

    public TaCoFile getFile(String fileId) {
        return taskCoFileRepo.findById(Long.parseLong(fileId)).get();
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
}
