/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session_beans;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

/**
 *
 * @author r0638823
 * Thijs Vercammen
 */
@Stateless
public class Db_bean implements Db_beanLocal {

    @PersistenceContext
    private EntityManager em;
    private int nr = 1;
    private int mr = 1;
    @Override
    public List getReservaties() {
        return em.createNamedQuery("Reservaties.findAll").getResultList();
    }
    
    public void addKlant(Klanten k){
        k.setKnr(BigDecimal.valueOf(nr));
        nr++;
        em.persist(k);
    }
    
    public Klanten getKlant(BigDecimal knr){
        try{
            return (Klanten) em.createNamedQuery("Klanten.findByKnr").setParameter("knr", knr).getSingleResult();
        }catch(NoResultException e) {
            return null;
        }
    }

    @Override
    public List getLocaties() {
        return em.createNamedQuery("Locaties.findAll").getResultList();
    }

    @Override
    public List getWagens() {
        return em.createNamedQuery("Wagens.findAll").getResultList();
    }

    @Override
    public Locaties getLocatie(String naam) {
         return (Locaties) em.createNamedQuery("Locaties.findByLnaam").setParameter("lnaam", naam).getSingleResult();
    }

    @Override
    public void addReservatie(String datumvan, String datumres, String knr, String lnaar, String lvan, String wagen) {
        try {
            Reservaties r = new Reservaties();
            Date d1 = new SimpleDateFormat("yyyy-MM-dd").parse(datumres);
            Date d2 = new SimpleDateFormat("yyyy-MM-dd").parse(datumvan);
            long diff = TimeUnit.DAYS.convert(d1.getTime()- d2.getTime(), TimeUnit.MILLISECONDS);
            r.setKnr(getKlant(new BigDecimal(knr)));
            r.setDagen(new BigInteger(Long.toString(diff)));
            r.setLnrnaar(getLocatie(lnaar));
            r.setLnrvan(getLocatie(lvan));
            r.setDatumres(d1);
            r.setDatumvan(d2);
            r.setWnr(getWagen(wagen));
            r.setMr(new BigDecimal(mr));
            mr++;
            em.persist(r);
        } catch (ParseException ex) {
            Logger.getLogger(Db_bean.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    @Override
    public Wagens getWagen(String naam) {
         return (Wagens) em.createNamedQuery("Wagens.findByWnaam").setParameter("wnaam", naam).getSingleResult();
    }

    @Override
    public List getReservaties(String knr) {
        return em.createQuery("SELECT r FROM Reservaties r WHERE r.knr = ?1").setParameter(1, getKlant(new BigDecimal(knr))).getResultList();
    }

    @Override
    public Reservaties getReservatie(String mr) {
        return (Reservaties) em.createNamedQuery("Reservaties.findByMr").setParameter("mr", new BigDecimal(mr)).getSingleResult();
    }
    
    @Override
    public void removeReservatie(String mr) {
        em.remove(getReservatie(mr));
        em.flush();
    }
}
