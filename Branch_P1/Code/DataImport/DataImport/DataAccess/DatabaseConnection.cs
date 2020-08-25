using System;
using System.Data;
using System.Data.SqlClient;
using DataImport.Util;
using DataImport.Domain;

namespace DataImport.DataAccess
{
    public static class DatabaseConnection
    {
        private static LogFileWriter Log = new LogFileWriter();

        private static SqlConnection connSysproDb = null;

        public static bool OpenConnections()
        {
            try
            {
                connSysproDb = new SqlConnection();

                connSysproDb.ConnectionString = AppConfig.DB_CONNECTION;

                connSysproDb.Open();
            }
            catch (Exception sex)
            {
                Log.WriteLog("Error happened during openning syspro db" + sex.Message, sex.StackTrace);
                return false;
            }

            return true;
        }

        public static void CloseConnections()
        {
            try
            {
                if (connSysproDb != null)
                {
                    connSysproDb.Close();
                    connSysproDb = null;
                }
            }
            catch (Exception sex)
            {
                Log.WriteLog("Error happened during closing db" + sex.Message, sex.StackTrace);
            }
        }

        public static SqlCommand GetCommand(string sqlStr)
        {
            SqlCommand command = new SqlCommand(sqlStr, connSysproDb);
            command.CommandTimeout = 120;

            return command;
        }
    }
}
