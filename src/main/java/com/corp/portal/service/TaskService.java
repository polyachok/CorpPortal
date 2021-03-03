package com.corp.portal.service;

import com.corp.portal.domain.*;
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

    @Autowired
    private MailService mailService;

    public List findByAuthor(User author, Long type) throws ParseException {
       List<Task> taskList = taskRepo.findByAuthorAndType(author, type);
       for (Task task: taskList){
           task.setDeadLineStatus(checkDeadline(task.getDeadline()));
       }
        return taskList;
    }

    public List projectList(User user){
       return projectService.findByAuthorOrTeam(user);
    }

    public void createTask(User user, Task task, Long type) throws ParseException {
        task.setAuthor(user);
        task.setType(type);
        task.setDeadLineStatus(checkDeadline(task.getDeadline()));
        task.setStatus("Не принята");
       // projectService.updateTeamProject(parentId(task), task.getResponsible(), (HashSet) task.getTeam());
        String parentPath;
       if (task.getParentT() != 0){
           parentPath = findById(task.getParentT()).getPath();
       }else {
          parentPath =  projectService.findById(task.getParentP()).getPath();
       }
       task.setPath(fileService.createTaskPath(task, parentPath));
       taskRepo.save(task);
       mailService.sendNewTaskTeamMessage(task.getTeam(), task);
       mailService.sendNewTaskResponsibleMessage(task.getResponsible(), task);
    }

    public void createAgTask(Agreement agreement, Route route, List<Sequence> sequences){

        int i = 0;
        for (Sequence one: sequences){
            Task agTask = new Task();
            agTask.setName(agreement.getName() + " - Этап " + one.getNumber());
            agTask.setDatecreate(agreement.getDatecreate());
            agTask.setDeadline(" ");
            agTask.setDescription(agreement.getDescription());
            agTask.setAuthor(agreement.getAuthor());
            agTask.setResponsible(one.getUser());
            agTask.setParentA(agreement.getId());
            agTask.setParentP(Long.valueOf(0));
            agTask.setPath(fileService.createTaskPath(agTask, agreement.getPath()));
            agTask.setType(Long.valueOf(1));
            taskRepo.save(agTask);
            if (one.getNumber() == 1){
                agTask.setParentT(Long.valueOf(0));
                agTask.setStatus("Согласовать");
            }else {
                User responsible = sequences.get(i - 1).getUser();
                agTask.setParentT(getAgTaskByAgreementAndResponsible(agreement,responsible).getId());
                agTask.setStatus("Не активная");
            }
            i++;
        }

    }

    public Task getAgTaskByAgreementAndResponsible(Agreement agreement, User responsible){
        return taskRepo.findByParentAAndResponsible(agreement.getId(), responsible);
    }

    public List<Task> getByAgreement(Agreement agreement){
        return taskRepo.findByParentAOrderByIdAsc(agreement.getId());
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

    public int getTaskAction(Task task, User user) {
        int action = 0;
        if (task.getAuthor().getId().equals(user.getId())){
           switch (task.getStatus()){
               case "Отказ" : action = 2;
               break;
               case "Завершение" : action = 3;
               break;
               case "Завершена" : action = 4;
               break;
               default: action = 1;
           }
        }else if (task.getResponsible().getId().equals(user.getId())){
            switch (task.getStatus()){
                case "Не принята" : action = 5;
                    break;
                case "Отказ" : action = 5;
                    break;
                case "Завершение" : action = 7;
                break;
                case "Активная" : action = 8;
                break;
                default: action = 1;
            }
        }
        return action;
    }

    public List<Task> getByParentTask(Task task){
       // List<Task> taskList = taskRepo.findByParentT(task.getId());
        List<Task> taskList = taskRepo.findByParentTAndStatusNot(task.getId(), "Не активная");
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

    public List findByAuthorOrTeamOrResponsible(User user){
        User author = user;
        User team = user;
        User responsible = user;
        return taskRepo.findByAuthorOrTeamOrResponsible(author, team, responsible);
    }

    public List findBuTeamOrResponsible(User user,Long type){
        User team = user;
        User responsible = user;
        return taskRepo.findByTeamOrResponsibleAndType(team, responsible, type);
    }

    public List findProjectByAuthorOrTeam(User user){
       return projectService.findByAuthorOrTeam(user);
    }

    public List<Task> findByResponsible(User responsible){
        return taskRepo.findByResponsible(responsible);
    }

    public void setTaskStatus(Task task, String action) {
        switch (action){
            case "accept": task.setStatus("Активная");
            break;
            case "deny" : task.setStatus("Отказ");
            break;
            case "complete" : task.setStatus("Завершение");
            break;
            case "begin" : task.setStatus("Не принята");
            break;
            case "close" :
                task.setStatus("Закрыта");
                task.setClosed(true);
                break;
        }
    }

    public void updateTask(Task task) {
        String parent;
        if (task.getParentP() != 0){
            parent = projectService.findById(task.getParentP()).getPath();
        }else if (task.getParentT() != 0){
            parent = findById(task.getParentT()).getPath();
        }else {
            parent = "";
        }
        Task taskDb = taskRepo.findById(task.getId()).get();
        if (task.getName() != taskDb.getName()){
            taskDb.setName(task.getName());
            taskDb.setPath(fileService.updateTaskPath(taskDb, parent));
        }

        taskDb.setDescription(task.getDescription());
        taskDb.setDeadline(task.getDeadline());
        taskDb.setTeam(task.getTeam());
        taskDb.setResponsible(task.getResponsible());
        taskDb.setParentP(task.getParentP());
        taskDb.setParentT(task.getParentT());
        taskRepo.save(taskDb);

    }
}
