package com.corp.portal.controller;
import com.corp.portal.domain.Project;
import com.corp.portal.domain.User;
import com.corp.portal.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/project")
public class projectController {

@Autowired
private ProjectService projectService;

@GetMapping
    public String projectList(Model model){
    model.addAttribute("projects", projectService.findAll());
    return "proj";
}

@PostMapping
    public String addProject(
            @AuthenticationPrincipal User user,
            Project project,
            Model model){
    projectService.addProject(project,user);
    return "redirect:/project";
}
}
