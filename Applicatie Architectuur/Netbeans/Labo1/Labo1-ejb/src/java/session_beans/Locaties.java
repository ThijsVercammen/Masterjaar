/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session_beans;

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
 * @author r0638823
 */
@Entity
@Table(name = "LOCATIES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Locaties.findAll", query = "SELECT l FROM Locaties l")
    , @NamedQuery(name = "Locaties.findByLnr", query = "SELECT l FROM Locaties l WHERE l.lnr = :lnr")
    , @NamedQuery(name = "Locaties.findByLnaam", query = "SELECT l FROM Locaties l WHERE l.lnaam = :lnaam")})
public class Locaties implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "LNR")
    private BigDecimal lnr;
    @Size(max = 255)
    @Column(name = "LNAAM")
    private String lnaam;
    @OneToMany(mappedBy = "lnrnaar")
    private List<Reservaties> reservatiesList;
    @OneToMany(mappedBy = "lnrvan")
    private List<Reservaties> reservatiesList1;

    public Locaties() {
    }

    public Locaties(BigDecimal lnr) {
        this.lnr = lnr;
    }

    public BigDecimal getLnr() {
        return lnr;
    }

    public void setLnr(BigDecimal lnr) {
        this.lnr = lnr;
    }

    public String getLnaam() {
        return lnaam;
    }

    public void setLnaam(String lnaam) {
        this.lnaam = lnaam;
    }

    @XmlTransient
    public List<Reservaties> getReservatiesList() {
        return reservatiesList;
    }

    public void setReservatiesList(List<Reservaties> reservatiesList) {
        this.reservatiesList = reservatiesList;
    }

    @XmlTransient
    public List<Reservaties> getReservatiesList1() {
        return reservatiesList1;
    }

    public void setReservatiesList1(List<Reservaties> reservatiesList1) {
        this.reservatiesList1 = reservatiesList1;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (lnr != null ? lnr.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Locaties)) {
            return false;
        }
        Locaties other = (Locaties) object;
        if ((this.lnr == null && other.lnr != null) || (this.lnr != null && !this.lnr.equals(other.lnr))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "session_beans.Locaties[ lnr=" + lnr + " ]";
    }
    
}
