package com.example.WebSocketEx;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChatManager
 */
@WebServlet("/ChatManager.do")
public class ChatManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChatManager() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		// TODO Auto-generated method stub
		RequestDispatcher view = request.getRequestDispatcher("wc_ChatRoom.jsp");
		view.forward(request, response);
		/*IpCheck check = new IpCheck();
		RequestDispatcher view = null;
		if(check.authentication(request)){
			view = request.getRequestDispatcher("wc_ChatRoom.jsp");
			view.forward(request, response);
		}else{
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert(\"�ΰ����� ���� ������Դϴ�.\");");
			out.println("</script>");
		}*/
	}
}
