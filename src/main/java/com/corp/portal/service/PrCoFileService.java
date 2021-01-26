package com.corp.portal.service;

import com.corp.portal.domain.PComment;
import com.corp.portal.domain.PrCoFile;
import com.corp.portal.domain.User;
import com.corp.portal.repos.PrCoFileRepo;
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
public class PrCoFileService {

    @Autowired
    private PrCoFileRepo fileRepo;

    public Boolean addFile(String uploadPath, MultipartFile[] file, User user, PComment comment) throws IOException {
        File uploadDir = new File(uploadPath);
        for (int i = 0; i < file.length; i++){
            String fileName = file[i].getOriginalFilename();
            file[i].transferTo(new File(uploadDir, fileName));
            PrCoFile prCoFile = new PrCoFile();
            prCoFile.setName(fileName);
            prCoFile.setDatecreate(new SimpleDateFormat("dd MMM yyyy HH:mm", new Locale("ru")).format(new Date()));
            prCoFile.setAuthor(user);
            prCoFile.setPath(uploadPath);
            prCoFile.setParent(comment.getId());
            fileRepo.save(prCoFile);
        }
        Set fileList = fileRepo.findByParent(comment.getId());
        comment.setFile(fileList);
        //pCommentRepo.save(commentDb);
        // comment.setFile();
        return true;
    }
}
