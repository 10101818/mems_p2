using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using BusinessObjects.Aspect;
using BusinessObjects.Domain;
using BusinessObjects.Util;
using PostSharp.Extensibility;

namespace BusinessObjects.DataAccess
{
    /// <summary>
    /// LookupDao
    /// </summary>
    [LoggingAspect(AspectPriority = 1)]
    [ConnectionAspect(AspectPriority = 2, AttributeTargetTypeAttributes = MulticastAttributes.Public)]
    public class LookupDao : BaseDao
    {
        /// <summary>
        /// 根据表名获取数据库信息
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <returns>数据库信息</returns>
        public List<KeyValueInfo> GetLookups(string tableName)
        {
            List<KeyValueInfo> infos = new List<KeyValueInfo>();

            sqlStr = string.Format("SELECT * FROM {0} ORDER BY ID", tableName);

            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                using (DataTable dt = GetDataTable(command))
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        infos.Add(new KeyValueInfo() { ID = SQLUtil.ConvertInt(dr["ID"]), Name = SQLUtil.TrimNull(dr["Description"]) });
                    }
                }
            }

            return infos;
        }
        /// <summary>
        /// 获取设备类别信息
        /// </summary>
        /// <returns>设备类别信息</returns>
        public List<EquipmentClassInfo> GetEquipmentClasses()
        {
            List<EquipmentClassInfo> infos = new List<EquipmentClassInfo>();

            sqlStr = "SELECT * FROM lkpEquipmentClass";

            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                using (DataTable dt = GetDataTable(command))
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        infos.Add(new EquipmentClassInfo(dr));
                    }
                }
            }

            return infos;
        }
    }
}
