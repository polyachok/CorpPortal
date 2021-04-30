package com.corp.portal.service;

import com.corp.portal.domain.PComment;
import com.corp.portal.domain.Project;
import com.corp.portal.domain.User;
import com.corp.portal.repos.PCommentRepo;
import com.corp.portal.repos.ProjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class PCommentService {

    @Autowired
    private PCommentRepo pCommentRepo;

    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private PrCoFileService fileService;

    public Project addComment(User user, Map<String, String> form, MultipartFile[] file) throws IOException {
        PComment comment = new PComment();

        Project project = projectRepo.findById(Long.parseLong(form.get("project_id"))).get();

            comment.setAuthor(user);
            comment.setDatecreate(new SimpleDateFormat("dd MMM yyyy HH:mm", new Locale("ru")).format(new Date()));
            comment.setParent(project.getId());
            comment.setDescription(form.get("editordata"));
            pCommentRepo.save(comment);
            List list1 = pCommentRepo.findByParentOrderByDatecreateAsc(project.getId());
            project.setComment(list1);
            PComment commentDb = pCommentRepo.findById(comment.getId()).get();

            if (!file[0].getOriginalFilename().isEmpty()){
                fileService.addFile(project.getPath(),file,user,commentDb);
            }
            projectRepo.save(project);

        return project;
    }

    public List findAllByParent(Long project){
        System.out.println("PCommentService.findAllByParent 1");
        List list = pCommentRepo.findByParentOrderByDatecreateAsc(project);
        System.out.println("PCommentService.findAllByParent");
        return list;
    }
}
