package com.corp.portal.controller;

import com.corp.portal.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("company")
public class companyController {

    @Autowired
    private CompanyService companyService;

}
