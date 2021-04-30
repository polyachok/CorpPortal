package com.corp.portal.repos;

import com.corp.portal.domain.Agreement;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface AgreementRepo extends CrudRepository<Agreement, Long> {

    List findByAuthor(User author);
    List findByParentTAndAuthorOrResponsible(Long parent, User author, User responsible);

}

