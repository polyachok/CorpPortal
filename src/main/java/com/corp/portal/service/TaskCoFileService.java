package com.corp.portal.service;

import com.corp.portal.domain.*;
import com.corp.portal.repos.PrCoFileRepo;
import com.corp.portal.repos.TaskCoFileRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Set;

@Service
public class TaskCoFileService {

    @Autowired
    private TaskCoFileRepo fileRepo;

    public Boolean addFile(String uploadPath, MultipartFile[] file, User user, TComment comment) throws IOException {
        File uploadDir = new File(uploadPath);
        for (int i = 0; i < file.length; i++){
            String fileName = file[i].getOriginalFilename();
            file[i].transferTo(new File(uploadDir, fileName));
            TaCoFile taCoFile = new TaCoFile();
            taCoFile.setName(fileName);
            taCoFile.setDatecreate(new SimpleDateFormat("dd MMM yyyy HH:mm", new Locale("ru")).format(new Date()));
            taCoFile.setAuthor(user);
            taCoFile.setPath(uploadPath);
            taCoFile.setParent(comment.getId());
            fileRepo.save(taCoFile);
        }
        Set fileList = fileRepo.findByParent(comment.getId());
        comment.setFile(fileList);
        //pCommentRepo.save(commentDb);
        // comment.setFile();
        return true;
    }
}
