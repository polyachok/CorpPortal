package com.corp.portal.service;

import com.corp.portal.domain.*;
import com.corp.portal.repos.ContractFileRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Service
public class ContractFileService {

    @Autowired
    private ContractFileRepo contractFileRepo;
    @Autowired
    private UtilService utilService;



    public Boolean addFile(String uploadPath, MultipartFile[] file, User user, Contract contract) {
    try {
        File uploadDir = new File(uploadPath);
        for (int i = 0; i < file.length; i++){
            String fileName = file[i].getOriginalFilename();
            file[i].transferTo(new File(uploadDir, fileName));
            ContractFile f = new ContractFile();
            f.setName(fileName);
            f.setDatecreate(utilService.dateOfStr());
            f.setAuthor(user);
            f.setPath(uploadPath);
            f.setContract(contract);
            contractFileRepo.save(f);
        }
        List fileList = contractFileRepo.findByContract(contract);
        contract.setFile(fileList);
        //pCommentRepo.save(commentDb);
        // comment.setFile();
    }catch (IOException e){
        System.out.println(e);
    }
        return true;
    }

    public ContractFile findById(Long id) {
        return contractFileRepo.findById(id).get();
    }

    public List findByContract(Contract contract){

        return contractFileRepo.findByContract(contract);
    }
}
