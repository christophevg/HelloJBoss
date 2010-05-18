package vg.christophe.HelloJBoss;

import javax.ejb.Stateless;

@Stateless
public class GreeterBean implements Greeter {

  public String greet(User user) {
    try {
      return "Hello from EJB3 & JSF land, " + 
            ( user != null ? user.getRealName() : "Mr. Unknown" )
            + ", this is JBoss World!" ; 
    } catch( Exception e ) {
      throw new RuntimeException(e);
    }
  }

}
