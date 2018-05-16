package tw.chad;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONException;
import org.json.JSONObject;



@ServerEndpoint("/WebSocketTest")
public class WebSocketTest {
	private static final long serialVersionUID = 1L;
	static ArrayList<String> names ;
	static ArrayList<Session> sessions;         
	
    @OnOpen
    public void onOpen(Session session) {        //連結時
    	//紀錄連接到sessions中
    	System.out.println("Client connected");        
        if (sessions == null) {
            sessions = new ArrayList<Session>();
            
        }
        if (names == null) {
            names =new ArrayList<String>();
        }
        
        Map<String, List<String>> m1 =session.getRequestParameterMap();
        System.out.println(m1);
        String userName =m1.get("name").get(0);
        System.out.println(userName);
        try {
        boolean accpet= true;
        for(String s : names) {
        	if(s.equals(userName)) {
				session.getBasicRemote().sendText("{\"TEST\":\"error\"}");
					session.close();
					accpet=false;
					break;
			}
        }
        if(accpet) {
	        names.add(userName);
	        sessions.add(session);
	        Map map = new HashMap();
			map.put("TEST", "ok");
			JSONObject jsonObject = new JSONObject(map);
	        session.getBasicRemote().sendText(jsonObject.toString());
	        Map map1 = new HashMap();
			map1.put("userName", "系統");
			map1.put("message", "會員"+userName+"登入");
			JSONObject jObject = new JSONObject(map1);
	        for(Session s: sessions) {
	        	s.getBasicRemote().sendText(jObject.toString());
	        }
        }
        System.out.println("Current sessions size: " + sessions.size()+" names "+names.size());
        } catch (IOException e) {
			System.out.println(e.toString());
		}
    }
    @OnMessage
    public void onMessage(String message, Session session) throws IOException,
            InterruptedException, EncodeException {
        System.out.println(names.get(sessions.indexOf(session)) + message);
       for (Session s : sessions) {    //對每個連接的Client傳送訊息
            if (s.isOpen()&&!s.equals(session)) {
                s.getBasicRemote().sendText(message);
            }
        }
       
       String temp =new String(message.getBytes());
       try {
		JSONObject usrInput = new JSONObject(temp);
		String number =(String) usrInput.get("message");
	    if(isStockNumber(number)) {
		 	String news =WebAPI.fromLinksGetNew(number);
		 	Map map1 = new HashMap();
			map1.put("userName", "系統");
			map1.put("message", news);
			JSONObject jObject = new JSONObject(map1);
		 	
		 	for (Session s : sessions) {    //對每個連接的Client傳送訊息
		 		s.getBasicRemote().sendText(jObject.toString());
	            
	        }
	    }
	} catch (JSONException e) {
		System.out.println(e.toString());
	}

    }
    @OnClose
    public void onClose(Session session) {
        //將連接從sessions中移除
        System.out.println("Connection closed");
        if (sessions == null) {
            sessions = new ArrayList<Session>();
        }
        names.remove(sessions.indexOf(session));
        sessions.remove(session);
        
        System.out.println("Current sessions size: " + sessions.size());
    }
    private boolean isStockNumber(String number) {
    	try {
    	 LinkedList<String> allnumber =new LinkedList();
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
						"jdbc:mysql://localhost/stock","root","root");
			String sql="SELECT Count(*) from allnumber WHERE number= ?";
			PreparedStatement prestmt = conn.prepareStatement(sql);
			prestmt.setString(1, number);
			ResultSet rs =prestmt.executeQuery();
			rs.next();
			return rs.getInt(1)==1;
    	}catch(Exception e) {
    		System.out.println(e.toString());
    		return false;
    	}
    	
    }
}
