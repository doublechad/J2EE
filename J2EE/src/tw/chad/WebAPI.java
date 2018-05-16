package tw.chad;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Properties;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class WebAPI {
	
	public static ResultSet selectMember() {
		
		return null;
	}
	public static void uppdateMember(String newPassword,String realname,String account)    {
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Properties prop =new Properties();
		prop.setProperty("user", "root");
		prop.setProperty("password", "root");
		String newpassed = BCrypt.hashpw(newPassword, BCrypt.gensalt());
		Connection dataBase = DriverManager.getConnection("jdbc:mysql://127.0.0.1/stock", prop);
		try {
			dataBase.setAutoCommit(false);
			String sql2 ="UPDATE member SET password=?,realname=? WHERE account=?";
			PreparedStatement ps2 =dataBase.prepareStatement(sql2);
			ps2.setString(1,newpassed);
			ps2.setString(2,realname);
			ps2.setString(3,account);
			ps2.executeUpdate();
			dataBase.commit();
			RegistrationTest.modifyOpenfire(account,newPassword,realname);
		} catch (SQLException e) {
			if(dataBase!=null) {
				dataBase.close();
			}
			System.out.println(e.toString());
		}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	private static Elements getNewsLinks(String number) {
		try {
	        URL url1 = new URL("http://pchome.megatime.com.tw/stock/sto5/sid"+number+".html");
			HttpURLConnection conn1 =(HttpURLConnection)url1.openConnection();   //一開始的頁面抓取讀取set-cookie 的值 跟取得 Crumb-XXXX 的變數
			conn1.setDoOutput(true);
			conn1.setDoInput(true);
			conn1.setRequestProperty("User-agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:33.0) Gecko/20100101 Firefox/33.0");
			conn1.setRequestMethod("POST");  
			conn1.setReadTimeout(5000); 
			conn1.getPermission();
			conn1.connect();
			OutputStream outputStream = conn1.getOutputStream();   
            String params="is_check=1";  
            outputStream.write(params.getBytes());
			String temp ="";
			byte[] buf = new byte[1024*1024];
			int i = -1;
			InputStream inStream = conn1.getInputStream();
			while((i=inStream.read(buf))!=-1) {
				temp+= new String(buf,0,i,"UTF-8");
			}
			inStream.close();
//			DocumentBuilderFactory factory1 =DocumentBuilderFactory.newInstance();
//			DocumentBuilder builder = factory1.newDocumentBuilder();
			Document doc =  Jsoup.parse(temp); 
			Elements news  = doc.getElementsByClass("topics");
			Elements herfs =news.get(0).getElementsByTag("a");
			return herfs;
		  	} catch (Exception e) {
					System.out.println(e.toString());
					return null;
			}
	}
	public static String fromLinksGetNew(String number) {
		Elements links =getNewsLinks(number);
		int z =(int)(Math.random()*links.size());
		String foo =links.get(z).attr("href");
		System.out.println("http://pchome.megatime.com.tw"+foo);
		StringBuilder news = new StringBuilder();
		try {
			URL url = new URL("http://pchome.megatime.com.tw"+foo);
			HttpURLConnection conn =(HttpURLConnection)url.openConnection();
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestProperty("User-agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:33.0) Gecko/20100101 Firefox/33.0");
			conn.setRequestMethod("POST");  
			conn.setReadTimeout(5000); 
			conn.getPermission();
			conn.connect();
			OutputStream outputStream = conn.getOutputStream();   
            String params="is_check=1";  
            outputStream.write(params.getBytes());
			conn.connect();
			InputStream in = conn.getInputStream();
			String temp ="";
			byte[] buf = new byte[1024*1024];
			int i = -1;
			while((i=in.read(buf))!=-1) {
				temp+= new String(buf,0,i,"UTF-8");
			}
			Document doc =  Jsoup.parse(temp); 
			Elements div =doc.getElementsByClass("nwshdli");
			System.out.println(div.size());
			Elements texts =div.get(0).getElementsByTag("p");
			for(Element a : div) {
				if(a.hasText()) {
					news.append(a.text());
				}else {
					news.append(a.nextElementSibling().text());
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return news.toString();
	}
}
