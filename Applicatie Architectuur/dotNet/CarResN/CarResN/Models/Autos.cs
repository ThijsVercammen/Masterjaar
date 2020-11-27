using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CarResN.Models
{
    public class Autos
    {
        private int _nr;
        private string _naam;
        private int _prijs;
        public Autos()
        {
            _nr = 0;
            _naam = "Standaard wagen";
            _prijs = 0;
        }

        public Autos(int nr, string naam, int prijs)
        {
            this._nr = nr;
            this._naam = naam;
            this._prijs = prijs;
        }

        public int nr
        {
            get
            {
                return _nr;
            }
            set
            {
                _nr = value;
            }
        }

        public string naam
        {
            get
            {
                return _naam;
            }
            set
            {
                _naam = value;
            }

        }

        public int prijs
        {
            get
            {
                return _prijs;
            }
            set
            {
                _prijs = value;
            }
        }
    }
}