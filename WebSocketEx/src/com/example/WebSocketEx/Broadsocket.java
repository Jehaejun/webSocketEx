package com.example.WebSocketEx;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint("/broadcasting")
public class Broadsocket {

	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	public static int getSesseionCount() {
		return clients.size();
	}
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		//System.out.println(message);

//		JsonParser parser = new JsonParser();
/*		JsonObject rootObejct = (JsonObject)new JsonParser().parse(message);
		rootObejct.addProperty("SESSION_COUNT", clients.size());
		String _message = rootObejct.toString();*/
//		System.out.println(_message);
		synchronized (clients) {
			
			// Iterate over the connected sessions
			// and broadcast the received message
			for (Session client : clients) {
				if (!client.equals(session)) {
					//client.getBasicRemote().sendText(message);
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}

	@OnOpen
	public void onOpen(Session session) {
		// Add session to the connected sessions set
	//	System.out.println(session + " key ==> " + session.getId());
		clients.add(session);
	}

	@OnClose
	public void onClose(Session session) {
		// Remove session from the connected sessions set
		clients.remove(session);
	//	System.out.println("��������");
	}
}