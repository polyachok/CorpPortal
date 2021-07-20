package com.corp.portal.controller;


import com.corp.portal.domain.*;
import com.corp.portal.service.AgCommentService;
import com.corp.portal.service.AgreementService;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/agreement")
public class agreementController {
   @Autowired
   private AgreementService agreementService;

   @Autowired
   private AgCommentService commentService;

    @GetMapping("/outgoing")
    public String agOutList(Model model){
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("agreements", agreementService.findByAuthor((User) userDetails));
        model.addAttribute("agType", "Исходящие согласования");
        return "agOut";
    }

    @GetMapping("/incoming")
    public String agInList(Model model){
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        model.addAttribute("agreements", agreementService.findByResponsible((User) userDetails));
        model.addAttribute("agType", "Входящие согласования");
        return "agIn";
    }

    @GetMapping("/add")
    public String agAdd(@AuthenticationPrincipal User user, Model model){
        model.addAttribute("route", agreementService.getRouteList());
        model.addAttribute("taskList", agreementService.findTask(user));
        model.addAttribute("userList", agreementService.findAllUser());
        model.addAttribute("contractList", agreementService.findAllContractByAuthorAndStatus(user, 0));
        return "agAdd";
    }

    @PostMapping("update")
    public String updateAgreement(Agreement agreement){
        agreementService.updateAg(agreement);
        return "redirect:/agreement/"+agreement.getId();
    }

    @PostMapping()
    public String createAgreement(@AuthenticationPrincipal User user,
                                  @RequestParam Map<String,String> form,
                                  @RequestParam("file") MultipartFile[] file
                                  /*Agreement agreement*/){
        agreementService.createAgreement(user,form,file);
        return "redirect:/agreement/outgoing";
    }

    @GetMapping("{agreement}")
    public String agOutInfo(@RequestParam(required = false) String action,
                         @PathVariable("agreement") Long id,
                         Model model){
        Agreement agreement = agreementService.findById(id);
       model.addAttribute("agreement", agreement);
       model.addAttribute("sequence", agreement.getRoute().getSequence());
       model.addAttribute("routeList", agreementService.getRouteList());
       model.addAttribute("agAction", 0);
       model.addAttribute("agTask", agreementService.findByAgreement(agreement));
       model.addAttribute("contract", agreementService.findContractById(agreement.getContract().getId()));
       if (agreement.getParentT() != 0 ) {
           model.addAttribute("parent", agreementService.getParentTask(agreement));
       }

       model.addAttribute("comments",commentService.findAllByParent(agreement.getId()));
        return "agInfo";
    }

    @GetMapping("/in/{agTask}")
    public String agInInfo(@RequestParam(required = false) String action,
                         @PathVariable("agTask") Long id,
                         Model model){
        Task agTask = agreementService.findTaskById(id);
        model.addAttribute("agreement", agTask);
        model.addAttribute("agAction", 0);
        return "taskInfo";
    }

    @PostMapping("uploadFile")
    public @ResponseBody
    List ajaxFile(@RequestParam("file[]") MultipartFile[] file) {
        List fileName = new ArrayList();
        for (int i = 0; i < file.length; i++){

            fileName.add(file[i].getOriginalFilename());
            fileName.add("&emsp;");
        }
        return fileName;
    }

    @GetMapping("fileApprove")
    public void approveFile(@RequestParam("agreement") String agreement,
                              HttpServletResponse response){
        String fileName = agreementService.createPdfFile(Long.valueOf(agreement));
        agreementService.downloadFile(agreement, response, fileName);
    }

    @PostMapping("comment")
    public String addComment(@AuthenticationPrincipal User user,
                             @RequestParam Map<String, String> form,
                             @RequestParam("file") MultipartFile[] file,
                             Model model) {
        if (form.get("editordata").isEmpty()&& file[0].getOriginalFilename().isEmpty()) {
            Agreement agreement = agreementService.findById(Long.parseLong(form.get("ag_id")));
            return "redirect:/agreement/" + agreement.getId();
        }else {
            Agreement agreement = commentService.addComment(user, form, file);
            return "redirect:/agreement/" + agreement.getId();
        }
    }


}
