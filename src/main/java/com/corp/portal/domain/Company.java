package com.corp.portal.domain;

import javax.persistence.*;
import java.util.List;

@Entity
public class Company {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;

    private Long inn;

    private Integer type;

    private String path;

    private Long kpp;

    private String address;

    private String director;

    private String email;

    private String phone;

    private String contact;

    private String registration;

    private String status;

    private String actuality;

    private String edo;

    private String nalog;

    private String service;

    private String date_work;

    private Double capital;

    private Integer size;

    private Integer driver;

    private String balance;

    private Long money;

    private String assets;

    private String transport;

    private String tax_burden;

    private Double tax_payment;

    private String mass_address;

    public String getNalog() {
        return nalog;
    }

    public void setNalog(String nalog) {
        this.nalog = nalog;
    }

    public String getEdo() {
        return edo;
    }

    public void setEdo(String edo) {
        this.edo = edo;
    }

    public String getRegistration() {
        return registration;
    }

    public void setRegistration(String registration) {
        this.registration = registration;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getActuality() {
        return actuality;
    }

    public void setActuality(String actuality) {
        this.actuality = actuality;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author")
    private User author;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "company")
    private List<CompanyFile> file;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public List<CompanyFile> getFile() {
        return file;
    }

    public void setFile(List<CompanyFile> file) {
        this.file = file;
    }

    public Long getKpp() {
        return kpp;
    }

    public void setKpp(Long kpp) {
        this.kpp = kpp;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Long getInn() {
        return inn;
    }

    public void setInn(Long inn) {
        this.inn = inn;
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

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getDate_work() {
        return date_work;
    }

    public void setDate_work(String date_work) {
        this.date_work = date_work;
    }

    public Double getCapital() {
        return capital;
    }

    public void setCapital(Double capital) {
        this.capital = capital;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Integer getDriver() {
        return driver;
    }

    public void setDriver(Integer driver) {
        this.driver = driver;
    }

    public String getBalance() {
        return balance;
    }

    public void setBalance(String balance) {
        this.balance = balance;
    }

    public Long getMoney() {
        return money;
    }

    public void setMoney(Long money) {
        this.money = money;
    }

    public String getAssets() {
        return assets;
    }

    public void setAssets(String assets) {
        this.assets = assets;
    }

    public String getTransport() {
        return transport;
    }

    public void setTransport(String transport) {
        this.transport = transport;
    }

    public String getTax_burden() {
        return tax_burden;
    }

    public void setTax_burden(String tax_burden) {
        this.tax_burden = tax_burden;
    }

    public Double getTax_payment() {
        return tax_payment;
    }

    public void setTax_payment(Double tax_payment) {
        this.tax_payment = tax_payment;
    }

    public String getMass_address() {
        return mass_address;
    }

    public void setMass_address(String mass_address) {
        this.mass_address = mass_address;
    }
}
