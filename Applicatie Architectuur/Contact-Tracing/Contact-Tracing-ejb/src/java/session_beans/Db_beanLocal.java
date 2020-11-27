/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session_beans;

import java.util.List;
import javax.ejb.Local;
import model.Arts;
import model.Burger;
import model.Contacten;
import model.Status;
import model.Test;

/**
 *
 * @author Thijs Vercammen
 */
@Local
public interface Db_beanLocal {
    
    public Burger getBurger(String naam);
    public Arts getArts(String naam);
    public List<Burger> getAllBurgers(String naam);
    public void addContact(String burger, String contact, String type);
    public List<Contacten> getContacten(String burger);
    public String getRisicoStatus(String burger);
    public Status getStatus(String status);
    public Test getTest(String burger);
    public void updateTest(Test t, String burger);
    
}
