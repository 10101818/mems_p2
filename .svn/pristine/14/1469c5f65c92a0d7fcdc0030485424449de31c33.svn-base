using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using DataImport.Domain;
using DataImport.Util;

namespace DataImport.DataAccess
{
    class QueryDao : BaseDao
    {
        public List<EquipmentInfo> GetEquipments()
        {
            List<EquipmentInfo> infos = new List<EquipmentInfo>();

            sqlStr = "SELECT ID, DepartmentID, InstalEndDate, ScrapDate FROM tblEquipment " +
                     " WHERE DepartmentID NOT IN (4, 9)";

            using (SqlCommand command = DatabaseConnection.GetCommand(sqlStr))
            {
                using (DataTable dt = GetDataTable(command))
                {
                    EquipmentInfo info = null;
                    foreach (DataRow dr in dt.Rows)
                    {
                        info = new EquipmentInfo();
                        info.ID = SQLUtil.ConvertInt(dr["ID"]);
                        info.Department.ID = SQLUtil.ConvertInt(dr["DepartmentID"]);
                        info.InstalEndDate = SQLUtil.ConvertDateTime(dr["InstalEndDate"]);
                        info.ScrapDate = SQLUtil.ConvertDateTime(dr["ScrapDate"]);

                        infos.Add(info);
                    }
                }
            }

            return infos;
        }

        public List<ServiceHisInfo> GetServiceHis(int year)
        {
            List<ServiceHisInfo> result = new List<ServiceHisInfo>();

            sqlStr = "SELECT s.EquipmentID, SUM(s.Income) " +
                    " FROM tblServiceHis s" +
                    " LEFT JOIN tblEquipment e ON e.ID=s.EquipmentID" +
                    " WHERE DATEPART(YEAR,s.TransDate) = @Year And e.DepartmentID NOT IN (4, 9)" +
                    " GROUP BY s.EquipmentID ";
            using (SqlCommand command = DatabaseConnection.GetCommand(sqlStr))
            {
                command.Parameters.Add("@Year", SqlDbType.Int).Value = year;
                using (DataTable dt = GetDataTable(command))
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        result.Add(new ServiceHisInfo() { EquipmentID = SQLUtil.ConvertInt(dr[0]), Income = SQLUtil.ConvertDouble(dr[1])});
                    }

                    return result;
                }
            }
        }

        public int GetMaxRequestID()
        {
            sqlStr = "SELECT Max(ID) FROM tblRequest";

            using (SqlCommand command = DatabaseConnection.GetCommand(sqlStr))
            {
                return SQLUtil.ConvertInt(command.ExecuteScalar());
            }
        }

        public int GetMaxDispatchID()
        {
            sqlStr = "SELECT Max(ID) FROM tblDispatch";

            using (SqlCommand command = DatabaseConnection.GetCommand(sqlStr))
            {
                return SQLUtil.ConvertInt(command.ExecuteScalar());
            }
        }

        public int GetMaxDispatchReportID()
        {
            sqlStr = "SELECT Max(ID) FROM tblDispatchReport";

            using (SqlCommand command = DatabaseConnection.GetCommand(sqlStr))
            {
                return SQLUtil.ConvertInt(command.ExecuteScalar());
            }
        }
    }
}
