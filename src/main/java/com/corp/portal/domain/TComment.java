package com.corp.portal.domain;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import java.util.HashSet;
import java.util.Set;

@Entity
public class TComment extends AbstractComment {

    private Long parent;

    @ManyToMany
    @JoinTable(
            name = "t_comment_file",
            joinColumns = { @JoinColumn(name = "comment")},
            inverseJoinColumns = { @JoinColumn (name= "file")}
    )
    private Set<TaCoFile> file = new HashSet<>();

    public Long getParent() {
        return parent;
    }

    public void setParent(Long parent) {
        this.parent = parent;
    }

    public Set<TaCoFile> getFile() {
        return file;
    }

    public void setFile(Set<TaCoFile> file) {
        this.file = file;
    }
}
