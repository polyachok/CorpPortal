package com.corp.portal.domain;

import javax.persistence.*;
import java.util.List;

@Entity
public class Route {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "route")
    private List<Sequence> sequence;

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

    public List<Sequence> getTeam() {
        return sequence;
    }

    public void setTeam(List<Sequence> sequence) {
        this.sequence = sequence;
    }

    public List<Sequence> getSequence() {
        return sequence;
    }

    public void setSequence(List<Sequence> sequence) {
        this.sequence = sequence;
    }
}
