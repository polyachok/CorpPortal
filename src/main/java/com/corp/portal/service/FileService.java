package com.corp.portal.service;

import com.corp.portal.domain.Config;
import com.corp.portal.domain.Project;
import com.corp.portal.domain.Task;
import com.corp.portal.repos.ConfigRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;

@Service
public class FileService {
    @Autowired
    private ConfigRepo configRepo;

    public String createProjectPath(Project project, String parentPath){
        String generateName = generatePath(parentPath, project.getName(), project.getDatecreate());
        File dir = new File(generateName);
        if (!createPath(dir)){
        }
        return generateName;
    }

    public String updateProjectPath(Project project, String parentPath) {
        String newName = generatePath(parentPath, project.getName(), project.getDatecreate());
        Path newPath = Paths.get(newName);
        Path oldDir = Paths.get(project.getPath());
        try {
            System.out.println(Files.move(oldDir,newPath, REPLACE_EXISTING));
        }catch (IOException e){
            e.printStackTrace();
        }
        return newName;
    }

    public String createTaskPath(Task task, String parentPath){
        String generateName = generatePath(parentPath, task.getName(), task.getDatecreate());
        File dir = new File(generateName);
        if (!createPath(dir)){
        }
        return generateName;
    }

    public String generatePath(String path, String name, String date) {
           try {
               File fullDir;
               if (path.isEmpty()) {
                   Config configPath = getConfig("UploadPath");
                   path = configPath.getParam();
                   Date newDate = new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).parse(date);
                   File yearDir = new File(path + "//" + new SimpleDateFormat("yyyy").format(newDate));
                   if (!yearDir.exists()) {
                       createPath(yearDir);
                   }
                   fullDir = new File(yearDir + "//" + new SimpleDateFormat("M").format(newDate));
                   if (!fullDir.exists()) {
                       createPath(fullDir);
                   }
               }else {
                   fullDir = new File(path + "//");
               }

               String generateName = name + "_" + new Date().getTime();
               File dir = new File(fullDir + "//" + generateName);
               if (dir.exists()) {
                   generatePath(path, name, date);
               }
               createPath(dir);

               return fullDir + "\\" + generateName;
           } catch (ParseException e) {
               System.out.println(e);
           }


        return "error";
    }

    public boolean createPath(File dir){
        if (!dir.exists()){
            boolean create = dir.mkdir();
            if (create){
                return true;
            }
        }
        return false;
    }



    public Config getConfig(String configName){
        return  configRepo.findByConfigname(configName);
    }
}