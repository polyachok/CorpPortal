package com.corp.portal.service;

import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

@Service
public class UtilService {



    public String dateOfStr(){
        return new SimpleDateFormat("dd MMM yyyy HH:mm", new Locale("ru")).format(new Date());
    }

    public String dateToDDMMMYYYY(Date date){
        return new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).format(date);
    }

    public String formateDateMMM(String date){
        try {
            Date d = new SimpleDateFormat("dd.MM.yyyy", new Locale("ru")).parse(date);
            String a = new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).format(d);
            return a;
        }catch (ParseException e){
            System.out.println(e);
        }
       return "error";
    }

    public Calendar incrimentDate(Integer i){
        Calendar calendar = GregorianCalendar.getInstance();
        calendar.add(Calendar.DAY_OF_YEAR,i);
        return calendar;
    }

    public boolean checkDeadline(String deadline) {
        try {
            Date format = new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).parse(deadline);
            Date now = new SimpleDateFormat("dd MMM yyyy", new Locale("ru")).parse(dateOfStr());
            if (format.before(now)){
                return true;
            }else {
                return false;
            }
        }catch (ParseException e){
            System.out.println("UtilService.checkDeadline" + " - " + e);
            return false;
        }

    }


}
