using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CarResN.Models
{
    public class Data
    {
        private ArrayList _wagenlijst = new ArrayList();
        private ArrayList _locatielijst = new ArrayList();

        public ArrayList wagenlijst
        {
            get
            {
                return _wagenlijst;
            }
            set
            {
                _wagenlijst = value;
            }
        }

        public ArrayList locatielijst
        {
            get
            {
                return _locatielijst;
            }
            set
            {
                _locatielijst = value;
            }
        }

        public Data()
        {
            wagenlijst.Add(new Autos(0, "ECO", 150));
            wagenlijst.Add(new Autos(1, "BREAK", 15000));
            wagenlijst.Add(new Autos(2, "COMFORT", 150000));

            locatielijst.Add(new Locaties(0, "LEUVEN"));
            locatielijst.Add(new Locaties(1, "BRUSSEL"));
            locatielijst.Add(new Locaties(2, "ANTWERPEN"));
        }

        public int getWagenID(string wagennaam)
        {
            for (int i = 0; i < wagenlijst.Count; i++)
            {
                if (((Autos)wagenlijst[i]).naam == wagennaam)
                {
                    return i;
                }
            }
            return 0;
        }

        public int getLocatieID(string locatienaam)
        {
            for (int i = 0; i < wagenlijst.Count; i++)
            {
                if (((Locaties)locatielijst[i]).naam == locatienaam)
                {
                    return i;
                }
            }
            return 0;
        }

    }
}