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
@Table(name = "STATUS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Status.findAll", query = "SELECT s FROM Status s")
    , @NamedQuery(name = "Status.findByStatusnr", query = "SELECT s FROM Status s WHERE s.statusnr = :statusnr")
    , @NamedQuery(name = "Status.findByNaam", query = "SELECT s FROM Status s WHERE s.naam = :naam")})
public class Status implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "STATUSNR")
    private BigDecimal statusnr;
    @Size(max = 255)
    @Column(name = "NAAM")
    private String naam;
    @OneToMany(mappedBy = "risicostatus")
    private List<Burger> burgerList;
    @OneToMany(mappedBy = "status")
    private List<Test> testList;

    public Status() {
    }

    public Status(BigDecimal statusnr) {
        this.statusnr = statusnr;
    }

    public BigDecimal getStatusnr() {
        return statusnr;
    }

    public void setStatusnr(BigDecimal statusnr) {
        this.statusnr = statusnr;
    }

    public String getNaam() {
        return naam;
    }

    public void setNaam(String naam) {
        this.naam = naam;
    }

    @XmlTransient
    public List<Burger> getBurgerList() {
        return burgerList;
    }

    public void setBurgerList(List<Burger> burgerList) {
        this.burgerList = burgerList;
    }

    @XmlTransient
    public List<Test> getTestList() {
        return testList;
    }

    public void setTestList(List<Test> testList) {
        this.testList = testList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (statusnr != null ? statusnr.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Status)) {
            return false;
        }
        Status other = (Status) object;
        if ((this.statusnr == null && other.statusnr != null) || (this.statusnr != null && !this.statusnr.equals(other.statusnr))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Status[ statusnr=" + statusnr + " ]";
    }
    
}
