package com.corp.portal.service;

import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

@Service
public class UtilService {

    public String dateOfStr(){
        return new SimpleDateFormat("dd MMM yyyy HH:mm", new Locale("ru")).format(new Date());
    }
}
