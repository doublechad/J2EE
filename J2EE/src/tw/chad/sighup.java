package tw.chad;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class sighup
 */
@MultipartConfig
@WebServlet("/sighup")
public class sighup extends HttpServlet {
	HttpServletResponse response;
	Timer time;
	private static final long serialVersionUID = 1L;
	@Override
	public void init() throws ServletException {
		super.init();
		
	}
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher ds1 =request.getRequestDispatcher("Page.jsp");
		ds1.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.response=response;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String account =request.getParameter("account");
		String password =request.getParameter("password");
		String realname =request.getParameter("realname");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String checkMail=Sendmail.createText();
		try {
			if(CheckMember.checkAccount(account)) {
			int memberIndex =InsertIntoMysql(account,password,realname,gender,email,checkMail);
			System.out.println(memberIndex);
			Part part=request.getPart("avatar");
			String upload_path =request.getServletContext().getInitParameter("upload-path");
			File uploadFile =new File(upload_path,"user"+memberIndex+".jpg");
			InputStream in =part.getInputStream();
			byte[] temp =in.readAllBytes();
			in.close();
			System.out.println(temp.length);
				if(temp.length>0){
					FileOutputStream ot = new FileOutputStream(uploadFile);
					ot.write(temp);
					ot.flush();
					ot.close();
				}else {
					System.out.println("X");
				}
			request.setAttribute("email", email);
			request.setAttribute("checkMail", checkMail);
			request.getRequestDispatcher("addSucce.jsp").forward(request, response);
			}else {
				System.out.println("NONE");
				response.sendRedirect("addMember.jsp?stat=0");
				
			}
			} catch (Exception e) {
//				response.sendError(HttpServletResponse.SC_NO_CONTENT, e.toString());
				response.getWriter().append(e.toString());
			}

		
		
		
	}
	
	private int InsertIntoMysql(String account,String password,String realname,String gender,String email,String vcode) {
		int index = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			java.sql.Connection conn = DriverManager.getConnection(
					"jdbc:mysql://127.0.0.1/stock","root","root");
			String sql ="INSERT INTO member (account,password,realname,gender,email,vcode) VALUES"
					+ "(?,?,?,?,?,?)";

			String newpassed = BCrypt.hashpw(password, BCrypt.gensalt());	
			java.sql.PreparedStatement psat= conn.prepareStatement(sql);
			psat.setString(1, account);
			psat.setString(2, newpassed);
			psat.setString(3, realname);
			psat.setString(4, gender);
			psat.setString(5, email);
			psat.setString(6, vcode);
			psat.executeUpdate();
			String sql2="SELECT LAST_INSERT_ID()";
			java.sql.PreparedStatement psat2= conn.prepareStatement(sql2);
			ResultSet rs =psat2.executeQuery();
			if(rs.next()) {
				index = rs.getInt(1);
			}
			RegistrationTest.registraOpenfire(account, password,realname);
			System.out.println("OK");
			Sendmail.cofirmMail(email, "a="+account+"&vcode="+vcode);
			return index;
		} catch (Exception e) {
			System.out.println(e.toString());
			return index;
		}
	}

}
