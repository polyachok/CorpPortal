package com.corp.portal.controller;

import com.corp.portal.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/project")
public class projectController {

@Autowired
private ProjectService projectService;

@GetMapping
    public String projectList(Model model){
    //model.addAttribute("project", "project");
    return "proj";
}
}
