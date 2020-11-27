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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Thijs Vercammen
 */
@Entity
@Table(name = "TEST")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Test.findAll", query = "SELECT t FROM Test t")
    , @NamedQuery(name = "Test.findByTestnr", query = "SELECT t FROM Test t WHERE t.testnr = :testnr")})
public class Test implements Serializable {

    private static final long serialVersionUID = 1L;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "TESTNR")
    private BigDecimal testnr;
    @JoinColumn(name = "GEBRUIKER", referencedColumnName = "BURGERNR")
    @ManyToOne
    private Burger gebruiker;
    @JoinColumn(name = "STATUS", referencedColumnName = "STATUSNR")
    @ManyToOne
    private Status status;

    public Test() {
    }

    public Test(BigDecimal testnr) {
        this.testnr = testnr;
    }

    public BigDecimal getTestnr() {
        return testnr;
    }

    public void setTestnr(BigDecimal testnr) {
        this.testnr = testnr;
    }

    public Burger getGebruiker() {
        return gebruiker;
    }

    public void setGebruiker(Burger gebruiker) {
        this.gebruiker = gebruiker;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (testnr != null ? testnr.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Test)) {
            return false;
        }
        Test other = (Test) object;
        if ((this.testnr == null && other.testnr != null) || (this.testnr != null && !this.testnr.equals(other.testnr))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Test[ testnr=" + testnr + " ]";
    }
    
}
