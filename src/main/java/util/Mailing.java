/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package util;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.http.HttpSession;
/**
 *
 * @author Shamanth
 */
public class Mailing {
    


public static void postMail( String[] recipients, String subject, String message ) throws MessagingException
{
    boolean debug = false;
    String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
    String SMTP_PORT = "465";
     //Set the host smtp address
     Properties props = new Properties();
     props.put("mail.smtp.host", "smtp.gmail.com");
     //props.put("mail.smtp.host", "localhost");
     props.put("mail.smtp.auth", "true");
     props.put("mail.debug", "false");
     props.put("mail.smtp.port", SMTP_PORT);
     props.put("mail.smtp.socketFactory.port", SMTP_PORT);
     props.put("mail.smtp.socketFactory.class", SSL_FACTORY);
     props.put("mail.smtp.socketFactory.fallback", "false");
    // create some properties and get the default Session
     //Session session = Session.getDefaultInstance(props);
    Session session = Session.getDefaultInstance(props,new javax.mail.Authenticator(){
            @Override
    protected PasswordAuthentication getPasswordAuthentication() {
    return new PasswordAuthentication("blogtrackers", "CosmosIsSuchAGreatResearchLab!");
    }
    });
    session.setDebug(debug);
    Transport tp = session.getTransport("smtp");
    tp.connect();
    // create a message
    Message msg = new MimeMessage(session);

    // set the from and to address
    InternetAddress addressFrom = new InternetAddress("blogtrackers@gmail.com");
    msg.setFrom(addressFrom);
    //

    InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
    for (int i = 0; i < recipients.length; i++)
    {
        addressTo[i] = new InternetAddress(recipients[i]);
    }
    msg.setRecipients(Message.RecipientType.TO, addressTo);
    // Optional : You can also set your custom headers in the Email if you Want
    msg.addHeader("MyHeaderName", "myHeaderValue");

    // Setting the Subject and Content Type
    msg.setSubject(subject);
    msg.setContent(message, "text/html");
    Transport.send(msg);
}

}
