using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DataImport.Util;

namespace DataImport.DataAccess
{
    class BaseDao
    {
        protected LogFileWriter Log = new LogFileWriter();

        protected string sqlStr;

        protected DataTable GetDataTable(SqlCommand command)
        {
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(dt);
                }
                return dt;
            }
        }

        protected DataRow GetDataRow(SqlCommand command)
        {
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(dt);
                    if (dt.Rows.Count > 0)
                        return dt.Rows[0];
                    else
                        return null;
                }
            }
        }

        protected List<T> GetList<T>(SqlCommand command)
        {
            List<T> list = new List<T>();
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(dt);

                    foreach (DataRow dr in dt.Rows)
                    {
                        list.Add((T)dr[0]);
                    }
                }
                return list;
            }
        }
    }
}
