package com.corp.portal.domain;

import javax.persistence.*;
import java.util.List;

@MappedSuperclass
public abstract class AbstractContract {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;

    private String description;

    private String number;

    private String date_create;

    private int status;

    private String date;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author")
    private User author;

    private String date_start;

    private String date_end;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "company1")
    private Company company1;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "company2")
    private Company company2;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "contract")
    private List<ContractFile> file;

    private String path;

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getDate_create() {
        return date_create;
    }

    public void setDate_create(String date_create) {
        this.date_create = date_create;
    }

    public List<ContractFile> getFile() {
        return file;
    }

    public void setFile(List<ContractFile> file) {
        this.file = file;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDate_start() {
        return date_start;
    }

    public void setDate_start(String date_start) {
        this.date_start = date_start;
    }

    public String getDate_end() {
        return date_end;
    }

    public void setDate_end(String date_end) {
        this.date_end = date_end;
    }

    public Company getCompany1() {
        return company1;
    }

    public void setCompany1(Company company1) {
        this.company1 = company1;
    }

    public Company getCompany2() {
        return company2;
    }

    public void setCompany2(Company company2) {
        this.company2 = company2;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
