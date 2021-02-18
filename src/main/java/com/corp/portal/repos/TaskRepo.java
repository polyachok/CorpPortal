package com.corp.portal.repos;

import com.corp.portal.domain.Project;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TaskRepo extends CrudRepository<Task, Long> {

    List findByAuthor(User author);
    List<Task> findByParentT(Long id);
    List<Task> findByParentP(Long id);
    List<Task> findByAuthorOrTeamOrResponsible(User author, User team, User responsible);
    List<Task> findByTeam(User user);
    List<Task> findByTeamOrResponsible(User team, User responible);
    List<Task> findByAuthorOrTeamOrResponsibleOrParentP(User author, User team, User responsible, Long project);
}

