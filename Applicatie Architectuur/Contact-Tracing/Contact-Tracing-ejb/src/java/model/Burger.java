/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Thijs Vercammen
 */
@Entity
@Table(name = "BURGER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Burger.findAll", query = "SELECT b FROM Burger b")
    , @NamedQuery(name = "Burger.findByBurgernr", query = "SELECT b FROM Burger b WHERE b.burgernr = :burgernr")
    , @NamedQuery(name = "Burger.findByNaam", query = "SELECT b FROM Burger b WHERE b.naam = :naam")
    , @NamedQuery(name = "Burger.findByWachtwoord", query = "SELECT b FROM Burger b WHERE b.wachtwoord = :wachtwoord")})
public class Burger implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "BURGERNR")
    private BigDecimal burgernr;
    @Size(max = 255)
    @Column(name = "NAAM")
    private String naam;
    @Size(max = 255)
    @Column(name = "WACHTWOORD")
    private String wachtwoord;
    @JoinColumn(name = "RISICOSTATUS", referencedColumnName = "STATUSNR")
    @ManyToOne
    private Status risicostatus;
    @OneToMany(mappedBy = "gebruiker")
    private List<Test> testList;
    @OneToMany(mappedBy = "contact")
    private List<Contacten> contactenList;
    @OneToMany(mappedBy = "burgernr")
    private List<Contacten> contactenList1;

    public Burger() {
    }

    public Burger(BigDecimal burgernr) {
        this.burgernr = burgernr;
    }

    public BigDecimal getBurgernr() {
        return burgernr;
    }

    public void setBurgernr(BigDecimal burgernr) {
        this.burgernr = burgernr;
    }

    public String getNaam() {
        return naam;
    }

    public void setNaam(String naam) {
        this.naam = naam;
    }

    public String getWachtwoord() {
        return wachtwoord;
    }

    public void setWachtwoord(String wachtwoord) {
        this.wachtwoord = wachtwoord;
    }

    public Status getRisicostatus() {
        return risicostatus;
    }

    public void setRisicostatus(Status risicostatus) {
        this.risicostatus = risicostatus;
    }

    @XmlTransient
    public List<Test> getTestList() {
        return testList;
    }

    public void setTestList(List<Test> testList) {
        this.testList = testList;
    }

    @XmlTransient
    public List<Contacten> getContactenList() {
        return contactenList;
    }

    public void setContactenList(List<Contacten> contactenList) {
        this.contactenList = contactenList;
    }

    @XmlTransient
    public List<Contacten> getContactenList1() {
        return contactenList1;
    }

    public void setContactenList1(List<Contacten> contactenList1) {
        this.contactenList1 = contactenList1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (burgernr != null ? burgernr.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Burger)) {
            return false;
        }
        Burger other = (Burger) object;
        if ((this.burgernr == null && other.burgernr != null) || (this.burgernr != null && !this.burgernr.equals(other.burgernr))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Burger[ burgernr=" + burgernr + " ]";
    }
    
}
