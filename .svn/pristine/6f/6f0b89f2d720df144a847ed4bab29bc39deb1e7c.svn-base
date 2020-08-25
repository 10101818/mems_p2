using BusinessObjects.Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.Domain
{
    /// <summary>
    /// 用户角色
    /// </summary>
    public static class UserRole
    {
        /// <summary>
        /// 系统管理员
        /// </summary>
        public const int SystemAdmin = 0;
        /// <summary>
        /// 超级管理员
        /// </summary>
        public const int SuperAdmin = 1;
        /// <summary>
        /// 管理员
        /// </summary>
        public const int Admin = 2;
        /// <summary>
        /// 超级用户
        /// </summary>
        public const int SuperUser = 3;
        /// <summary>
        /// 普通用户
        /// </summary>
        public const int User = 4;
    }
    /// <summary>
    /// 编号前缀
    /// </summary>
    public static class ObjectPrefix
    {
        /// <summary>
        /// The notice
        /// </summary>
        public const string Notice = "GB";
        /// <summary>
        /// The custom report
        /// </summary>
        public const string CustomReport = "ZB";
        /// <summary>
        /// 科室前缀
        /// </summary>
        public const string Department = "KS";
    }
    /// <summary>
    /// 附件类型
    /// </summary>
    public static class ObjectTypes
    {
        /// <summary>
        /// The supplier
        /// </summary>
        public const string Supplier = "Supplier";
        /// <summary>
        /// The contract
        /// </summary>
        public const string Contract = "Contract";
        /// <summary>
        /// The equipment
        /// </summary>
        public const string Equipment = "Equipment";
        /// <summary>
        /// The request
        /// </summary>
        public const string Request = "Request";
        /// <summary>
        /// The dispatch
        /// </summary>
        public const string Dispatch = "Dispatch";
        /// <summary>
        /// The dispatch journal
        /// </summary>
        public const string DispatchJournal = "DispatchJournal";
        /// <summary>
        /// The dispatch report
        /// </summary>
        public const string DispatchReport = "DispatchReport";
        /// <summary>
        /// The report accessory
        /// </summary>
        public const string ReportAccessory = "ReportAccessory";
        /// <summary>
        /// The notice
        /// </summary>
        public const string Notice = "Notice";
        /// <summary>
        /// The custom report
        /// </summary>
        public const string CustomReport = "CustomReport";
        /// <summary>
        /// 科室前缀
        /// </summary>
        public const string Department = "Department";
        /// <summary>
        /// 系统日志
        /// </summary>
        public const string SysAuditLog = "SysAuditLog";

        /// <summary>
        /// 根据名称获取文件夹地址
        /// </summary>
        /// <param name="objectName">名称</param>
        /// <returns>文件夹地址</returns>
        public static string GetFileFolder(string objectName)
        {
            switch (objectName)
            {
                case Supplier:
                    return Constants.SupplierFolder;
                case Contract:
                    return Constants.ContractFolder;
                case Equipment:
                    return Constants.EquipmentFolder;
                case Request:
                    return Constants.RequestFolder;
                case DispatchReport:
                    return Constants.DispatchReportFolder;
                case DispatchJournal:
                    return Constants.DispatchJournalFolder;
                case ReportAccessory:
                    return Constants.ReportAccessoryFolder;
                default:
                    return null;
            }
        }
    }

    /// <summary>
    /// 报表维度
    /// </summary>
    public static class ReportDimension	//Report维度
    {
        /// <summary>
        /// 时间类型-年
        /// </summary>
        public const int AcceptanceYear = 1;
        /// <summary>
        /// 时间类型-月
        /// </summary>
        public const int AcceptanceMonth = 2;
        /// <summary>
        /// 设备类型
        /// </summary>
        public const int EquipmentType = 3;
        /// <summary>
        /// 资产价值
        /// </summary>
        public const int AmountType = 4;
        /// <summary>
        /// 使用年限
        /// </summary>
        public const int UsageTimeType = 5;
        /// <summary>
        /// 设备产地
        /// </summary>
        public const int OriginType = 6;
        /// <summary>
        /// 使用科室
        /// </summary>
        public const int DepartmentType = 7;
        /// <summary>
        /// 厂商
        /// </summary>
        public const int ManufacturerType = 8;

        /// <summary>
        /// 获取维度列表
        /// </summary>
        /// <returns>维度列表</returns>
        public static List<KeyValueInfo> GetDimensionList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            KeyValueInfo item1 = new KeyValueInfo();
            list.Add(new KeyValueInfo() { ID = AcceptanceYear, Name = "时间类型-年" });
            list.Add(new KeyValueInfo() { ID = AcceptanceMonth, Name = "时间类型-月" });
            list.Add(new KeyValueInfo() { ID = EquipmentType, Name = "设备类型" });
            list.Add(new KeyValueInfo() { ID = AmountType, Name = "资产价值" });
            list.Add(new KeyValueInfo() { ID = UsageTimeType, Name = "使用年限" });
            list.Add(new KeyValueInfo() { ID = OriginType, Name = "设备产地" });
            list.Add(new KeyValueInfo() { ID = DepartmentType, Name = "使用科室" });
            list.Add(new KeyValueInfo() { ID = ManufacturerType, Name = "厂商" });

            return list;
        }
        /// <summary>
        /// 根据维度编号获取维度名称
        /// </summary>
        /// <param name="id">维度编号</param>
        /// <returns>维度名称</returns>
        public static string GetDimensionDesc(int id)
        {
            switch (id)
            {
                case AcceptanceYear:
                    return "时间类型-年";
                case AcceptanceMonth:
                    return "时间类型-月";
                case EquipmentType:
                    return "设备类型";
                case AmountType:
                    return "资产价值";
                case UsageTimeType:
                    return "使用年限";
                case OriginType:
                    return "设备产地";
                case DepartmentType:
                    return "使用科室";
                case ManufacturerType:
                    return "厂商";
                default:
                    return "";
            }
        }
        
        /// <summary>
        /// 根据维度编号获取维度字段依据
        /// </summary>
        /// <param name="fieldID">维度编号</param>
        /// <returns>维度字段依据</returns>
        public static string GetFieldDesc(int fieldID)
        {
            switch (fieldID)
            {
                case AcceptanceYear:
                    return "";//时间类型返回过多，sql固定字段内容即可
                case AcceptanceMonth:
                    return "";
                case EquipmentType:
                    return "e.EquipmentClass1";
                case AmountType:
                    return "e.PurchaseAmount";
                case UsageTimeType:
                    return "e.AcceptanceDate";
                case OriginType:
                    return "e.IsImport";
                case DepartmentType:
                    return "e.DepartmentID";
                case ManufacturerType:
                    return "e.ManufacturerID";
                default:
                    return "";
            }
        }

        /// <summary>
        /// 根据年份获取月份
        /// </summary>
        /// <param name="year">年份</param>
        /// <returns>月份</returns>
        public static List<KeyValueInfo> GetMonthList(int year)
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            int start = 1;
            int limit = 12;

            if (year == DateTime.Now.Year)//当年数据
                limit = DateTime.Now.Month;//未指定月份，限定当前年当前月
            else
                limit = 12;

            for (int i = start; i <= limit; i++)
            {
                KeyValueInfo item = new KeyValueInfo();

                item.ID = i;
                item.Name = i.ToString();

                list.Add(item);
            }

            return list;
        }
        /// <summary>
        /// 根据起止年份获取年份列表
        /// </summary>
        /// <param name="startYear">起始年份</param>
        /// <param name="endYear">截止年份</param>
        /// <returns>年份列表</returns>
        public static List<KeyValueInfo> GetYearList(int startYear, int endYear = 0)
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            if (endYear == 0) endYear = DateTime.Today.Year;

            for (int i = startYear; i <= endYear; i++)
            {
                KeyValueInfo item = new KeyValueInfo();
                item.ID = i;
                item.Name = i.ToString();
                list.Add(item);
            }

            return list;
        }
        /// <summary>
        /// 获取“设备资产”维度横坐标列表
        /// </summary>
        /// <returns>资产横坐标列表</returns>
        public static List<KeyValueInfo> GetAmountList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() { ID = 0, Name = "100万以下" });
            list.Add(new KeyValueInfo() { ID = 1000000, Name = "100万-500万" });
            list.Add(new KeyValueInfo() { ID = 5000000, Name = "500万以上" });

            return list;
        }
        /// <summary>
        /// 获取资产分类sql
        /// </summary>
        /// <param name="field">资产分类依据字段</param>
        /// <returns>资产分类sql</returns>
        public static string GetAmountSql(string field)
        {
            List<KeyValueInfo> list = GetAmountList();
            StringBuilder amountStr = new StringBuilder(" CASE ");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    amountStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                    amountStr.AppendFormat(" WHEN ({0} <= {1} ) THEN '{2}'", field, list[i+1].ID, list[i].Name);
            }
            return amountStr.ToString();
        }
        /// <summary>
        /// 获取“使用年限”维度横坐标列表
        /// </summary>
        /// <returns>年限横坐标列表</returns>
        public static List<KeyValueInfo> GetUsageTimeList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() { ID = 0, Name = "1年以内" });
            list.Add(new KeyValueInfo() { ID = 12 * 1, Name = "1-3年" });
            list.Add(new KeyValueInfo() { ID = 12 * 3, Name = "3-5年" });
            list.Add(new KeyValueInfo() { ID = 12 * 5, Name = "5年以上" });
            return list;
        }
        /// <summary>
        /// 获取使用年限分类sql
        /// </summary>
        /// <param name="field">使用年限分类依据字段</param>
        /// <param name="year">年份</param>
        /// <returns>使用年限分类sql</returns>
        public static string GetUsageTimeSql(string field, int year = 0)
        {
            List<KeyValueInfo> list = GetUsageTimeList();
            StringBuilder usageTimeStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    usageTimeStr.AppendFormat(" ELSE '{0}'  END", list[i].Name);
                else
                {
                    if (year > 0 && year < DateTime.Today.Year)
                        usageTimeStr.AppendFormat(" WHEN (DATEDIFF(MONTH,{0},'{3}') <= {1} ) THEN '{2}' "
                                        , field, list[i + 1].ID, list[i].Name, string.Format("{0}-12-31", year));
                    else
                        usageTimeStr.AppendFormat(" WHEN (DATEDIFF(MONTH,ISNULL({0},GETDATE()), GETDATE()) <= {1} ) THEN '{2}' "
                                            , field, list[i+1].ID, list[i].Name);
                }
            }
            return usageTimeStr.ToString();
        }

        /// <summary>
        /// 获取响应时间报表横坐标列表
        /// </summary>
        /// <returns>响应时间报表横坐标列表</returns>
        public static List<KeyValueInfo> GetResponseTimeList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() { ID = 0, Name = "0-15 分钟" });
            list.Add(new KeyValueInfo() { ID = 15, Name = "15-30 分钟" });
            list.Add(new KeyValueInfo() { ID = 30, Name = "30-60 分钟" });
            list.Add(new KeyValueInfo() { ID = 60, Name = "60+ 分钟" });

            return list;
        }

        /// <summary>
        /// 获取响应时间报表sql
        /// </summary>
        /// <returns>响应时间报表sql</returns>
        public static string GetResponseTimeSql()
        {
            List<KeyValueInfo> list = GetResponseTimeList();
            StringBuilder sqlStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    sqlStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                {
                    sqlStr.AppendFormat(" WHEN (DATEDIFF(mi,r.RequestDate,r.ResponseDate) <= {0}) THEN '{1}' ", list[i+1].ID, list[i].Name);
                }
            }
            return sqlStr.ToString();
        }

        /// <summary>
        /// 获取故障小时数
        /// </summary>
        public const string SqlRepairTimeHours = "DATEDIFF(HOUR, (CASE WHEN r.RequestDate < @StartDate THEN @StartDate ELSE r.RequestDate END), (CASE WHEN r.CloseDate IS NULL OR r.CloseDate > @EndDate THEN @EndDate ELSE r.CloseDate END))";
        
        /// <summary>
        /// 获取故障分钟数
        /// </summary>
        public const string SqlRepairTimeMinutes = "DATEDIFF(MINUTE, (CASE WHEN r.RequestDate < @StartDate THEN @StartDate ELSE r.RequestDate END), (CASE WHEN r.CloseDate IS NULL OR r.CloseDate > @EndDate THEN @EndDate ELSE r.CloseDate END))";

        /// <summary>
        /// 获取故障时间（天）报表横坐标列表
        /// </summary>
        /// <returns>故障时间（天）报表横坐标列表</returns>
        public static List<KeyValueInfo> GetRepairDaysList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            
            list.Add(new KeyValueInfo() { ID = 0, Name = "1天内" });
            list.Add(new KeyValueInfo() { ID = 1*24, Name = "1-7天" });
            list.Add(new KeyValueInfo() { ID = 7*24, Name = "7-14天" });
            list.Add(new KeyValueInfo() { ID = 14 * 24, Name = "14天以上" });

            return list;
        }
        /// <summary>
        /// 获取故障时间（天）报表分类sql
        /// </summary>
        /// <param name="fieldName">故障时间分类依据字段</param>
        /// <returns>故障时间（天）报表分类sql</returns>
        public static string GetRepairDaysSql(string fieldName)
        {
            List<KeyValueInfo> list = GetRepairDaysList();
            StringBuilder sqlStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    sqlStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                {
                    sqlStr.AppendFormat(" WHEN {0} <= {1} THEN '{2}' ", fieldName, list[i+1].ID, list[i].Name);
                }
            }
            return sqlStr.ToString();
        }
        /// <summary>
        /// 获取故障时间（小时）报表横坐标列表
        /// </summary>
        /// <returns>故障时间（小时）报表横坐标列表</returns>
        public static List<KeyValueInfo> GetRepairHoursList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() { ID = 0, Name = "1小时内" });
            list.Add(new KeyValueInfo() { ID = 1 * 60, Name = "1-24小时" });
            list.Add(new KeyValueInfo() { ID = 24 * 60, Name = "24-48小时" });
            list.Add(new KeyValueInfo() { ID = 48 * 60, Name = "48小时以上" });

            return list;
        }
        /// <summary>
        /// 获取故障时间（小时）报表分类sql
        /// </summary>
        /// <param name="fieldName">故障时间分类依据字段</param>
        /// <returns>故障时间（小时）报表分类sql</returns>
        public static string GetRepairHoursSql(string fieldName)
        {
            List<KeyValueInfo> list = GetRepairHoursList();
            StringBuilder sqlStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    sqlStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                {
                    sqlStr.AppendFormat(" WHEN {0} <= {1} THEN '{2}' ", fieldName, list[i+1].ID, list[i].Name);
                }
            }
            return sqlStr.ToString();
        }
        /// <summary>
        /// 获取合同金额报表横坐标列表
        /// </summary>
        /// <returns>合同金额报表横坐标列表</returns>
        public static List<KeyValueInfo> GetContractAmountList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() { ID = 0, Name = "10万以下" });
            list.Add(new KeyValueInfo() { ID = 10 * 10000, Name = "10万-30万" });
            list.Add(new KeyValueInfo() { ID = 30 * 10000, Name = "30万以上" });

            return list;
        }
        /// <summary>
        /// 获取合同金额分类sql
        /// </summary>
        /// <param name="fieldName">合同金额分类依据字段</param>
        /// <returns>合同金额分类sql</returns>
        public static string GetContractAmountSql(string fieldName)
        {
            List<KeyValueInfo> list = GetContractAmountList();
            StringBuilder sqlStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    sqlStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                {
                    sqlStr.AppendFormat(" WHEN {0} <= {1} THEN '{2}' ", fieldName, list[i + 1].ID, list[i].Name);
                }
            }
            return sqlStr.ToString();
        }
        /// <summary>
        /// 获取合同年限报表横坐标列表
        /// </summary>
        /// <returns>合同年限报表横坐标列表</returns>
        public static List<KeyValueInfo> GetContractMonthList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() {ID = 0, Name = "0-1个月"});
            list.Add(new KeyValueInfo() {ID = 1, Name = "1-3月"});
            list.Add(new KeyValueInfo() {ID = 3, Name = "3-6月"});
            list.Add(new KeyValueInfo() {ID = 6, Name = "6-9个月"});
            list.Add(new KeyValueInfo() {ID = 9, Name = "9-12个月"});
            list.Add(new KeyValueInfo() {ID = 12, Name = "12月以上"});

            return list;
        }
        /// <summary>
        /// 获取合同年限报表分类sql
        /// </summary>
        /// <param name="fieldName">合同年限分类依据字段</param>
        /// <returns>合同年限报表分类sql</returns>
        public static string GetContractMonthSql(string fieldName)
        {
            List<KeyValueInfo> list = GetContractMonthList();
            StringBuilder sqlStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    sqlStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                {
                    sqlStr.AppendFormat(" WHEN {0} <= {1} THEN '{2}' ", fieldName, list[i + 1].ID, list[i].Name);
                }
            }
            return sqlStr.ToString();
        }

        /// <summary>
        /// 获取折旧剩余年限报表横坐标列表
        /// </summary>
        /// <returns>折旧剩余年限报表横坐标列表</returns>
        public static List<KeyValueInfo> GetDepreciationYearsList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() { ID = 0, Name = "1年内" });
            list.Add(new KeyValueInfo() { ID = 1*12, Name = "1-5年" });
            list.Add(new KeyValueInfo() { ID = 5*12, Name = "5年以上" });

            return list;
        }

        /// <summary>
        /// 获取折旧年限分类sql
        /// </summary>
        /// <param name="reportDateField">折旧年限分类依据字段</param>
        /// <returns>折旧年限分类sql</returns>
        public static string GetDepreciationYearsSql(string reportDateField)
        {
            List<KeyValueInfo> list = GetDepreciationYearsList();
            StringBuilder sqlStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    sqlStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                {
                    sqlStr.AppendFormat(" WHEN e.DepreciationYears * 12 - DATEDIFF(MONTH,e.AcceptanceDate, {0}) <= {1} THEN '{2}' ", reportDateField, list[i + 1].ID, list[i].Name);
                }
            }
            return sqlStr.ToString();
        }
        /// <summary>
        /// 获取设备折旧率报表横坐标
        /// </summary>
        /// <returns>设备折旧率报表横坐标</returns>
        public static List<KeyValueInfo> GetDepreciationRationList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() { ID = 0, Name = "10%以下" });
            list.Add(new KeyValueInfo() { ID = 10, Name = "10%-30%" });
            list.Add(new KeyValueInfo() { ID = 30, Name = "30%-60%" });
            list.Add(new KeyValueInfo() { ID = 60, Name = "60%-100%" });
            list.Add(new KeyValueInfo() { ID = 100, Name = "100%以上" });

            return list;
        }
        /// <summary>
        /// 获取设备折旧率报表分类sql
        /// </summary>
        /// <param name="reportDateField">日期字段</param>
        /// <returns>设备折旧率报表分类sql</returns>
        public static string GetDepreciationRationSql(string reportDateField)
        {
            List<KeyValueInfo> list = GetDepreciationRationList();
            StringBuilder sqlStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    sqlStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                {
                    sqlStr.AppendFormat(" WHEN (DATEDIFF(MONTH,e.AcceptanceDate, {0}) * 100.0 / e.DepreciationYears / 12) <= {1} THEN '{2}' ", reportDateField, list[i + 1].ID, list[i].Name);
                }
            }
            return sqlStr.ToString();
        }
        /// <summary>
        /// 获取派工响应时间报表横坐标列表
        /// </summary>
        /// <returns>派工响应时间报表横坐标列表</returns>
        public static List<KeyValueInfo> GetDispatchResponseTimeList()
        {
            List<KeyValueInfo> list = new List<KeyValueInfo>();
            list.Add(new KeyValueInfo() { ID = 0, Name = "0-15分钟" });
            list.Add(new KeyValueInfo() { ID = 15, Name = "15-30分钟" });
            list.Add(new KeyValueInfo() { ID = 30, Name = "30-60分钟" });
            list.Add(new KeyValueInfo() { ID = 60, Name = "60分钟以上" });
            list.Add(new KeyValueInfo() { ID =  Int32.MaxValue, Name = "未响应" });

            return list;
        }
        /// <summary>
        /// 获取派工响应时间分类sql
        /// </summary>
        /// <returns>派工响应时间分类sql</returns>
        public static string GetDispatchResponseTimeSql()
        {
            List<KeyValueInfo> list = GetDispatchResponseTimeList();
            StringBuilder sqlStr = new StringBuilder(" CASE");
            for (int i = 0; i <= list.Count - 1; i++)
            {
                if (i == list.Count - 1)
                    sqlStr.AppendFormat(" ELSE '{0}' END", list[i].Name);
                else
                {
                    sqlStr.AppendFormat(" WHEN d.StartDate IS NOT NULL AND DATEDIFF(MINUTE,d.CreateDate, d.StartDate) <= {0} THEN '{1}' ", list[i + 1].ID, list[i].Name);
                }
            }
            return sqlStr.ToString();
        }
        

    }
}
