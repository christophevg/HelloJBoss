package vg.christophe.HelloJBoss;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name="users")
public class User implements Serializable {
  private String userName;
  private String realName;
  
  public User() {
    this.userName = "";
    this.realName = "";
  }
  
  @Id 
  public String getUserName() { 
    return this.userName; 
  }
  
  public void setUserName(String name) {
    this.userName = name;
  }

  public String getRealName() { 
    return this.realName; 
  }
  
  public void setRealName(String name) {
    this.realName = name;
  }
}
