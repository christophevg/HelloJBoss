package vg.christophe.HelloJBoss;

import javax.ejb.*;
import javax.persistence.*;
import static javax.persistence.PersistenceContextType.EXTENDED;

@Stateless
public class UserRepositoryBean implements UserRepository {

  @PersistenceContext
  private EntityManager em;

  public User find(String username) {
    return (User) em.find(User.class, username);
  }

}
