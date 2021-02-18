package com.corp.portal.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
public class Task extends AbstractProject {

    private String deadline;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "responsible")
    private User responsible;

    private Long parentP;

    private Long parentT;

    @ManyToMany
    @JoinTable(
            name = "task_team",
            joinColumns = { @JoinColumn(name = "task")},
            inverseJoinColumns = { @JoinColumn (name= "team")}
    )
    private Set<User> team = new HashSet<>();

    @ManyToMany
    @JoinTable(
            name = "task_comment",
            joinColumns = { @JoinColumn (name = "task")},
            inverseJoinColumns = { @JoinColumn (name= "comment")}
    )
    private List<TComment> comment = new ArrayList<>();

    private boolean deadLineStatus;

    public boolean isDeadLineStatus() {
        return deadLineStatus;
    }

    public void setDeadLineStatus(boolean deadLineStatus) {
        this.deadLineStatus = deadLineStatus;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    public User getResponsible() {
        return responsible;
    }

    public void setResponsible(User responsible) {
        this.responsible = responsible;
    }

    public Long getParentP() {
        return parentP;
    }

    public void setParentP(Long parentP) {
        this.parentP = parentP;
    }

    public Long getParentT() {
        return parentT;
    }

    public void setParentT(Long parentT) {
        this.parentT = parentT;
    }

    public Set<User> getTeam() {
        return team;
    }

    public void setTeam(Set<User> team) {
        this.team = team;
    }

    public List<TComment> getComment() {
        return comment;
    }

    public void setComment(List<TComment> comment) {
        this.comment = comment;
    }


}
