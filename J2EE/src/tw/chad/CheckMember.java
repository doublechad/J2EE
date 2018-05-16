package tw.chad;

import java.sql.DriverManager;
import java.sql.ResultSet;

public class CheckMember {
	CheckMember(){
		
	}
	public static boolean checkPasswd(String input,String database) {
		return BCrypt.checkpw(input, database);
	}
	public static boolean checkAccount(String account) throws Exception {
		int result=1;
		
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection conn = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1/stock","root","root");
		String sql ="SELECT count(*) FROM member WHERE account= ? ";
		java.sql.PreparedStatement psat= conn.prepareStatement(sql);
		psat.setString(1, account);
		ResultSet rs = psat.executeQuery();
		rs.next();
		result =rs.getInt(1);
		
		return result==0?true:false;
	}
}
