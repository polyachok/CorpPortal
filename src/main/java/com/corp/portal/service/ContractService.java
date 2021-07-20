package com.corp.portal.service;

import com.corp.portal.domain.*;
import com.corp.portal.repos.ContractRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Service
public class ContractService {
    @Autowired
    private ContractRepo contractRepo;

    @Autowired
    private CompanyService companyService;

    @Autowired
    private ContractFileService contractFileService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private FileService fileService;

    @Autowired
    private TaskService taskService;

    public void createContract(Map<String, String> form, User user, MultipartFile[] file) {
        Contract contract = new Contract();
        contract.setName(form.get("name"));
        contract.setNumber(form.get("number"));
        contract.setDescription(form.get("description"));
        if (form.get("date_end") != null){
            contract.setDate_end(utilService.formateDateMMM(form.get("date_end")));
        }else {
            contract.setDate_end("-");
        }
        contract.setDate(utilService.formateDateMMM(form.get("actuality")));
        contract.setExtension(form.get("extension"));
        contract.setPayment(form.get("payment"));
        contract.setShipment(form.get("shipment"));
        contract.setSpecification(form.get("specification"));
        contract.setCompany1(companyService.findById(Long.valueOf(form.get("company1"))));
        contract.setCompany2(companyService.findById(Long.valueOf(form.get("company2"))));
        contract.setDate_create(utilService.dateOfStr());
        contract.setAuthor(user);
        contract.setPath(fileService.createContractPath(contract));
        contractRepo.save(contract);
        if (!file[0].getOriginalFilename().isEmpty()){
            String path = contract.getPath();
            contractFileService.addFile(path, file, user, contract);
        }
    }

    public void save(Contract contract) {
        contractRepo.save(contract);
    }

    public Contract findById(Long id){
        return contractRepo.findById(id).get();
    }

    public List getCompanyList(){
        return companyService.getCompanyList();
    }

    public List getOurCompanyList(){
        return companyService.getOurCompanyList();
    }

    public List getContractByCompany1(Company company){
        return contractRepo.findContractByCompany1OrderByDate(company);
    }

    public List getContractListByAuthor(User user) {
        if (user.getRoles().contains(Role.CONTRACT)){
            return (List) contractRepo.findAll();
        }else {
            return contractRepo.findContractByAuthor(user);
        }
    }

    public List getContractByAuthorAndStatus(User user, Integer status){
        return contractRepo.findContractByAuthorAndStatus(user, status);
    }

    public ContractFile getFile(Long id) {
        return contractFileService.findById(id);
    }

    public ContractFile getContractFile(String fileId) {
        return getFile(Long.valueOf(fileId));
    }

    public HttpServletResponse downloadContractFile(String path, HttpServletResponse response, String fileName) {

        response = taskService.downloadFile(path,fileName,response);
        return response;
    }

}
