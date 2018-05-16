package tw.chad;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;



/**
 * Servlet implementation class testupload
 */
@MultipartConfig
@WebServlet("/testupload")
public class testupload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		Part part =request.getPart("avatar");
		String upload_path =request.getServletContext().getInitParameter("upload-path");
		String filename = getFilename(part);
		response.getWriter().println(filename);
		response.getWriter().println(upload_path);
		File uploadFile =new File(upload_path,filename);
		InputStream in =part.getInputStream();
		FileOutputStream ot = new FileOutputStream(uploadFile);
		ot.write(in.readAllBytes());
		in.close();
		ot.flush();
		ot.close();
	}
	private static String getFilename(Part part) {
	    for (String cd : part.getHeader("content-disposition").split(";")) {
	      if (cd.trim().startsWith("filename")) {
	        String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
	        return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
	      }
	    }
	    return null;
	  }
	

}
