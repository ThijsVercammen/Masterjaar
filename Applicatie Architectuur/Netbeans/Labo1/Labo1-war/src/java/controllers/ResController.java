/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Thijs Vercammen
 */
package controllers;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import session_beans.Db_beanLocal;
import session_beans.Klanten;

/**
 *
 * @author r0638823, Thijs Vercammen
 */

public class ResController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    @EJB private Db_beanLocal db;
    
    @Override
    public void init(){
        getServletContext().setAttribute("locatieList", db.getLocaties());
        getServletContext().setAttribute("typeList", db.getWagens());
        getServletContext().setAttribute("korting", "0.25");
    }
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.setContentType("text/html;charset=UTF-8");
            String action = request.getParameter("submit");
            
            if(action.equals("volgend")){
                String klantnr = request.getParameter("klantnr");
                Klanten k = db.getKlant(BigDecimal.valueOf(Integer.parseInt(klantnr)));
                if(k == null){
                    gotoPage("klant.jsp", request, response);
                } else{
                    request.getSession().setAttribute("klantnr", k.getKnaam());
                    request.getSession().setAttribute("nr", k.getKnr());
                    gotoPage("reserveer.jsp", request, response);    
                }
            } else if(action.equals("nieuwe klant")) {
                gotoPage("klant.jsp", request, response);
            } else if(action.equals("registreer")){
                Klanten k = new Klanten();
                k.setKnaam(request.getParameter("klantnaam"));
                k.setAdres(request.getParameter("klantadres"));
                k.setPostcode(BigInteger.valueOf(Integer.parseInt(request.getParameter("postcode"))));
                k.setGemeente(request.getParameter("gemeente"));
                db.addKlant(k);
                request.getSession().setAttribute("klantnr", k.getKnaam());
                request.getSession().setAttribute("nr", k.getKnr());
                response.encodeRedirectURL("Rescontroller");
                gotoPage("reserveer.jsp", request, response); 
            } else if(action.equals("reserveer")){
                String pickup = request.getParameter("Plocaties");
                String types = request.getParameter("types");
                String dropof = request.getParameter("Dlocaties");
                String Pdatum = request.getParameter("Pdate");
                String Ddatum = request.getParameter("Ddate");
                String knr = request.getSession().getAttribute("nr").toString();
                db.addReservatie(Pdatum, Ddatum, knr, pickup, dropof, types);
                request.getSession().setAttribute("reservaties", db.getReservaties(knr));
                gotoPage("overzicht.jsp", request, response);
            } else if(action.equals("afmelden")){
                request.getSession().invalidate();
                gotoPage("index.jsp", request, response);
            }  else if(action.equals("volgende reservatie")){
                gotoPage("reserveer.jsp", request, response); 
            }  else if(action.equals("delete")){
                db.removeReservatie(request.getParameter("res_nr"));
                gotoPage("confirm_delete.jsp", request, response); 
            } else if(action.equals("ok")){
                String knr = request.getSession().getAttribute("nr").toString();
                request.getSession().setAttribute("reservaties", db.getReservaties(knr));
                gotoPage("overzicht.jsp", request, response); 
            } 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    protected void gotoPage(String page,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        RequestDispatcher view = request.getRequestDispatcher(page);
        view.forward(request, response);
    }
}
