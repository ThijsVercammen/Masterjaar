using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SQLite;

namespace CarResN.Models
{
    public class Klanten
    {
        private static Klanten _instance;
        private DataTable klantTable;
        private SQLiteDataAdapter klantAdapter;
        private DB db = DB.instance;

        //constructor
        public Klanten()
        {

            klantAdapter = new SQLiteDataAdapter("select * FROM QCR_Customers;", db.connect());
            klantTable = new DataTable("Klanten");
            klantAdapter.Fill(klantTable);
            SQLiteCommandBuilder c_builder = new SQLiteCommandBuilder(klantAdapter);

            Console.WriteLine("DataTable gevuld\n");
        }

        //getter voor de singleton instance
        public static Klanten instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new Klanten();
                }
                return _instance;
            }
        }

        //select een klant
        public DataRow[] select(string expressie)
        {
            return klantTable.Select(expressie);
        }

        //voeg een klant toe
        public int add(string naam, string adres, string postcode, string gemeente)
        {
            DataRow[] r = klantTable.Select("nr = max(nr)");
            int knr = (int)r[0][0] + 1;
            Console.WriteLine("Klantnummer " + knr + " met naam " + naam + " op adres  " + adres + " postcode " + postcode + " gemeente " + gemeente);
            klantTable.Rows.Add(knr, naam, adres, int.Parse(postcode), gemeente);
            klantAdapter.Update(klantTable);
            return knr;
        }

        //check if a user exists
        public bool check(int knr)
        {
            DataRow[] r = klantTable.Select("nr = " + knr);
            return r.Length != 0;
        }


    }
}