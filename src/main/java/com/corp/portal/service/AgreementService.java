package com.corp.portal.service;

import com.corp.portal.domain.*;
import com.corp.portal.repos.AgreementRepo;
import com.corp.portal.repos.RouteRepo;
import com.corp.portal.repos.SequenceRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Service
public class AgreementService {
    @Autowired
    private AgreementRepo agreementRepo;
    @Autowired
    private UserService userService;
    @Autowired
    private SequenceRepo sequenceRepo;
    @Autowired
    private RouteRepo routeRepo;
    @Autowired
    private FileService fileService;
    @Autowired
    private AgFileService agFileService;
    @Autowired
    private TaskService taskService;

    public List findByAuthor(User author){
        List<Agreement> agList = agreementRepo.findByAuthor(author);
        return agList;
    }

    public void addRoute(Route route, Map<String, String> form){
        routeRepo.save(route);
        for(int i = 1; i <= 3; i++){
            Sequence sequence = new Sequence();
            sequence.setNumber((long) i);
            sequence.setUser(userService.findById(Long.valueOf(form.get("stage"+i))));
            sequence.setRoute(route);
            sequenceRepo.save(sequence);
        }
    }

    public List getRouteList(){
        return (List) routeRepo.findAll();
    }

    public void createAgreement(User user, Map<String, String> form, MultipartFile[] file) {
        try {
            Route route = routeRepo.findById(Long.valueOf(form.get("route"))).get();
            route.setSequence(sequenceRepo.findByRoute(route));
            Agreement agreement = new Agreement();
            agreement.setName(form.get("name"));
            agreement.setDeadline(new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).format(new SimpleDateFormat("dd.MM.yyyy", new Locale("ru")).parse(form.get("deadline"))));
            agreement.setDatecreate(new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).format(new Date()));
            agreement.setAuthor(user);
            agreement.setStatus("Активный");
            agreement.setPath(fileService.createAgPath(agreement));
            agreement.setRoute(route);
            agreement.setDescription(form.get("description"));
            agreementRepo.save(agreement);
            if (!file[0].getOriginalFilename().isEmpty()){
                agFileService.addFile(agreement.getPath(),file,user,agreement);
            }
            taskService.createAgTask(agreement,route,route.getSequence());
        }catch (ParseException e){
            System.out.println(e);
        }
    }

    public Agreement findById(Long id){
        Agreement agreement = agreementRepo.findById(id).get();
        agreement.getRoute().setSequence(sequenceRepo.findByRoute(agreement.getRoute()));
        return agreement;
    }

    public List<Task> findByAgreement(Agreement agreement){
        return taskService.getByAgreement(agreement);
    }


    public List<Task> findByResponsible(User responsible){
        return taskService.findByResponsible(responsible);
    }

    public Task findTaskById(Long id){
        return taskService.findById(id);
    }
}


