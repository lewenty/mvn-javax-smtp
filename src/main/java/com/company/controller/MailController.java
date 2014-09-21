package com.company.controller;

import com.company.model.Mail;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Properties;

@Controller
public class MailController {


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "index";
    }


    @RequestMapping(value = "/mail/send.htm", method = RequestMethod.POST)
    public
    @ResponseBody
    Mail sendMail(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        final Mail mail = new Mail();
        mail.setFirstname(request.getParameter("firstname")); // Adı
        mail.setLastname(request.getParameter("lastname")); // Soyadı
        mail.setFromMail(request.getParameter("email")); //Gönderen Mail
        mail.setToMail(request.getParameter("email")); // Alan Mail
        mail.setPassword(request.getParameter("password")); // Gönderen Mail Şifresi
        mail.setMessage(request.getParameter("message")); // Mail mesajı
        mail.setSubject(request.getParameter("subject")); //mail konusu


        mail.setHost("smtp.gmail.com"); //sender smtp host
        mail.setPort(587);//smtp port

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", mail.getHost());
        props.put("mail.smtp.port", "587");//gönderen mail port


        // Get the Session object.
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(mail.getFromMail(), mail.getPassword());
                    }
                });


        try {
            //default mime object
            Message message = new MimeMessage(session);

            //set from mail
            message.setFrom(new InternetAddress(mail.getFromMail()));

            //set recipient
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(mail.getToMail()));

            //set subject
            message.setSubject(mail.getSubject());

            //set message
            message.setText(mail.getMessage());

            //send e-Mail
            Transport.send(message);

            System.out.println("Mail Gonderildi");

            mail.setStatus(true);

        } catch (MessagingException e) {
            mail.setStatus(false);
            throw new RuntimeException(e);
        }

        return mail;
    }


}