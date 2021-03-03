package com.corp.portal.service;

import com.corp.portal.domain.Role;
import com.corp.portal.domain.User;
import com.corp.portal.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.mail.MessagingException;
import java.util.*;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender mailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);

        if (user == null){
            throw new UsernameNotFoundException("User not found");
        }
        return user;
    }

    public boolean addUser(User user){
        User userFromDb = userRepo.findByUsername(user.getUsername());
        System.out.println(user.getPassword());
        if (userFromDb != null){
            return false;
        }
        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);


        sendActivateMessage(user);
        return true;
    }

    private void sendActivateMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())){
            String message = String.format(
                 "Hello, %s! \n" +
                         "Welcome to Corp Portal. Please, visit next link: http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );

                mailSender.send(user.getEmail(), "Activate code",message);

        }
    }

    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);

        if (user == null){
            return false;
        }

        user.setActivationCode(null);
        userRepo.save(user);
        return true;
    }

    public List findAll() {
        return userRepo.findAll();
    }
    public User findById(Long user_id){
        return userRepo.findById(user_id).get();
    }
    public void saveUser(User user){
        userRepo.save(user);
    }

    //todo добавить редактирование всех полей
    public Boolean updateProfile( User user, Map<String, String> form) {
        /*String userEmail = user.getEmail();
        boolean isEmailChange = (email != null && !email.equals(userEmail));

        if (isEmailChange){
            user.setEmail(email);
        }
        if (!StringUtils.isEmpty(password)){
            user.setPassword(password);
        }*/

        user.setId(Long.parseLong(form.get("userId")));
        User usr = userRepo.findById(user.getId()).get();
        usr.setUsername(form.get("username"));
        usr.setFirstName(form.get("firstName"));
        usr.setSurname(form.get("surname"));
        usr.setPatronomic(form.get("patronomic"));
        usr.setEmail(form.get("email"));
        usr.setmPhone(form.get("mPhone"));
        usr.setwPhone(form.get("wPhone"));
        userRepo.saveAndFlush(usr);
        return true;
    }

}
