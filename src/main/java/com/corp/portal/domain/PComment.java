package com.corp.portal.domain;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import java.util.HashSet;
import java.util.Set;

@Entity
public class PComment extends AbstractComment {

    private Long parent;

    @ManyToMany
    @JoinTable(
            name = "pcomment_file",
            joinColumns = { @JoinColumn(name = "comment")},
            inverseJoinColumns = { @JoinColumn (name= "file")}
    )
    private Set<PrCoFile> file = new HashSet<>();

    public Long getParent() {
        return parent;
    }

    public void setParent(Long parent) {
        this.parent = parent;
    }

    public Set<PrCoFile> getFile() {
        return file;
    }

    public void setFile(Set<PrCoFile> file) {
        this.file = file;
    }
}