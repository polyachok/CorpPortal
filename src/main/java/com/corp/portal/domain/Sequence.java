package com.corp.portal.domain;

import javax.persistence.*;

@Entity
public class Sequence {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private Long number;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "route", nullable = false)
    private Route route;

    @OneToOne
    @JoinColumn(name = "usr", nullable = false)
    private User usr ;

    private Integer deadline;

    public User getUsr() {
        return usr;
    }

    public void setUsr(User usr) {
        this.usr = usr;
    }

    public Integer getDeadline() {
        return deadline;
    }

    public void setDeadline(Integer deadline) {
        this.deadline = deadline;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getNumber() {
        return number;
    }

    public void setNumber(Long number) {
        this.number = number;
    }

    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }

    public User getUser() {
        return usr;
    }

    public void setUser(User usr) {
        this.usr = usr;
    }

}
