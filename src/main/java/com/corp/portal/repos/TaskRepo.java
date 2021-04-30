package com.corp.portal.repos;

import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TaskRepo extends CrudRepository<Task, Long> {

    List findByAuthorAndType(User author, Long type);
    Task findByParentTAndParentA(Long task, Long agreement);
    List<Task> findByParentP(Long id);
    List<Task> findByParentAAndStatusNot(Long id, String status);
    List<Task> findByAuthorOrTeamOrResponsible(User author, User team, User responsible);
    List<Task> findByTeam(User user);
    List<Task> findByTeamOrResponsibleAndType(User team, User responsible, Long type);
    List<Task> findByAuthorOrTeamOrResponsibleOrParentP(User author, User team, User responsible, Long project);
    Task findByParentAAndResponsible(Long agreement, User responsible);
    List<Task> findByParentAOrderByIdAsc(Long agreement);
    List<Task> findByParentTAndStatusNot(Long id, String status);
    List<Task> findByResponsibleAndTypeAndStatusNot(User responsible, Long type, String status);
}

