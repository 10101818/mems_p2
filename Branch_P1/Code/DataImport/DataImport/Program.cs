using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using DataImport.DataAccess;
using DataImport.Util;

namespace DataImport
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            LogFileWriter log = new LogFileWriter();

            try
            {
                if (DatabaseConnection.OpenConnections() == false)
                {
                    UIUtil.ShowError("Cannot open database connection.", "ImportData - Error", true);
                    return;
                }

                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new MainForm());
            }
            catch (Exception ex)
            {
                log.WriteLog("Unexpected error happened in main: " + ex.Message, ex.StackTrace);
                UIUtil.ShowError("Unexpected error happened: " + ex.Message, "ImportData - Error", true);
            }
            finally
            {
                DatabaseConnection.CloseConnections();
            }
        }
    }
}
