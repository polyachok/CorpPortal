package com.corp.portal.service;

import com.corp.portal.domain.*;
import com.corp.portal.repos.AgFileRepo;
import com.corp.portal.repos.PrCoFileRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Set;

@Service
public class AgFileService {

    @Autowired
    private AgFileRepo fileRepo;

    public Boolean addFile(String uploadPath, MultipartFile[] file, User user, Agreement agreement) {
    try {
        File uploadDir = new File(uploadPath);
        for (int i = 0; i < file.length; i++){
            String fileName = file[i].getOriginalFilename();
            file[i].transferTo(new File(uploadDir, fileName));
            AgFile agFile = new AgFile();
            agFile.setName(fileName);
            agFile.setDatecreate(new SimpleDateFormat("dd MMM yyyy HH:mm", new Locale("ru")).format(new Date()));
            agFile.setAuthor(user);
            agFile.setPath(uploadPath);
            agFile.setAgreement(agreement);
            fileRepo.save(agFile);
        }
        List fileList = fileRepo.findByAgreement(agreement);
        agreement.setFile(fileList);
        //pCommentRepo.save(commentDb);
        // comment.setFile();
        System.out.println("123");
    }catch (IOException e){

    }
        return true;
    }

    public AgFile findById(Long id) {
        return fileRepo.findById(id).get();
    }
}
