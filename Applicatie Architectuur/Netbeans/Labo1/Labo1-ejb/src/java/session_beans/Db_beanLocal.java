/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session_beans;

import java.math.BigDecimal;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author r0638823
 */
@Local
public interface Db_beanLocal {
    
    public List getReservaties();
    public void addKlant(Klanten k);
    public Klanten getKlant(BigDecimal knr);
    public List getLocaties();
    public List getWagens();
    public Locaties getLocatie(String naam);
    public Wagens getWagen(String naam);
    public void addReservatie(String datumvan, String datumres,
            String knr, String lnaar, String lvan, String wagen);
    public List getReservaties(String knr);
    public void removeReservatie(String mr);
    public Reservaties getReservatie(String mr);
}
