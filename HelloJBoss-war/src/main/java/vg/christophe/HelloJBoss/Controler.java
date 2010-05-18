package vg.christophe.HelloJBoss;

import javax.naming.InitialContext;

public class Controler {
  
  private User user;
  
  public Controler() {
    this.user = new User();
  }

  public User getUser() {
    return this.user;
  }
  
  public void setUser(User user) {
    this.user = user;
  }

  public String getGreet() { 
    this.retrieveUser();
    return this.getGreeter().greet(this.user);
  }
  
  private void retrieveUser() {
    this.user = this.getUserRepository().find(this.user.getUserName());
  }
  
  private UserRepository getUserRepository () {
    try {
      InitialContext ctx = new InitialContext();
      return (UserRepository) 
        ctx.lookup("HelloJBoss/UserRepositoryBean/local");
    } catch( Exception e ) {
      e.printStackTrace();
      throw new RuntimeException("couldn't lookup UserRepository", e);
    }
  }

  private Greeter getGreeter () {
    try {
      InitialContext ctx = new InitialContext();
      return (Greeter) ctx.lookup("HelloJBoss/GreeterBean/local");
    } catch( Exception e ) {
      e.printStackTrace();
      throw new RuntimeException("couldn't lookup Greeter", e);
    }
  }
}
