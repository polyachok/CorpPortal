package com.corp.portal.service;

import com.corp.portal.domain.*;
import com.corp.portal.repos.AgCommentRepo;
import com.corp.portal.repos.AgreementRepo;
import com.corp.portal.repos.PCommentRepo;
import com.corp.portal.repos.ProjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Service
public class AgCommentService {

    @Autowired
    private AgCommentRepo agCommentRepo;

    @Autowired
    private AgreementRepo agreementRepo;

    @Autowired
    private UtilService utilService;

    @Autowired
    private AgFileService fileService;

    @Autowired
    private MailService mailService;


    public Agreement addComment(User user, Map<String, String> form, MultipartFile[] file) {
        AgComment comment = new AgComment();

        Agreement agreement = agreementRepo.findById(Long.parseLong(form.get("ag_id"))).get();
          if (!form.get("editordata").isEmpty()) {
              comment.setAuthor(user);
              comment.setDatecreate(utilService.dateOfStr());
              comment.setParent(agreement.getId());
              comment.setDescription(form.get("editordata"));
              agCommentRepo.save(comment);
              List list1 = agCommentRepo.findByParentOrderByDatecreateAsc(agreement.getId());
              agreement.setComment(list1);
          }

        if (!file[0].getOriginalFilename().isEmpty()){
            fileService.addFile(agreement.getPath(),file,user,agreement);
        }
        agreementRepo.save(agreement);
        if (agreement.getDatecreate() != comment.getDatecreate()){

            mailService.sendNewCommentAg(agreement, user);
        }
        return agreement;
    }

    public List findAllByParent(Long agreement){
        List list = agCommentRepo.findByParentOrderByDatecreateAsc(agreement);
        return list;
    }
}
