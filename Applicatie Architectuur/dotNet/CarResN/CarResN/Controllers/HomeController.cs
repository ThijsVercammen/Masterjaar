using CarResN.Models;
using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CarResN.Controllers
{
    public class HomeController : Controller
    {
        private Data d = new Data();
        Klanten klanten = Klanten.instance;
        Reservaties reservaties = Reservaties.instance;
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Reserveren()
        {
            string gebruiker = Request["klantnr"];
            Console.WriteLine("klantnummer: " + gebruiker);

            
            Session["data"] = d;

            if (klanten.check(int.Parse(gebruiker)))
            {
                Session["klantnr"] = gebruiker;
                return View();
            }
            else
            {
                return View("Registreer");
            }

        }

        public ActionResult Registreer()
        {
            return View();
        }

        public ActionResult Geregistreerd(string klantnaam, string klantadres, string postcode, string gemeente)
        {
            int gebruiker = klanten.add(klantnaam, klantadres, postcode, gemeente);
            Session["klantnr"] = gebruiker;
            return View("Reserveren");
        }

        public ActionResult Reserveer(string Plocaties, string types, string Dlocaties, string Pdate, string Ddate, string aantdagen)
        {
            int gebruiker = (int)Session["klantnr"];
            int cartype = d.getWagenID(types);
            int lnaar = d.getLocatieID(Plocaties);
            int lvan = d.getLocatieID(Dlocaties);

            DateTime pdate = Convert.ToDateTime(Pdate);
            DateTime ddate = Convert.ToDateTime(Ddate);
            reservaties.add(gebruiker, Convert.ToInt16(aantdagen), cartype, lnaar, lvan, pdate, ddate);
            //Session["reservaties"] = reservaties.GetReservaties(gebruiker);
            return View("Overzicht");
        }
    }
}