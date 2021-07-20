package com.corp.portal.controller;

import com.corp.portal.domain.*;
import com.corp.portal.service.AgCommentService;
import com.corp.portal.service.TCommentService;
import com.corp.portal.service.TaskService;
import com.corp.portal.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/task")
public class taskController {

    @Autowired
    private TaskService taskService;
    @Autowired
    private UserService userService;
    @Autowired
    private TCommentService commentService;
    @Autowired
    private AgCommentService agCommentService;

    @GetMapping("/outgoing")
    public String taskOutList(Model model) throws ParseException {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List taskList = taskService.findByAuthor((User) userDetails, Long.valueOf(0));
        if (taskList != null){
            model.addAttribute("tasks", taskList);
        }
        model.addAttribute("taskType", "Исходящие задачи");
        return "task";
    }

    @GetMapping("/incoming")
    public String taskInList(Model model) {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List taskList = taskService.findBuTeamOrResponsible((User) userDetails, Long.valueOf(0));
        if (taskList != null){
            model.addAttribute("tasks", taskList);
        }
        model.addAttribute("taskType", "Входящие задачи");
        return "task";
    }

    @GetMapping("/add")
    public String taskAdd(@AuthenticationPrincipal User user, Model model){
        List projectList = taskService.projectList(user);
        if (projectList != null){
            model.addAttribute("projectList", projectList);
        }
        List taskList = taskService.findByAuthorOrTeamOrResponsible(user);
        if (taskList.size() != 0){
            model.addAttribute("taskList", taskList);
        }
        List userList = userService.findAll();
        model.addAttribute("userList", userList);
        return "taskAdd";
    }

    @PostMapping
    public String createTask(
            @AuthenticationPrincipal User user,
            @RequestParam Map<String, String> form,
            Task task) throws ParseException {
        taskService.createTask(user, task, Long.valueOf(0));
        return "redirect:/task/outgoing";
    }


    @GetMapping("{task}")
    public String taskInfo(@RequestParam(required = false) String action, @PathVariable Task task, Model model){
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = (User) userDetails;
        List<Task> childList = taskService.getByParentTask(task);
        if (childList.size() != 0){
            model.addAttribute("childTask", childList);
        }
        List<TComment> comment = commentService.findAllByParent(task.getId());
        if (comment.size() != 0){
            model.addAttribute("comments", comment);
        }
        if (user.getId().equals(task.getAuthor().getId())){
            List projectList = taskService.findProjectByAuthorOrTeam(user);
            if (projectList != null) {
                model.addAttribute("projects", projectList);
            }
            model.addAttribute("userList",userService.findAll());
            model.addAttribute("task",task);
            model.addAttribute("author", true);
        }
        if (action != null){
            taskService.setTaskStatus(task,action);
        }
        if (task.getType() == 0){
            model.addAttribute("type", "task");
        }else {
            model.addAttribute("type", "agTask");
            model.addAttribute("files", taskService.getAgListFile(task));
            model.addAttribute("contract",taskService.getContract(task));
            model.addAttribute("agCommentsList", agCommentService.findAllByParent(task.getParentA()));
           // if (task.getParentT() != 0){
            model.addAttribute("parentFileList", taskService.getAgTaskFile(task));
            model.addAttribute("parentCommentList", taskService.getAgTaskComment(task));
               // model.addAttribute("parentAgTask",taskService.findById(task.getParentT()));
               // for (Task task1: taskService.getAgTaskComment(task)){
              //      System.out.println("taskController.taskInfo - " + task1.getId());
              //  }

           // }

        }
        if (task.getType() != 1){
            if (task.getParentT() != 0) {
                model.addAttribute("parentT", true);
            }
            model.addAttribute("parent", taskService.findParent(task));
        }
        if (taskService.findAgreementByAuthorOrResponsible(task, user) != null){
            model.addAttribute("childAg", taskService.findAgreementByAuthorOrResponsible(task, user));
        }
        model.addAttribute("taskList", taskService.findByAuthorOrTeamOrResponsible(user));
        model.addAttribute("taskAction", taskService.getTaskAction(task, user));
        //todo заблокировать задачу на редактирование после согласования
        return "taskInfo";
    }

    @PostMapping("update")
    public String updateTask(Task task){
        taskService.updateTask(task);
        return "redirect:/task/"+task.getId();
    }

    @PostMapping("approve")
    public String approve(@RequestParam Map<String,String> form){
        taskService.setApprove(Long.valueOf(form.get("id")), form.get("agComment"), form.get("action"));
        return "redirect:/agreement/incoming";
    }

    @PostMapping("comment")
    public String addComment(@AuthenticationPrincipal User user,
                             @RequestParam Map<String,String> form,
                             @RequestParam("file") MultipartFile[] file) throws IOException {
        if (form.get("editordata").isEmpty() && file[0].getOriginalFilename().isEmpty()){
            return "redirect:/task/" + form.get("task_id");
        } else {
            Task task = commentService.addComment(user, form, file);
            return "redirect:/task/" + form.get("task_id");
        }
    }

    @PostMapping("uploadFile")
    public @ResponseBody List ajaxFile(@RequestParam("file[]") MultipartFile[] file,
                                       Model model) throws IOException {
        List fileName = new ArrayList();
        for (int i = 0; i < file.length; i++){

            fileName.add(file[i].getOriginalFilename());
            fileName.add("&emsp;");
        }
        return fileName;
    }

    @GetMapping("/file/{file_name}")
    public void getFile(@PathVariable("file_name") String fileName,
                        @RequestParam("id") String fileId,
                        @RequestParam(value= "type", required = false) Integer t,
                        HttpServletResponse response
    )  {
        if (t != null && t == 1){
            AgFile fileDb = taskService.getAgFile(fileId);
            taskService.downloadFile(fileDb.getPath(),fileDb.getName(),response);
        }else {
            TaCoFile fileDb = taskService.getFile(fileId);
            taskService.downloadFile(fileDb.getPath(),fileDb.getName(),response);
        }

    }


}
