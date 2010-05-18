package vg.christophe.HelloJBoss;

import javax.ejb.Local;

@Local
public interface UserRepository {
  public User find(String id);
}
