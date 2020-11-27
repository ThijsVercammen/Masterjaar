/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author r0638823
 */
public class Locaties {
    ArrayList<String> locaties;
    ArrayList<String> types;

    public Locaties() {
        this.locaties = new ArrayList<>();
        locaties.add("Leuven");
        locaties.add("Antwerpen");
        locaties.add("Brussel");
        locaties.add("Gent"); 
        this.types = new ArrayList<>();
        types.add("Compact");
        types.add("Break");
        types.add("Sport");
        types.add("ECO"); 
    }
    
    public ArrayList<String> getLocaties(){
        return this.locaties;
    }
    
     public ArrayList<String> getTypes(){
        return this.types;
    }
}
