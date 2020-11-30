using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SQLite;
using System.Data;
using System.Collections;

namespace CarResN.Models
{
    public class Reservaties
    {
        private static Reservaties _instance;
        private DataTable ReservatieTable;
        private SQLiteDataAdapter ReservatieAdapter;
        private DB db = DB.instance;

        //constructor
        public Reservaties()
        {

            ReservatieAdapter = new SQLiteDataAdapter("select * from QCR_reservations", db.connect());
            ReservatieTable = new DataTable("Reservaties");
            ReservatieAdapter.Fill(ReservatieTable);
            SQLiteCommandBuilder bob = new SQLiteCommandBuilder(ReservatieAdapter);

            Console.WriteLine("DataTable gevuld\n");
        }

        //getter voor de singleton instance
        public static Reservaties instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new Reservaties();
                }
                return _instance;
            }
        }

        //select een reservaties
        public DataRow[] select(string expressie)
        {
            return ReservatieTable.Select(expressie);
        }

        //voeg een klant toe
        public void add(int knr, int dagen, int wnr, int lnrvan, int lnrnaar, DateTime datum, DateTime einddatum)
        {
            DataRow[] r = ReservatieTable.Select("cnr = max(cnr)");
            int rnr;
            if (r.Length == 0)
            {
                rnr = 0;
            }
            else
            {
                rnr = (int)r[0][0] + 1;
            }

            ReservatieTable.Rows.Add(rnr, knr, dagen, wnr, lnrvan, lnrnaar, datum, einddatum);
            ReservatieAdapter.Update(ReservatieTable);
        }

        public ArrayList GetReservaties(int cnr)
        {
            DataRow[] r = ReservatieTable.Select("cnr");
            ArrayList result = new ArrayList();
            for (int i = 0; i <= r.Length; i++)
            {
                result.Add(r[i]);
            }
            return result;
        }

    }
}