package com.corp.portal.repos;

import com.corp.portal.domain.Config;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ConfigRepo extends JpaRepository<Config, Long>{
   // Config findByConfigname(String configname);
    //Config findbyparamname(String paramname);
        Config findByConfigname(String configname);
        Config findByParamname(String paramname);
}
