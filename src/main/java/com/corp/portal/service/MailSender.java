package com.corp.portal.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;

@Service
public class MailSender {
    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String username;

    public void send1(String emailTo, String subject, String message)  {
        SimpleMailMessage mailMessage = new SimpleMailMessage();

        mailMessage.setFrom(username);
        mailMessage.setTo(emailTo);
        mailMessage.setSubject(subject);

        mailMessage.setText(message);
        mailSender.send(mailMessage);
    }

    public void send(String emailTo, String subject, String message)  {
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            boolean multipart = true;

            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, multipart, "utf-8");
            mimeMessage.setContent(message, "text/html;charset=UTF-8");
            mimeMessage.setHeader("List-Unsubscribe", "<mailto:upolyakov@sdp-mo.ru?subject=unsubscribe>");
            helper.setFrom(username);
            helper.setTo(emailTo);
            helper.setSubject(subject);


            mailSender.send(mimeMessage);
        }catch (MessagingException e){
            System.out.println(e);
        }


    }
}
