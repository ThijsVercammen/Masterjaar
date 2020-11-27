/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

/**
 *
 * @author r0638823
 */
public class Reservaties {
    String locatie;
    String model;
    String klantnr;
    double prijs;

public Reservaties(String locatie, String model, String klantnr, double prijs){
    this.locatie = locatie;
    this.model = model;
    this.klantnr = klantnr;
    this.prijs = prijs;
}

public String getLocatie(){
    return this.locatie;
}
public String getModel(){
    return this.model;
}
public String getKlantnr(){
    return this.klantnr;
}

public double getPrijs(){
    return this.prijs;
}
}