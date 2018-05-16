package tw.chad;

import java.util.Calendar;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Sendmail {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
	    }  
	public static String createText() {
		StringBuffer sb =new StringBuffer();
		//48-57   65-90
		while(sb.length()<8) {
			int i =(int)(Math.random()*43)+48;
			if(i>57&&i<65) {
				i=i+(int)(Math.random()*10)+8;
			}
			sb.append((char)i);
		}
		Calendar c1 =Calendar.getInstance();
		return sb.toString()+c1.getTimeInMillis();
	}
	public static void cofirmMail(String mail,String parameter) {
			final String username = "tcfshchadnt@gmail.com";
			final String password = "cc8s8rw7ut";
			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
	
			Session session = Session.getInstance(props,
			  new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username, password);
				}
			  });
	
			try {
	
				Message message = new MimeMessage(session);
				message.setFrom(new InternetAddress("tcfshchadnt@gmail.com"));
				message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(mail));
				message.setSubject("Testing 認證信箱");
				message.setText("Dear Mail Crawler,"
					+ "請連結以下網址認證:"+"http://36.234.9.182:8080/J2EE/confrimMail.jsp?"+parameter);
	
				Transport.send(message);
	
				System.out.println("Done");
	
			} catch (MessagingException e) {
				throw new RuntimeException(e);
			}
	}
}



