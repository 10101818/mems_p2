using System;
using System.Configuration;
using System.IO;
using System.Windows.Forms;

namespace DataImport.Domain
{
    public static class AppConfig
    {
        // db connection string
        public static readonly string DB_CONNECTION = ConfigurationSettings.AppSettings["SqlConnString"];
    }
}