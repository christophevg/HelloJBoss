package vg.christophe.HelloJBoss;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import javax.ejb.EJB;

@SuppressWarnings("serial")
public class HelloServlet extends HttpServlet {

  @EJB
  private Greeter greeter;

  // This initialization is required for JBoss-4.2.3, where the annotations
  // aren't picked up correctly yet (due to a Tomcat issue)
  // As of Jboss-5.x this entire init method can be removed.
  public void init() throws ServletException {
    super.init();
    try {
      this.greeter = (Greeter)(new InitialContext())
        .lookup("HelloJBoss/GreeterBean/local");
    } catch( NamingException e ) {
      throw new RuntimeException(e);
    }
  }

  @Override
  public void service(HttpServletRequest request,HttpServletResponse response)
         throws ServletException, IOException 
  {
    PrintWriter out = response.getWriter();
    String name = "";
    try {
      name = this.getFirstName();
    } catch( Exception e ) {
      out.println( "Error: <pre>" + e + "</pre>" );
      name = "Somebody";
    } finally {
      out.println( "<html><body>" +
                   this.greeter.greet(name) +
                   "</body></html>" );
      out.close();
    }
  }

  private String getFirstName() throws NamingException, SQLException {
    final String sql = "SELECT * FROM info;";
    InitialContext context = new InitialContext();
    DataSource ds = (DataSource) context.lookup("java:db");
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
      con = ds.getConnection();
      stmt = con.createStatement();
      rs = stmt.executeQuery(sql);
      if(rs.next()) {
        return rs.getString(1);
      }
    } finally {
      if(rs != null) rs.close();
      if(stmt != null) stmt.close();
      if(con != null) con.close();
    }
    return "Nobody";
  }
}
