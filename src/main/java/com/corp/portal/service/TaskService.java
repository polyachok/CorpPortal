package com.corp.portal.service;

import com.corp.portal.domain.*;
import com.corp.portal.repos.TaskCoFileRepo;
import com.corp.portal.repos.TaskRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

    @Autowired
    private AgreementService agreementService;

    @Autowired
    private TCommentService commentService;

    @Autowired
    private UtilService utilService;

    public void createTask(User user, Task task, Long type) throws ParseException {
        task.setAuthor(user);
        task.setType(type);
        task.setDeadLineStatus(checkDeadline(task.getDeadline()));
        task.setStatus("Не принята");
        task.setParentA(Long.valueOf(0));
       // projectService.updateTeamProject(parentId(task), task.getResponsible(), (HashSet) task.getTeam());
        String parentPath;
       if (task.getParentT() != 0){
           parentPath = findById(task.getParentT()).getPath();
       }else {
          parentPath =  projectService.findById(task.getParentP()).getPath();
       }
       task.setPath(fileService.createTaskPath(task, parentPath));
       taskRepo.save(task);
       setLastActive(task);
       mailService.sendNewTaskTeamMessage(task.getTeam(), task);
       mailService.sendNewTaskResponsibleMessage(task.getResponsible(), task);
    }

    public void createAgTask(Agreement agreement, Route route, List<Sequence> sequences){
        int i = 0;
        for (Sequence one: sequences){
            Task agTask = new Task();
            agTask.setName(agreement.getName() + " - Этап " + one.getNumber());
            agTask.setDatecreate(agreement.getDatecreate());

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
                setDeadline(agTask, one.getDeadline());
                mailService.sendAgreementNextStage(agTask);
            }else {
                User responsible = sequences.get(i - 1).getUser();
                agTask.setParentT(getAgTaskByAgreementAndResponsible(agreement,responsible).getId());
                agTask.setStatus("Не активная");
                agTask.setDeadline(String.valueOf(one.getDeadline()));
            }
            i++;
        }
    }

    public List getAgTaskComment(Task agTask){
        return taskRepo.findByParentAAndStatusNot(agTask.getParentA(), "Не активная");
    }

    public List getAllParentComment(Task agTask){
        List list = new ArrayList<>();
        for (Task task : taskRepo.findByParentAAndStatusNot(agTask.getParentA(), "Не активная")){
            for (TComment comment : commentService.findAllCommentAg(task.getId())){
                if (comment.getFile().size() != 0){
                    list.add(comment);
                }
            }
        }
        return list;
    }

    public Object getAgTaskFile(Task task) {
        return getAllParentComment(task);
    }

    public List<AgFile> getAgListFile(Task agTask){
        return agreementService.getFileList(agTask);
    }

    public AgFile getAgFile(String fileId){
        return agreementService.getFile(Long.valueOf(fileId));
    }

    public Task getAgTaskByAgreementAndResponsible(Agreement agreement, User responsible){
        return taskRepo.findByParentAAndResponsible(agreement.getId(), responsible);
    }

    public List<Task> getByAgreement(Agreement agreement){
        return taskRepo.findByParentAOrderByIdAsc(agreement.getId());
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
               case "Согласовать" : action = 9;
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
                case "Согласовать" : action = 9;
                break;
                default: action = 1;
            }
        }
        return action;
    }

    public List<Task> getByParentTask(Task task){
        return taskRepo.findByParentTAndStatusNot(task.getId(), "Не активная");
    }

    public List<Task> getByParentProject(User user, Project project){
        List<Task> taskList = taskRepo.findByParentP(project.getId());
        return checkAccessTask(taskList,user);
    }

    public TaCoFile getFile(String fileId) {
        return taskCoFileRepo.findById(Long.parseLong(fileId)).get();
    }

    public Task findById(Long taskId){
        return taskRepo.findById(taskId).get();
    }

    public List findByAuthor(User author, Long type) throws ParseException {
        List<Task> taskList = taskRepo.findByAuthorAndType(author, type);
        for (Task task: taskList){
            task.setDeadLineStatus(checkDeadline(task.getDeadline()));
        }
        return taskList;
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
        return taskRepo.findByResponsibleAndTypeAndStatusNot(responsible, Long.valueOf(1), "Не активная");
    }

    public List findAgreementByAuthorOrResponsible(Task task, User user){
        return agreementService.findAgreement(task, user);
    }

    public void setTaskStatus(Task task, String action) {
        switch (action){
            case "accept":
                task.setStatus("Активная");
                setLastActive(task);
            break;
            case "deny" : task.setStatus("Отказ");
                setLastActive(task);
            break;
            case "complete" : task.setStatus("Завершение");
                setLastActive(task);
            break;
            case "begin" : task.setStatus("Не принята");
                setLastActive(task);
            break;
            case "close" :
                task.setStatus("Закрыта");
                task.setClosed(true);
                setDateClose(task);
                break;
        }
    }

    public void setApprove(Long taskId, String text){
        Task task = taskRepo.findById(taskId).get();
        task.setStatus("Согласовано");
        taskApprove(task);
        setLastActive(task);
        task.setClosed(true);
        setagComment(text, taskId);
        setDateClose(task);

    }

    public void setLastActive(Task task){
        Task taskDb = taskRepo.findById(task.getId()).get();
        taskDb.setLastActive(utilService.dateOfStr());
        if (task.getParentA() != 0){
            agreementService.setLastActive(task.getParentA());
        }
        taskRepo.save(taskDb);
    }

    public void setDateClose(Task task){
        Task taskDb = taskRepo.findById(task.getId()).get();
        taskDb.setDateclose(new SimpleDateFormat("dd MMM yyyy H:m", new Locale("ru")).format(new Date()));
        taskRepo.save(taskDb);
    }

    public void taskApprove(Task task){
        Task agTask = taskRepo.findByParentTAndParentA(task.getId(), task.getParentA());
        if (agTask != null){
            setDeadline(agTask, Integer.valueOf(agTask.getDeadline()));
            agTask.setStatus("Согласовать");
            mailService.sendAgreementNextStage(agTask);
            mailService.sendAgreementStageAgreed(task);
            taskRepo.save(agTask);
            //todo сделать рассылку уведомлений на просрочку согласования
            //todo проверка дедлайна
        }else {
            agreementService.setStatus(task.getParentA());
        }

    }

    public void setDeadline(Task agTask, Integer i){
        Calendar calendar = GregorianCalendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR,i);
        agTask.setDeadline(new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).format( calendar.getTime()));
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
        setLastActive(taskDb);
        taskRepo.save(taskDb);
    }

    public HttpServletResponse downloadFile(String path, String name, HttpServletResponse response){
        try {
            String filePath = path + "/" + name;
            Path file = Paths.get(filePath);
            String type = Files.probeContentType(file);
            response.setContentType(type);
            response.setHeader("Content-disposition", "attachment; filename=" + name);
            Files.copy(file, response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e){
            System.out.println(e);
        }
        return response;
    }

    public List projectList(User user){
        return projectService.findByAuthorOrTeam(user);
    }

    public boolean checkDeadline(String deadline) throws ParseException {
        Date format = new SimpleDateFormat("dd.MM.yyyy").parse(deadline);
        if (format.before(new Date())){
            return true;
        }else {
            return false;
        }
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

    public Object findParent(Task task) {
        Object result;
        if (task.getParentT() != 0){
           result = taskRepo.findById(task.getParentT());
        }else {
            result = projectService.findById(task.getParentP());
        }
        return result;
    }

    public void setagComment(String text, Long agTaskId) {
        Task agTaskDb = taskRepo.findById(agTaskId).get();
        agTaskDb.setAgComment(text);
    }
}
