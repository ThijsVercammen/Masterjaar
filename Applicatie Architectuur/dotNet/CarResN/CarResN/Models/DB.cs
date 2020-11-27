using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SQLite;

namespace CarResN.Models
{
    public class DB
    {
        private static DB _instance;

        public SQLiteConnection connect()
        {
            String db = @"URI=file:C:\db\carres.db";

            SQLiteConnection conn = new SQLiteConnection(db);
            conn.Open();
            return conn;
        }

        public static DB instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new DB();
                }
                return _instance;
            }
        }
    }
}