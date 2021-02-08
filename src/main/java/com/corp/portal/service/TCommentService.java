package com.corp.portal.service;

import com.corp.portal.domain.TComment;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import com.corp.portal.repos.ConfigRepo;
import com.corp.portal.repos.TCommentRepo;
import com.corp.portal.repos.TaskCoFileRepo;
import com.corp.portal.repos.TaskRepo;
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
public class TCommentService {

    @Autowired
    private TCommentRepo commentRepo;

    @Autowired
    private TaskRepo taskRepo;

    @Autowired
    private TaskCoFileService taskCoFileService;

    @Autowired
    private ConfigRepo configRepo;

    public Task addComment(User user, Map<String, String> form, MultipartFile[] file) throws IOException {
        TComment comment = new TComment();
        String uploadPath = configRepo.findByConfigname("UploadPath").getParam();

        Task task = taskRepo.findById(Long.parseLong(form.get("task_id"))).get();
        comment.setAuthor(user);
        comment.setDatecreate(new SimpleDateFormat("dd MMM yyyy HH:mm", new Locale("ru")).format(new Date()));
        comment.setParent(task.getId());
        comment.setDescription(form.get("editordata"));
        commentRepo.save(comment);
        List list = commentRepo.findByParentOrderByDatecreateAsc(task.getId());
        task.setComment(list);
        TComment tCommentDb = commentRepo.findById(comment.getId()).get();
        if (!file[0].getOriginalFilename().isEmpty()){
            taskCoFileService.addFile(uploadPath,file,user,tCommentDb);
        }
        taskRepo.save(task);
        return task;
    }

    public List findAllByParent(Long task){
        System.out.println("PCommentService.findAllByParent 1");
        List list = commentRepo.findByParentOrderByDatecreateAsc(task);
        System.out.println("PCommentService.findAllByParent");
        return list;
    }
}
