package vg.christophe.HelloJBoss;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
public class HelloServlet extends HttpServlet {
  @Override
  public void service( HttpServletRequest request, HttpServletResponse response ) 
         throws ServletException, IOException 
  {
    PrintWriter out = response.getWriter();
    out.println( "Hello, this is JBoss World!" ); 
    out.close();
  }   
}
