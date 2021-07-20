package com.corp.portal.controller;

import com.corp.portal.domain.ContractFile;
import com.corp.portal.domain.User;
import com.corp.portal.service.ContractService;
import org.bouncycastle.math.raw.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("contract")
public class contractController {

    @Autowired
    private ContractService contractService;

    @GetMapping
    public String contractList(@AuthenticationPrincipal User user,
                               Model model){
        model.addAttribute("list",contractService.getContractListByAuthor(user));
        return "contractList";
    }

    @GetMapping("/add")
    public String addContract(Model model){
        model.addAttribute("companyList1", contractService.getCompanyList());
        model.addAttribute("companyList2", contractService.getOurCompanyList());
        return "contractAdd";
    }

    @PostMapping
    public String createContract(@AuthenticationPrincipal User user,
                                 @RequestParam Map<String,String> form,
                                 @RequestParam("file") MultipartFile[] file
                                 ) {
        contractService.createContract(form,user,file);
        return "redirect:/contract";
    }

// TODO: 14.05.2021 дописать проверку на пустой договор как при создании компании
    @PostMapping("uploadFile")
    public @ResponseBody
    List ajaxFile(@RequestParam("file[]") MultipartFile[] file,
                  Model model)  {
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
                        @RequestParam(value= "type", required = false) Integer t,
                        HttpServletResponse response
    )  {

        ContractFile fileDb = contractService.getContractFile(fileId);
        contractService.downloadContractFile(fileDb.getPath(),response,fileDb.getName());
    }

    @GetMapping("{contract}")
    public String contractIn(@AuthenticationPrincipal User user, @PathVariable("contract") Long id,
                             Model model){
        model.addAttribute("contract", contractService.findById(id));
        model.addAttribute("user", user);

        return "contractIn";
    }

}
