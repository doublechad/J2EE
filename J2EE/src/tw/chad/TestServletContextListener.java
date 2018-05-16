package tw.chad;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.AsyncContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ChatManager;
import org.jivesoftware.smack.MessageListener;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.packet.Message;

@WebServlet(urlPatterns="/track",asyncSupported=true)// 設定這個Servlet可以執行非同步處理
public class TestServletContextListener extends HttpServlet {
	private static final long serialVersionUID = 1L;
	List<AsyncContext> async =new ArrayList<>();
    public TestServletContextListener() {
        super();
        
    }
    
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		System.out.println("done");
		AsyncContext ac =request.startAsync();  //從請求取得非同步處理  然後釋放這個請求分配的執行緒
		ExecutorService es=(ExecutorService)request.getServletContext().getAttribute("es");
		async.add(ac);
		es.submit(new AsyncForRun(ac));
		
	}
	
	
	class AsyncForRun implements Runnable{
		private AsyncContext ac;
		private Double data;
		private ArrayList<AsyncContext> async;
		AsyncForRun(AsyncContext ac){
			this.ac=ac;
		}
		@Override
		public void run() {
			try {
			doMonitor();
			ac.complete();//呼叫完成
			async.remove(ac);//移除
			} catch (Exception e) {
				e.toString();
			}
			
		}
		private void doMonitor() throws Exception {
			long now =Calendar.getInstance().getTimeInMillis();
			String account =ac.getRequest().getParameter("account");
			String number =ac.getRequest().getParameter("number");
			String stat =ac.getRequest().getParameter("stat");
			String price =ac.getRequest().getParameter("price");
			System.out.println(account+":"+number+":"+stat+":"+price);
			boolean doAgain = false;
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://127.0.0.1/immdate","root","root");
			do{
				doAgain = checkStock(conn,number,Integer.parseInt(stat),Double.parseDouble(price));
				if(doAgain) {
					sendMessage(account,number,Integer.parseInt(stat),price);
				}
				try {
					Thread.sleep(5000);
				} catch (InterruptedException e) {
					System.out.println(e.toString());
				}
			}while(!doAgain);
			System.out.println(data);
			
			
		}
		private void sendMessage(String account,String number,int  stat,String price) {
			XMPPConnection connection = new XMPPConnection("36.234.3.180");
			  if (!connection.isConnected()) { //是否連線
	              try {
						connection.connect();   
					} catch (XMPPException e) {
						System.out.println("XX");
					} 
	      }
			 if (!connection.isAuthenticated()) { //是否登入
	            try {
					connection.login("system","system");
				} catch (XMPPException e) {
					System.out.println(e.toString());
				} 
	    }
			 System.out.println(connection.isAuthenticated());
			 ChatManager chatManager = connection.getChatManager();
			 Chat chat =chatManager.createChat(account+"@36.234.3.180", new MessageListener() {
				@Override
				public void processMessage(Chat arg0, Message arg1) {
					// TODO Auto-generated method stub
					
				}
			});
			String overOrLess =(stat==0)?">":"<";
			try {
				chat.sendMessage("代號 : "+number+" 價格 "+ overOrLess+" "+price);
				System.out.println("send ok");
			} catch (XMPPException e) {
				System.out.println(e.toString());
			}
//			connection.disconnect();
		}
		private boolean checkStock(Connection conn,String number,int stat,double price) {
			try {
				
				String sql="SELECT closeValue FROM tw"+number+" ORDER BY closeValue Desc Limit 1";
				ResultSet rs =conn.createStatement().executeQuery(sql);
				rs.next();
				data =rs.getDouble(1);
				boolean foo =false;
				switch(stat) {
				case 0:foo=(data>price);
						break;
				case 1:foo=(data<price);
						break;
				default:System.out.println("error");;
				}
				return foo; 
			} catch (Exception e) {
				System.out.println(e.toString());
				return false;
			}
		}
	}	

}
