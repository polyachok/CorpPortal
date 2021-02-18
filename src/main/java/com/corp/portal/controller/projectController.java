package com.corp.portal.controller;

import com.corp.portal.domain.*;
import com.corp.portal.service.PCommentService;
import com.corp.portal.service.ProjectService;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/project")
public class projectController {

@Autowired
private ProjectService projectService;

@Autowired
private UserService userService;

@Autowired
private PCommentService commentService;



@GetMapping
    public String projectList(Model model){
    UserDetails userDetails =
            (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    List projectList = projectService.findByAuthorOrTeam((User) userDetails);
    if (projectList != null) {
        model.addAttribute("projects", projectList);
    }
    return "proj";
}

@GetMapping("/add")
    public String projAdd(Model model){
    UserDetails userDetails =
            (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

    List projectList = projectService.findByAuthorOrTeam((User) userDetails);
    if (projectList != null) {
        model.addAttribute("projects", projectList);
    }
        List userList = userService.findAll();
        model.addAttribute("userList",userList);
        return "projAdd";
    }

    @PostMapping
    public String createProject(
            @AuthenticationPrincipal User user,
            Project project,
            Model model) {
        projectService.addProject(project, user);
        return "redirect:/project";
    }

    @PostMapping("update")
    public String updateProject(
            Project project
    ){
    projectService.updateProject(project);
    return "redirect:/project/"+ project.getId();
    }

    @GetMapping("{project}")
    public String projectInfo(@PathVariable Project project, Model model){
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = (User) userDetails;
        List<Project> childProject = projectService.getByParent(project);
        if (childProject.size() != 0){
            model.addAttribute("childProject" , childProject);
        }
        List<Task> childTask = projectService.getByParentProject(user, project);

        if (childTask.size() !=0){
            model.addAttribute("childTask", childTask);
        }
        List<PComment> comment = commentService.findAllByParent(project.getId());
        if (comment.size() != 0){
            model.addAttribute("comments", comment);
        }
        if (user.getId().equals(project.getAuthor().getId())){
            List projectList = projectService.findByAuthorOrTeam(user);
            if (projectList != null) {
                model.addAttribute("projects", projectList);
            }
            List userList = userService.findAll();
            model.addAttribute("userList",userList);
            System.out.println("projectController.projectInfo");
        }
        model.addAttribute("team", project.getTeam());
        model.addAttribute("project", projectService.findById(project.getId()));
        return "projInfo";
    }

    @PostMapping("comment")
    public String addComment(@AuthenticationPrincipal User user,
                           @RequestParam Map<String, String> form,
                           @RequestParam("file") MultipartFile[] file,
                           Model model) throws IOException {
        if (form.get("editordata").isEmpty() && file[0].getOriginalFilename().isEmpty()) {
           Project project = projectService.findById(Long.parseLong(form.get("project_id")));
            return "redirect:/project/" + project.getId();
        }else {
            Project project = commentService.addComment(user, form, file);
            return "redirect:/project/" + project.getId();
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
        PrCoFile fileDb = projectService.getFile(fileId);
        String filePath = fileDb.getPath() + "/" + fileDb.getName();
        Path file = Paths.get(filePath);
        System.out.println("projectController.getFile");
        String type = Files.probeContentType(file);
        response.setContentType(type);
        response.setHeader("Content-disposition", "attachment; filename=" + fileName);

        try {
            Files.copy(file, response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e){

        }
        System.out.println("projectController.getFile");
    }

}
