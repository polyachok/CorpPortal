package com.corp.portal.repos;

import com.corp.portal.domain.PComment;
import com.corp.portal.domain.Project;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Set;

public interface PCommentRepo extends CrudRepository<PComment, Long> {
    List findByParent(Long id, Sort sort);
    List findByParentOrderByDatecreateAsc(Long id);
}
