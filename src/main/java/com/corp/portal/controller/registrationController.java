package com.corp.portal.controller;

import com.corp.portal.domain.User;
import com.corp.portal.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Map;

@Controller
public class registrationController {

   @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration(){
        return "registration";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code){
        boolean isActivated = userService.activateUser(code);

        if (isActivated){
            model.addAttribute("message", "Activate success!");
        }else{
            model.addAttribute("messages", "Activate not found!");
        }
        return "login";
    }


    @PostMapping("/registration")
    public String addUser(User user, Map<String, Object> model){
        if (!userService.addUser(user)){
            model.put("message", "User exist!");
            return "registration";
        }
        return "redirect:/login";
    }

}
