package com.corp.portal.controller;

import com.corp.portal.domain.Config;
import com.corp.portal.repos.ConfigRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/config")
public class configController {

    @Autowired
    private ConfigRepo configRepo;

    @GetMapping
    public String getConfigure(Model model){
        System.out.println("configController.getConfigure");
        model.addAttribute("config", configRepo.findAll());
        return "config";
    }

    @PostMapping
    public String addParam(Config config){
        configRepo.save(config);
        return "redirect:/config";
    }

}
