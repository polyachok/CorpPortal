package com.corp.portal.service;

import com.corp.portal.domain.Agreement;
import com.corp.portal.domain.Project;
import com.corp.portal.domain.Task;
import com.corp.portal.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class MailService {
    @Autowired
    private MailSender mailSender;

    public void sendNewUserMessage(User user)  {

            String message = "<h3> Приветсвуем " + user.getFirstName() + " " + user.getSurname() + "</h4></br>" +
                    "<p>Вас добавили как нового пользователя в  Корпаративный портал</a>!</br>" +
                    "Для дальнейшей работы перейдите по <a href=http://corp-portal>ссылке</a>.</p></br>" +
                    "Логин для входа в систему <strong>" + user.getUsername() + "</strong>."+
                    "<p> При возникновение вопросов, оброщайтесь к администратору системы!</p>";
            mailSender.send(user.getEmail(), "Приветствуем!", message);
    }


    public void sendNewProjectMessage(Set<User> userList, Project project) {
        for (User user : userList){
            if (!StringUtils.isEmpty(user.getEmail())) {

                String message = "<h4>Добрый День " + user.getFirstName() +" "+ user.getSurname()+ " !</h4>" +
                                "<p>Пользователь " + project.getAuthor().getFirstName() + " " + project.getAuthor().getSurname()+" добавил вас в проект" +
                        "<a href=http://corp-portal/project/"+project.getId()+"> " + "< " + project.getName()+ " >" + "</a></p>";

                   mailSender.send(user.getEmail(), "Новый проект! " + "< "+ project.getName() + " >", message);
            }
        }
    }

    public void sendNewTaskTeamMessage(Set<User> team, Task task){
        for (User user : team){
            if (!StringUtils.isEmpty(user.getEmail())){
                String message = "<h4>Добрый День " + user.getFirstName() +" "+ user.getSurname()+ " !</h4>" +
                        "<p>Пользователь " + task.getAuthor().getFirstName() + " " + task.getAuthor().getSurname() + " добавил вас в задачу"+
                        "<a href=http://corp-portal/task/"+task.getId()+"> " + "< " + task.getName()+ " >" + "</a></p>";

                mailSender.send(user.getEmail(), "Новая задача! " +"< " + task.getName()+ " >", message);
            }
        }

    }
//todo отправка письма редактирвоание задачи и редаетирование проекта
    //todo отправка письма на комментарий
    public void sendNewTaskResponsibleMessage(User responsible, Task task) {
        if (!StringUtils.isEmpty(responsible.getEmail())){
            String message = "<h4>Добрый День " + responsible.getFirstName() +" "+ responsible.getSurname()+ " !</h4>"+
                            "<p>Пользователь " + task.getAuthor().getFirstName() + " " + task.getAuthor().getSurname() + " ответственным в задачу "+
                             "<a href=http://corp-portal/task/"+task.getId()+"> " + "< " + task.getName()+ " >" + "</a></p>";

            mailSender.send(responsible.getEmail(), "Новая задача " +"< " + task.getName()+ " >", message);
        }
    }

    public void sendAgreementNextStage(Task agTask){
        String message = "<h4>Добрый День " + agTask.getResponsible().getFirstName() +" "+ agTask.getResponsible().getSurname()+ " !</h4>"+
                        "<p>Пользователь " + agTask.getAuthor().getFirstName() + " " + agTask.getAuthor().getSurname() + " создал согласование " +
                        "<a href=http://corp-portal/task/"+agTask.getId()+"> " + "< " + agTask.getName()+ " >" + "</a></p>" +
                        "<p>Вам необходимо принять участие в согласование!" +
                        "Срок вашего согласования " + agTask.getDeadline() + "</p>";
        mailSender.send(agTask.getResponsible().getEmail(), "Новое согласование " +"< " + agTask.getName()+ " >", message);
    }

    public void sendAgreementStageAgreed(Task agTask){
        String message = "<h4>Добрый День " +  agTask.getAuthor().getFirstName() +" "+ agTask.getAuthor().getSurname()+ " !</h4>"+
                         "<p>Пользователь " + agTask.getResponsible().getFirstName() +" "+ agTask.getResponsible().getSurname() + " согласовал задачу "+
                        "<a href=http://corp-portal/task/"+agTask.getId()+"> " + "< " + agTask.getName()+ " >" + "</a></p>";

        mailSender.send(agTask.getAuthor().getEmail(), "Задача " +"< " + agTask.getName()+ " > согласована!", message);
    }

    public void sendAgAuthorApprove(Agreement agreement) {
        String mesage = "<p>Добрый День! </br>"
                + agreement.getName() + " согласовано всеми пользователями!</p>";

        mailSender.send(agreement.getAuthor().getEmail(), "Согласование завершено", mesage);
        mailSender.send(agreement.getResponsible().getEmail(), "Согласование завершено", mesage);
    }

    public void sendTaskDeadlineStatus(List<Task> taskList){
        for (Task task : taskList){
            String message = "<h4>Добрый День " + task.getResponsible().getFirstName() +" "+ task.getResponsible().getSurname()+ " !</h4>"+
                    "<p>Срок исполнения задачи <a href=http://corp-portal/task/" + task.getId()+ "> " + "< " + task.getName()+ " ></a>, заканчивается  <strong>" + task.getDeadline() + "</strong>!";
            mailSender.send(task.getResponsible().getEmail(), "Окончание срока по задаче " +"< " + task.getName()+ " >", message);
        }
    }

    public void sendTaskReminderDeadline(List<Task> list){
        for (Task task: list){
            String message = "<h4>Добрый День " + task.getResponsible().getFirstName() +" "+ task.getResponsible().getSurname()+ " !</h4>"+
                    "<p>Срок исполнения задачи <a href=http://corp-portal/task/" + task.getId()+ "> " + "< " + task.getName()+ " ></a>, истек  <strong>" + task.getDeadline() + "</strong>!";
            mailSender.send(task.getResponsible().getEmail(), "Истек срок исполнения по задаче " +"< " + task.getName()+ " >", message);

        }
    }

    public void sendAgDeadlineStatus(List<Agreement> agList){
        for (Agreement agreement : agList){
            String message = "<h4>Добрый День " + agreement.getResponsible().getFirstName() +" "+ agreement.getResponsible().getSurname()+ " !</h4>"+
                    "<p>Срок согласования <a href=http://corp-portal/agreement/" + agreement.getId()+ "> " + "< " + agreement.getName()+ " ></a>, заканчивается  <strong>" + agreement.getDeadline() + "</strong>!";
            mailSender.send(agreement.getResponsible().getEmail(), "Окончание срока по согласованию " +"< " + agreement.getName()+ " >", message);
        }
    }

    public void sendNewCommentTask(Task task, User author){
        String message = "<h4>Добрый День!</h4>"+
                "<p>В задаче <a href=http://corp-portal/task/" + task.getId()+ "> " + "< " + task.getName()+ " ></a>, новый комментарий<strong></strong>!";
       List<User> userList = new ArrayList();
       userList.add(task.getResponsible());
       userList.add(task.getAuthor());
       if (task.getTeam().size() != 0){
           for (User user: task.getTeam()){
               userList.add(user);
           }
       }
       for (User sendTo: userList){
           if (!sendTo.getUsername().equals(author.getUsername())){
               mailSender.send(sendTo.getEmail(), "Новый комментарий по задаче " +"< " + task.getName()+ " >", message);
           }
       }

    }


    public void sendNewCommentAg(Agreement agreement, User user) {

    }
}
