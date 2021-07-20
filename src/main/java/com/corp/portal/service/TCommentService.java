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
    private TaskService taskService;

    @Autowired
    private MailService mailService;

    public Task addComment(User user, Map<String, String> form, MultipartFile[] file) throws IOException {
        TComment comment = new TComment();

        Task task = taskRepo.findById(Long.parseLong(form.get("task_id"))).get();
        comment.setAuthor(user);
        comment.setDatecreate(new SimpleDateFormat("dd MMM yyyy HH:mm", new Locale("ru")).format(new Date()));
        comment.setParent(task.getId());
        comment.setDescription(form.get("editordata"));
        commentRepo.save(comment);
        List list = commentRepo.findByParentOrderByDatecreateAsc(task.getId());
        task.setComment(list);
        taskService.setLastActive(task);
        TComment tCommentDb = commentRepo.findById(comment.getId()).get();
        if (!file[0].getOriginalFilename().isEmpty()){
            taskCoFileService.addFile(task.getPath(),file,user,tCommentDb);
        }
        mailService.sendNewCommentTask(task,comment.getAuthor());
        taskRepo.save(task);
        return task;
    }

    public List findAllByParent(Long task){
        List list = commentRepo.findByParentOrderByDatecreateAsc(task);
        return list;
    }

    public List<TComment> findAllCommentAg(Long task){
        return commentRepo.findByParentOrderByDatecreateAsc(task);
    }
}
