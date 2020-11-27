/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session_beans;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author r0638823
 */
@Entity
@Table(name = "RESERVATIES")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Reservaties.findAll", query = "SELECT r FROM Reservaties r")
    , @NamedQuery(name = "Reservaties.findByMr", query = "SELECT r FROM Reservaties r WHERE r.mr = :mr")
    , @NamedQuery(name = "Reservaties.findByDagen", query = "SELECT r FROM Reservaties r WHERE r.dagen = :dagen")
    , @NamedQuery(name = "Reservaties.findByDatumvan", query = "SELECT r FROM Reservaties r WHERE r.datumvan = :datumvan")
    , @NamedQuery(name = "Reservaties.findByDatumres", query = "SELECT r FROM Reservaties r WHERE r.datumres = :datumres")})
public class Reservaties implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "MR")
    private BigDecimal mr;
    @Column(name = "DAGEN")
    private BigInteger dagen;
    @Column(name = "DATUMVAN")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datumvan;
    @Column(name = "DATUMRES")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datumres;
    @JoinColumn(name = "KNR", referencedColumnName = "KNR")
    @ManyToOne
    private Klanten knr;
    @JoinColumn(name = "LNRNAAR", referencedColumnName = "LNR")
    @ManyToOne
    private Locaties lnrnaar;
    @JoinColumn(name = "LNRVAN", referencedColumnName = "LNR")
    @ManyToOne
    private Locaties lnrvan;
    @JoinColumn(name = "WNR", referencedColumnName = "WNR")
    @ManyToOne
    private Wagens wnr;

    public Reservaties() {
    }

    public Reservaties(BigDecimal mr) {
        this.mr = mr;
    }

    public BigDecimal getMr() {
        return mr;
    }

    public void setMr(BigDecimal mr) {
        this.mr = mr;
    }

    public BigInteger getDagen() {
        return dagen;
    }

    public void setDagen(BigInteger dagen) {
        this.dagen = dagen;
    }

    public Date getDatumvan() {
        return datumvan;
    }

    public void setDatumvan(Date datumvan) {
        this.datumvan = datumvan;
    }

    public Date getDatumres() {
        return datumres;
    }

    public void setDatumres(Date datumres) {
        this.datumres = datumres;
    }

    public Klanten getKnr() {
        return knr;
    }

    public void setKnr(Klanten knr) {
        this.knr = knr;
    }

    public Locaties getLnrnaar() {
        return lnrnaar;
    }

    public void setLnrnaar(Locaties lnrnaar) {
        this.lnrnaar = lnrnaar;
    }

    public Locaties getLnrvan() {
        return lnrvan;
    }

    public void setLnrvan(Locaties lnrvan) {
        this.lnrvan = lnrvan;
    }

    public Wagens getWnr() {
        return wnr;
    }

    public void setWnr(Wagens wnr) {
        this.wnr = wnr;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (mr != null ? mr.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Reservaties)) {
            return false;
        }
        Reservaties other = (Reservaties) object;
        if ((this.mr == null && other.mr != null) || (this.mr != null && !this.mr.equals(other.mr))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "session_beans.Reservaties[ mr=" + mr + " ]";
    }
    
}
