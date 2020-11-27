/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import javax.ejb.EJB;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Arts;
import model.Burger;
import session_beans.Db_beanLocal;
import java.util.List;
import model.Contacten;
import model.Status;
import model.Test;

/**
 *
 * @author Thijs Vercammen
 */
public class Controller extends HttpServlet {

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
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("submit");
        if(action.equals("Burger")){
            response.sendRedirect("burger/gebruiker_overview.jsp");
        } else if(action.equals("Arts")){
            response.sendRedirect("arts/arts_overview.jsp");
        } else if(action.equals("nieuw contact")){
            String username = request.getRemoteUser();
            request.getSession().setAttribute("burgers", db.getAllBurgers(username));
            gotoPage("burger/nieuw_contact.jsp", request, response);
        }else if(action.equals("niewe test")){
            String username = request.getRemoteUser();
            Test t = db.getTest(username);
            if(t != null){
                request.getSession().setAttribute("testStatus", t.getStatus().getNaam());
                request.getSession().setAttribute("test", t);
            } else {
                request.setAttribute("testStatus", "Nog geen test uitgevoerd");
            }
            gotoPage("burger/test_aanvragen.jsp", request, response);
        } else if(action.equals("Voeg contact toe")){
            String username = request.getRemoteUser();
            String contact = request.getParameter("contact");
            String soort = request.getParameter("soort_contact");
            db.addContact(username, contact, soort);
            gotoPage("burger/gebruiker_overview.jsp", request, response);
        }else if(action.equals("Huidig risico")){
            String username = request.getRemoteUser();
            request.getSession().setAttribute("con", db.getContacten(username));
            request.getSession().setAttribute("risico", db.getRisicoStatus(username));
            gotoPage("burger/risico.jsp", request, response);
        }else if(action.equals("Test Aanvragen")){
            String username = request.getRemoteUser();
            Test t = db.getTest(username);
            if(t == null){
                t = new Test();
            }                
            t.setStatus(db.getStatus("In uitvoering"));
            db.updateTest(t, username);
            gotoPage("burger/gebruiker_overview.jsp", request, response);
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
