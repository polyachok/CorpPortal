package com.corp.portal.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@MappedSuperclass
public abstract class AbstractProject {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;
    //@NotBlank
    private String name;

    private String datecreate;
    private String dateclose;
   // @NotBlank
    private String description;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "parent")
    private Project parent;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author")
    private User author;
    /* @ManyToOne(fetch = FetchType.EAGER)
        @JoinColumn(name = "user_id")
        private User manager;*/
    @ManyToMany
    @JoinTable(
            name = "project_team",
            joinColumns = { @JoinColumn (name = "project")},
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

    private String status;

    public Project getParent() {
        return parent;
    }

    public List<PComment> getComment() {
        return comment;
    }

    public void setComment(List<PComment> comment) {
        this.comment = comment;
    }

    public void setParent(Project parent) {
        this.parent = parent;
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

    public String getDatecreate() {
        return datecreate;
    }

    public void setDatecreate(String datecreate) {
        this.datecreate = datecreate;
    }

    public String getDateclose() {
        return dateclose;
    }

    public void setDateclose(String dateclose) {
        this.dateclose = dateclose;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    /*public User getManager() {
        return manager;
    }

    public void setManager(User manager) {
        this.manager = manager;
    }*/

   /* public List getTeam() {
        return team;
    }

    public void setTeam(List team) {
        this.team = team;
    }*/



    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Set<User> getTeam() {
        return team;
    }

    public void setTeam(Set<User> team) {
        this.team = team;
    }
}
