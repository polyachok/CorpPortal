package com.corp.portal.domain;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@MappedSuperclass
public abstract class AbstractComment {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    private String description;

    private String datecreate;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author")
    private User author;

    @ManyToMany
    @JoinTable(
            name = "pcomment_file",
            joinColumns = { @JoinColumn (name = "comment")},
            inverseJoinColumns = { @JoinColumn (name= "file")}
    )
    private Set<PrCoFile> file = new HashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDatecreate() {
        return datecreate;
    }

    public void setDatecreate(String datecreate) {
        this.datecreate = datecreate;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Set<PrCoFile> getFile() {
        return file;
    }

    public void setFile(Set<PrCoFile> file) {
        this.file = file;
    }
}
