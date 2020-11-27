/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Thijs Vercammen
 */
@Entity
@Table(name = "CONTACTEN")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Contacten.findAll", query = "SELECT c FROM Contacten c")
    , @NamedQuery(name = "Contacten.findByContactnr", query = "SELECT c FROM Contacten c WHERE c.contactnr = :contactnr")
    , @NamedQuery(name = "Contacten.findByBurger", query = "SELECT c FROM Contacten c WHERE c.burgernr = :burgernr")
    , @NamedQuery(name = "Contacten.findBySoortContact", query = "SELECT c FROM Contacten c WHERE c.soortContact = :soortContact")})
public class Contacten implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "CONTACTNR")
    private BigDecimal contactnr;
    @Size(max = 255)
    @Column(name = "SOORT_CONTACT")
    private String soortContact;
    @JoinColumn(name = "CONTACT", referencedColumnName = "BURGERNR")
    @ManyToOne
    private Burger contact;
    @JoinColumn(name = "BURGERNR", referencedColumnName = "BURGERNR")
    @ManyToOne
    private Burger burgernr;

    public Contacten() {
    }

    public Contacten(BigDecimal contactnr) {
        this.contactnr = contactnr;
    }

    public BigDecimal getContactnr() {
        return contactnr;
    }

    public void setContactnr(BigDecimal contactnr) {
        this.contactnr = contactnr;
    }

    public String getSoortContact() {
        return soortContact;
    }

    public void setSoortContact(String soortContact) {
        this.soortContact = soortContact;
    }

    public Burger getContact() {
        return contact;
    }

    public void setContact(Burger contact) {
        this.contact = contact;
    }

    public Burger getBurgernr() {
        return burgernr;
    }

    public void setBurgernr(Burger burgernr) {
        this.burgernr = burgernr;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (contactnr != null ? contactnr.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Contacten)) {
            return false;
        }
        Contacten other = (Contacten) object;
        if ((this.contactnr == null && other.contactnr != null) || (this.contactnr != null && !this.contactnr.equals(other.contactnr))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Contacten[ contactnr=" + contactnr + " ]";
    }
    
}
