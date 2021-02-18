package com.corp.portal.domain;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
public class Project extends AbstractProject {

    private Long parent;

    @ManyToMany
    @JoinTable(
            name = "project_team",
            joinColumns = { @JoinColumn(name = "project")},
            inverseJoinColumns = { @JoinColumn (name= "team")}
    )
    private Set<User> team = new HashSet<>();

    @ManyToMany
    @JoinTable(
            name = "project_comment",
            joinColumns = { @JoinColumn (name = "project")},
            inverseJoinColumns = { @JoinColumn (name= "comment")}
    )
    private List<PComment> comment = new ArrayList<>();


    public Long getParent() {
        return parent;
    }
    public void setParent(Long parent) {
        this.parent = parent;
    }


    public Set<User> getTeam() {
        return team;
    }

    public void setTeam(Set<User> team) {
        this.team = team;
    }


    public List<PComment> getComment() {
        return comment;
    }


    public void setComment(List<PComment> comment) {
        this.comment = comment;
    }


}
