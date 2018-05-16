package tw.chad;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import javax.servlet.AsyncContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
//這個WebListener 會在 伺服器啟動跟結束的時候 執行
@WebListener()
public class AvatarInitializer implements ServletContextListener {
//	Connection conn;
	ExecutorService es = Executors.newFixedThreadPool(10);  //透過 Executors 創造一個執行緒池
	
	
    public void contextInitialized(ServletContextEvent sce) { //伺服器啟動的時候執行這個方法
        ServletContext context = sce.getServletContext();   //透過這個監聽器取得
       
        context.setAttribute("es",es );
     
       
    }

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {//伺服器結束的時候執行這個方法
//		try {
//			conn.close();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}

		try {  
	       
	        es.shutdown();  //傳達準備關閉
	    
	        if(!es.awaitTermination(10, TimeUnit.MILLISECONDS)){  //準備一秒後關閉
	            // 時間到後向所有THREAD(interrupted)。  
	            es.shutdownNow();  
	        }  
	    } catch (InterruptedException e) {  
	        // awaitTermination方法被中断的时候全部Thread。  
	        System.out.println("awaitTermination interrupted: " + e);  
	        es.shutdownNow();  
	    } 
		System.out.println("end");
	};
}

	
