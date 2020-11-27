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
@Table(name = "ARTS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Arts.findAll", query = "SELECT a FROM Arts a")
    , @NamedQuery(name = "Arts.findByArtsnr", query = "SELECT a FROM Arts a WHERE a.artsnr = :artsnr")
    , @NamedQuery(name = "Arts.findByNaam", query = "SELECT a FROM Arts a WHERE a.naam = :naam")
    , @NamedQuery(name = "Arts.findByWachtwoord", query = "SELECT a FROM Arts a WHERE a.wachtwoord = :wachtwoord")})
public class Arts implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ARTSNR")
    private BigDecimal artsnr;
    @Size(max = 255)
    @Column(name = "NAAM")
    private String naam;
    @Size(max = 255)
    @Column(name = "WACHTWOORD")
    private String wachtwoord;

    public Arts() {
    }

    public Arts(BigDecimal artsnr) {
        this.artsnr = artsnr;
    }

    public BigDecimal getArtsnr() {
        return artsnr;
    }

    public void setArtsnr(BigDecimal artsnr) {
        this.artsnr = artsnr;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (artsnr != null ? artsnr.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Arts)) {
            return false;
        }
        Arts other = (Arts) object;
        if ((this.artsnr == null && other.artsnr != null) || (this.artsnr != null && !this.artsnr.equals(other.artsnr))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Arts[ artsnr=" + artsnr + " ]";
    }
    
}
