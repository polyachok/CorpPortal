package com.corp.portal.controller;

import com.corp.portal.domain.Role;
import com.corp.portal.domain.User;
import com.corp.portal.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/user")
public class userController {

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String userList(Model model){
        model.addAttribute("users", userService.findAll());
        return "userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/add")
    public String userAdd(){
        return "userAdd";
    }

    @PostMapping("/add")
    public String create(
            @Valid User user,
            BindingResult bindingResult,
            @RequestParam Map<String, String> form,
            Model model
    ){
        if (bindingResult.hasErrors()){
            Map<String, String> errors = UtilsController.getErrors(bindingResult);
            model.mergeAttributes(errors);
            System.out.println(errors);
            return "userAdd";
        }
        if (userService.addUser(user)) {
            model.addAttribute("usr", user);
            return "redirect:/user";
        }
        return "userAdd";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }


    //TODO доделать профайл
    @GetMapping("/profile")
    public String getProfile(Model model, @AuthenticationPrincipal User user){
        if (user.getActivationCode() != null){
            model.addAttribute("message", "Email note activate!");
        }
        model.addAttribute("usr", userService.findById(user.getId()));

        return "profile";
    }

    @PostMapping("profile")
    public String updateProfile(
            @Valid User user,
            BindingResult bindingResult,
            @RequestParam Map<String, String> form,
            Model model
    ){
        if (bindingResult.hasErrors()){
            Map<String, String> errors = UtilsController.getErrors(bindingResult);
            model.mergeAttributes(errors);
            System.out.println(errors);
            return "profile";
        }
        if (userService.updateProfile(user,form)) {
            model.addAttribute("usr", user);
            return "redirect:/user/profile";
        }
        return "profile";
    }

}
