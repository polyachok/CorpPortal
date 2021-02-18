package com.corp.portal.controller;

import com.corp.portal.domain.TComment;
import com.corp.portal.domain.TaCoFile;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
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

    @GetMapping("/outgoing")
    public String taskOutList(Model model) throws ParseException {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List taskList = taskService.findByAuthor((User) userDetails);
        if (taskList != null){
            model.addAttribute("tasks", taskList);
        }
        model.addAttribute("taskType", "Исходящие задачи");
        return "task";
    }

    @GetMapping("/incoming")
    public String taskInList(Model model) {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List taskList = taskService.findBuTeamOrResponsible((User) userDetails);
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
        taskService.createTask(user, task);
        return "redirect:/task/outgoing";
    }


    @GetMapping("{task}")
    public String taskInfo(@PathVariable Task task, Model model){
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
            List userList = userService.findAll();
            model.addAttribute("userList",userList);
            model.addAttribute("task",task);
        }
        return "taskInfo";
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
                        HttpServletResponse response
    ) throws IOException {
        TaCoFile fileDb = taskService.getFile(fileId);
        String filePath = fileDb.getPath() + "/" + fileDb.getName();
        Path file = Paths.get(filePath);
        String type = Files.probeContentType(file);
        response.setContentType(type);
        response.setHeader("Content-disposition", "attachment; filename=" + fileName);

        try {
            Files.copy(file, response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e){

        }
    }


}
