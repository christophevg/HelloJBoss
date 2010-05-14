package vg.christophe.HelloJBoss;

import javax.ejb.Stateless;

@Stateless
public class GreeterBean implements Greeter {
  public String greet( String name ) { 
    return "Hello from EJB3, " + name + ", this is JBoss World!" ; 
  }
}
