package com.corp.portal.controller;

import com.corp.portal.domain.Company;
import com.corp.portal.domain.User;
import com.corp.portal.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/company")
public class companyController {

    @Autowired
    private CompanyService companyService;

    @GetMapping
    private String companyList(Model model){
        model.addAttribute("list", companyService.findAll());
        return "companyList";
    }

    @GetMapping("/add")
    public String companyAdd(@AuthenticationPrincipal User user, Model model){
        return "compAdd";
    }

    @PostMapping()
    public String createCompany(@AuthenticationPrincipal User user, Model model, Company company){
        if(companyService.addCompany(company,user)){
            return "redirect:/";
        }else {
            model.addAttribute("message", "Такая организация уже существует в реестре!");
            return "compAdd";
        }

    }

    @GetMapping("{company}")
    public String companyInfo(@PathVariable("company") Long id, Model model){
        model.addAttribute("company", companyService.findById(id));
        model.addAttribute("contractList", companyService.findContractByCompany(id));
        return "companyInfo";
    }

}
