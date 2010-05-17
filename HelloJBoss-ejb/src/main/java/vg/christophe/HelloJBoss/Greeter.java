package vg.christophe.HelloJBoss;

import javax.ejb.Local;

@Local
public interface Greeter {
  public String getGreeting();
}
