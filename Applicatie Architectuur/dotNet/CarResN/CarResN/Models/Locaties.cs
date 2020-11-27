using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CarResN.Models
{
    public class Locaties
    {
        private string _naam;
        private int _nr;
        public Locaties()
        {
            _nr = 0;
            _naam = "Standaard locatie";
        }

        public Locaties(int nr, string naam)
        {
            this._nr = nr;
            this._naam = naam;
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
    }
}