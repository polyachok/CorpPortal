package com.corp.portal.repos;

import com.corp.portal.domain.TComment;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TCommentRepo extends CrudRepository<TComment, Long> {
    List findByParent(Long id, Sort sort);
    List findByParentOrderByDatecreateAsc(Long id);
}
