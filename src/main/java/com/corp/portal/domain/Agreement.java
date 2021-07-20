package com.corp.portal.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Agreement extends AbstractProject{

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "responsible")
    private User responsible;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "route")
    private Route route;

    private String deadline;

    private String path;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "agreement")
    private List<AgFile> file;

    private Long parentT;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "contract")
    private Contract contract;

    @ManyToMany
    @JoinTable(
            name = "agreement_comment",
            joinColumns = { @JoinColumn (name = "agreement")},
            inverseJoinColumns = { @JoinColumn (name= "comment")}
    )
    private List<AgComment> comment = new ArrayList<>();

    public List<AgComment> getComment() {
        return comment;
    }

    public void setComment(List<AgComment> comment) {
        this.comment = comment;
    }

    private Integer type;

    private boolean deadLineStatus;

    public boolean isDeadLineStatus() {
        return deadLineStatus;
    }

    public void setDeadLineStatus(boolean deadLineStatus) {
        this.deadLineStatus = deadLineStatus;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }

    public User getResponsible() {
        return responsible;
    }

    public void setResponsible(User responsible) {
        this.responsible = responsible;
    }

    public Long getParentT() {
        return parentT;
    }

    public void setParentT(Long parentT) {
        this.parentT = parentT;
    }

    public List<AgFile> getFile() {
        return file;
    }

    public void setFile(List<AgFile> file) {
        this.file = file;
    }

    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    @Override
    public String getPath() {
        return path;
    }

    @Override
    public void setPath(String path) {
        this.path = path;
    }
}
