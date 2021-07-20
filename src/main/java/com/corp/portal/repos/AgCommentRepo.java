package com.corp.portal.repos;

import com.corp.portal.domain.AgComment;
import com.corp.portal.domain.PComment;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface AgCommentRepo extends CrudRepository<AgComment, Long> {
    List findByParent(Long id, Sort sort);
    List findByParentOrderByDatecreateAsc(Long id);
}
