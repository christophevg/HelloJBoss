package vg.christophe.HelloJBoss;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import javax.ejb.EJB;
import javax.ejb.Stateless;

@Stateless
public class GreeterBean implements Greeter {

  public String getGreeting() { 
    try {
      return "Hello from EJB3 & JSF land, " + this.getFirstName()  
            + ", this is JBoss World!" ; 
    } catch( Exception e ) {
      throw new RuntimeException(e);
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
