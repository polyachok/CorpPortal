package com.corp.portal.controller;

import com.corp.portal.domain.Config;
import com.corp.portal.domain.Route;
import com.corp.portal.repos.ConfigRepo;
import com.corp.portal.service.AgreementService;
import com.corp.portal.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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

    @Autowired
    private UserService userService;

    @Autowired
    private AgreementService agreementService;
    @GetMapping
    public String getConfigure(Model model){
        model.addAttribute("userList", userService.findAll());
        model.addAttribute("config", configRepo.findAll());
        model.addAttribute("route", agreementService.getRouteList());
        return "config";
    }

    @PostMapping
    public String addParam(Config config){
        configRepo.save(config);
        return "redirect:/config";
    }

    @PostMapping("/route")
    public String addRoute(@RequestParam Map<String, String> form, Route route){
        agreementService.addRoute(route, form);
        return "redirect:/config";
    }

}
