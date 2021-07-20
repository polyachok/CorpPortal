package com.corp.portal.service;

import com.corp.portal.domain.Company;
import com.corp.portal.domain.User;
import com.corp.portal.repos.CompanyRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyService {
    @Autowired
    private CompanyRepo companyRepo;

    @Autowired
    private FileService fileService;

    @Autowired
    private ContractService contractService;

    public boolean addCompany(Company company, User author) {
      if(issueCompany(company)){
          company.setPath(fileService.createCompanyPath(company));
          company.setAuthor(author);
          companyRepo.save(company);
          return true;
      }else{
          return false;
      }
    }

    public List findAll() {
        return (List) companyRepo.findAll();
    }

    public Company findById(Long id){
        return companyRepo.findById(id).get();
    }

    public List findContractByCompany(Long id){
        Company company = findById(id);
        return contractService.getContractByCompany1(company);
    }

    public List getCompanyList() {
        return companyRepo.findByTypeNot(3);
    }

    public List getOurCompanyList() {
        return companyRepo.findByType(3);
    }

    public boolean issueCompany(Company company){
        Company a = companyRepo.findByNameAndType(company.getName(), company.getType());
        if (a != null){
            return false;
        }else {
            return true;
        }
    }

}
