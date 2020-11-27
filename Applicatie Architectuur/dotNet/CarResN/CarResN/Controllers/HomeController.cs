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
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Reserveren()
        {
            //Data d = new Data();
            string gebruiker = Request["klantnr"];
            Session["klantnr"] = gebruiker;
            Session["data"] = d;
            return View(d);
        }

        public ActionResult Registreer()
        {
            return View();
        }
    }
}