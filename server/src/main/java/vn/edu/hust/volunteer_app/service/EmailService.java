package vn.edu.hust.volunteer_app.service;

import lombok.AllArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@AllArgsConstructor
@Service
public class EmailService {
    private final JavaMailSender javaMailSender;

    public String send(String to, String subject, String body) {
        try {
            SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
            simpleMailMessage.setTo(to);
            simpleMailMessage.setSubject(subject);
            simpleMailMessage.setText(body);
            javaMailSender.send(simpleMailMessage);
            return "ok";
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    public void send(String[] tos, String subject, String body) {
        for (String to : tos) {
            send(to, subject, body);
        }
    }
}
