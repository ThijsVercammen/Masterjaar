/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session_beans;

import java.math.BigDecimal;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import model.Arts;
import model.Burger;
import model.Contacten;
import model.Status;
import model.Test;

/**
 *
 * @author Thijs Vercammen
 */
@Stateless
public class Db_bean implements Db_beanLocal {

    @PersistenceContext
    private EntityManager em;
    private int contactnr = 1;
    private int testnr = 1;

    @Override
    public Burger getBurger(String naam) {
        return (Burger) em.createNamedQuery("Burger.findByNaam").setParameter("naam", naam).getSingleResult();
    }

    @Override
    public Arts getArts(String naam) {
        return (Arts) em.createNamedQuery("Arts.findByNaam").setParameter("naam", naam).getSingleResult();
    }

    @Override
    public List<Burger> getAllBurgers(String naam) {
        return em.createQuery("SELECT b FROM Burger b WHERE b.naam <> ?1").setParameter(1, naam).getResultList();
    }

    @Override
    public void addContact(String burger, String contact, String type) {
        Contacten c = new Contacten();
        c.setBurgernr(getBurger(burger));
        c.setContact(getBurger(contact));
        c.setContactnr(new BigDecimal(contactnr));
        c.setSoortContact(type);
        em.persist(c);
        contactnr++;
    }

    @Override
    public List<Contacten> getContacten(String burger) {
        return em.createQuery("SELECT c FROM Contacten c WHERE c.burgernr = ?1").setParameter(1, getBurger(burger)).getResultList();
    }

    @Override
    public String getRisicoStatus(String burger) {
        List<Contacten> l = getContacten(burger);
        for(int i = 0; i< l.size(); i++){
            if((l.get(i).getSoortContact().equals("Nauw ontact")) ||(l.get(i).getSoortContact().equals("Gewoon ontact"))){
                if(l.get(i).getContact().getRisicostatus().getNaam().equals("Positief")){
                    return "ROOD";
                }
            }
        }
        return "GROEN";
    }

    @Override
    public Status getStatus(String status) {
        return (Status) em.createNamedQuery("Status.findByNaam").setParameter("naam", status).getSingleResult();
    }

    @Override
    public Test getTest(String burger) {
        if((em.createQuery("SELECT t FROM Test t WHERE t.gebruiker = ?1").setParameter(1, getBurger(burger)).getResultList()).size() > 0){
            return (Test) em.createQuery("SELECT t FROM Test t WHERE t.gebruiker = ?1").setParameter(1, getBurger(burger)).getSingleResult();
        }
        return null;
    }

    @Override
    public void updateTest(Test t, String burger) {
        if(t.getGebruiker() == null){
            t.setGebruiker(getBurger(burger));
            t.setTestnr(new BigDecimal(testnr));
        } else {
            em.remove(t);
            em.flush();
        }
        em.persist(t);
    }
}
