package com.corp.portal.repos;

import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TaskRepo extends CrudRepository<Task, Long> {

    List findByAuthor(User author);
    List<Task> findByParentT(Long id);
    List<Task> findByParentP(User user);
    List<Task> findByAuthorOrTeamOrResponsible(User author, User team, User responsible);
    List<Task> findByTeam(User user);
}

