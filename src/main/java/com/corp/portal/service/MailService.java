package com.corp.portal.service;

import com.corp.portal.domain.Agreement;
import com.corp.portal.domain.Project;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Set;

@Service
public class MailService {
    @Autowired
    private MailSender mailSender;

    public void sendNewUserMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())){
            String message = String.format(
                    "%s %s! Приветствуем вас как нового пользователя системы! ",
                    user.getFirstName(),
                    user.getSurname()
            );
            mailSender.send(user.getEmail(), "Activate code",message);
        }
    }

    public void sendNewProjectMessage(Set<User> userList, Project project) {
        for (User user : userList){
            if (!StringUtils.isEmpty(user.getEmail())) {
                String message = String.format(
                        "Добрый День %s %s !\n" +
                                "Пользователь %s %s добавил вас в  проект \"%s\"!",
                        user.getFirstName(),
                        user.getSurname(),
                        project.getAuthor().getFirstName(),
                        project.getAuthor().getSurname(),
                        project.getName()
                );
                String message1 = "<p>Добрый день <strong>" + user.getSurname() + user.getFirstName() +"</strong>!</p>" + "" +
                        "Пользователь " + project.getAuthor().getSurname() + project.getAuthor().getFirstName() + " добавил вас в новый проект \"" + project.getName() + "\" !";
                   mailSender.send(user.getEmail(), "Новый проект!", message);

            }
        }
    }

    public void sendNewTaskTeamMessage(Set<User> team, Task task){
        for (User user : team){
            if (!StringUtils.isEmpty(user.getEmail())){
                String message = String.format(
                        "Добрый День %s %s !\n" +
                                "Пользователь %s %s добавил вас в задачу \"%s\"!",
                        user.getFirstName(),
                        user.getSurname(),
                        task.getAuthor().getFirstName(),
                        task.getAuthor().getSurname(),
                        task.getName()
                );
                mailSender.send(user.getEmail(), "Новая задача", message);
            }
        }

    }
//todo отправка письма редактирвоание задачи и редаетирование проекта
    //todo отправка письма на комментарий
    public void sendNewTaskResponsibleMessage(User responsible, Task task) {
        if (!StringUtils.isEmpty(responsible.getEmail())){
            String message = String.format(
                    "Добрый День %s %s !\n" +
                            "Пользователь %s %s назначил  вас ответственным в задачу  \"%s\"!",
                    responsible.getFirstName(),
                    responsible.getSurname(),
                    task.getAuthor().getFirstName(),
                    task.getAuthor().getSurname(),
                    task.getName()
            );
            mailSender.send(responsible.getEmail(), "Новая задача", message);
        }
    }

    public void sendAgreementNextStage(Task agTask){
        String message = String.format(
                "Добрый День %s %s !\n" +
                        "Пользователь %s %s создал согласование \"%s\"!\n" +
                        "Вам необходимо принять участие в согласование!\n" +
                        "Срок вашего согласования %s",
                agTask.getResponsible().getFirstName(),
                agTask.getResponsible().getSurname(),
                agTask.getAuthor().getFirstName(),
                agTask.getAuthor().getSurname(),
                agTask.getName(),
                agTask.getDeadline()
        );
        mailSender.send(agTask.getResponsible().getEmail(), "Новое согласование", message);
    }

    public void sendAgreementStageAgreed(Task agTask){
        String message = String.format(
                "Добрый День %s %s !\n" +
                        "Пользователь %s %s согласовал задачу \"%s\"!",

                agTask.getAuthor().getFirstName(),
                agTask.getAuthor().getSurname(),
                agTask.getResponsible().getFirstName(),
                agTask.getResponsible().getSurname(),
                agTask.getName()

        );
        mailSender.send(agTask.getAuthor().getEmail(), "Задача согласована", message);
    }

    public void sendAgAuthorApprove(Agreement agreement) {
        String mesage = String.format(
                "Добрый День! \n" +
                "\"%s\" согласовано всеми пользователями!",

                agreement.getName()
        );
        mailSender.send(agreement.getAuthor().getEmail(), "Согласование завершено", mesage);
        mailSender.send(agreement.getResponsible().getEmail(), "Согласование завершено", mesage);
    }
}
