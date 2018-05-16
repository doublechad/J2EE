package tw.chad;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;



public class RegistrationTest {
	
	
	public static void registraOpenfire(String account,String password,String name) {
		 Blowfish _encoder=new Blowfish("YBoXFYhrM4Rbpnt");
		 try {
			Properties prop =new Properties();
			prop.setProperty("user", "root");
			prop.setProperty("password", "root");
			String net ="jdbc:mysql://127.0.0.1/xmpp";
			Connection dataBaseConn=DriverManager.getConnection(net,prop);
			String encodedStr=_encoder.encryptString(password);    
	        String time=String.format("00%d", System.currentTimeMillis());  
	        String sql="insert into ofUser (username,encryptedPassword,name,creationDate,modificationDate) VALUES (?,?,?,?,?)"; 
	        PreparedStatement stmt = dataBaseConn.prepareStatement(sql);  
	        stmt.setString(1, account);
	        stmt.setString(2, encodedStr);
	        stmt.setString(3, name);
	        stmt.setString(4, time);
	        stmt.setString(5, time);
	        stmt.executeUpdate();  
	        System.out.println("XMPP註冊OK");
		 } catch (Exception e) {
				System.out.println(e.toString());
			}
	}
	public static void modifyOpenfire(String account,String password,String name) {
		Blowfish _encoder=new Blowfish("YBoXFYhrM4Rbpnt");
		try {
			Properties prop =new Properties();
			prop.setProperty("user", "root");
			prop.setProperty("password", "root");
			String net ="jdbc:mysql://127.0.0.1/xmpp";
			Connection dataBaseConn=DriverManager.getConnection(net,prop);
			String encodedStr=_encoder.encryptString(password);    
	        String time=String.format("00%d", System.currentTimeMillis());  
	        //"UPDATE member SET password=?,realname=? WHERE account=?";
	        String sql="UPDATE ofUser SET encryptedPassword=?,name=?,creationDate=?,modificationDate=? WHERE username=?"; 
	        PreparedStatement stmt = dataBaseConn.prepareStatement(sql);  
	        stmt.setString(1, encodedStr);
	        stmt.setString(2, name);
	        stmt.setString(3, time);
	        stmt.setString(4, time);
	        stmt.setString(5, account);
	        stmt.executeUpdate();  
	        System.out.println("OPEN FIRE MODIFY OK");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
}
