using BusinessObjects.Manager;
using BusinessObjects.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace BusinessObjects.Domain
{
    /// <summary>
    /// 日志信息
    /// </summary>
    public class AuditHdrInfo : EntityInfo
    {
        /// <summary>
        /// 操作用户
        /// </summary>
        public UserInfo TransUser { get; set; }
        /// <summary>
        /// 操作日期
        /// </summary>
        public DateTime UpdateDate { get; set; }
        /// <summary>
        /// 操作对象类型
        /// </summary>
        public KeyValueInfo ObjectType { get; set; }
        /// <summary>
        /// 操作类型
        /// </summary>
        public KeyValueInfo Operation { get; set; }
        /// <summary>
        /// 操作对象id
        /// </summary>
        public int ObjectID { get; set; }
        /// <summary>
        /// 操作对象系统编号
        /// </summary>
        public string ObjectOID { get; set; }
        /// <summary>
        /// 日志系统编号
        /// </summary>
        public string OID { get { return EntityInfo.GenerateOID(ObjectTypes.SysAuditLog, this.ID); } }

        public List<AuditDetailInfo> DetailInfo { get; set; }

        /// <summary>
        /// 日志信息
        /// </summary>
        public AuditHdrInfo()
        {
            this.TransUser = new UserInfo();
            this.ObjectType = new KeyValueInfo();
            this.DetailInfo = new List<AuditDetailInfo>();
            this.Operation = new KeyValueInfo();
        }

        /// <summary>
        /// 获取日志信息
        /// </summary>
        /// <param name="dr">The dr.</param>
        public AuditHdrInfo(DataRow dr)
            : this()
        {
            this.ID = SQLUtil.ConvertInt(dr["ID"]);
            this.TransUser.ID = SQLUtil.ConvertInt(dr["UserID"]);
            this.TransUser.LoginID = SQLUtil.TrimNull(dr["LoginID"]);
            this.TransUser.Name = SQLUtil.TrimNull(dr["Name"]);
            this.TransUser.Role.ID = SQLUtil.ConvertInt(dr["RoleID"]);
            this.TransUser.Role.Name = Manager.LookupManager.GetRoleDesc(this.TransUser.Role.ID);
            this.UpdateDate = SQLUtil.ConvertDateTime(dr["UpdateDate"]);
            this.ObjectType.ID = SQLUtil.ConvertInt(dr["ObjectTypeID"]);
            this.ObjectType.Name = AuditObjectTypes.GetObjectTypeName(this.ObjectType.ID);
            this.ObjectID = SQLUtil.ConvertInt(dr["ObjectID"]);
            this.ObjectOID = EntityInfo.GenerateOID(AuditObjectTypes.GetObjectName(this.ObjectType.ID), this.ObjectID);
            this.Operation.ID = SQLUtil.ConvertInt(dr["Operation"]);
            this.Operation.Name = AuditOperations.GetOperationName(this.Operation.ID);
        }

        /// <summary>
        /// 操作对象
        /// </summary>
        public class AuditObjectTypes
        {
            /// <summary>
            /// 设备
            /// </summary>
            public const int Equipment = 1;
            /// <summary>
            /// 合同
            /// </summary>
            public const int Contract = 2;
            /// <summary>
            /// 供应商
            /// </summary>
            public const int Supplier = 3;

            public const int Component = 4;

            public const int Consumable = 5;

            /// <summary>
            /// 获取系统日志类型
            /// </summary>
            /// <returns>系统日志类型</returns>
            public static List<KeyValueInfo> GetObjectTypes()
            {
                List<KeyValueInfo> statuses = new List<KeyValueInfo>();
                statuses.Add(new KeyValueInfo() { ID = AuditObjectTypes.Equipment, Name = GetObjectTypeName(AuditObjectTypes.Equipment) });
                statuses.Add(new KeyValueInfo() { ID = AuditObjectTypes.Contract, Name = GetObjectTypeName(AuditObjectTypes.Contract) });
                statuses.Add(new KeyValueInfo() { ID = AuditObjectTypes.Supplier, Name = GetObjectTypeName(AuditObjectTypes.Supplier) });
                statuses.Add(new KeyValueInfo() { ID = AuditObjectTypes.Component, Name = GetObjectTypeName(AuditObjectTypes.Component) });
                statuses.Add(new KeyValueInfo() { ID = AuditObjectTypes.Consumable, Name = GetObjectTypeName(AuditObjectTypes.Consumable) });
                return statuses;
            }
            /// <summary>
            /// 获取操作对象
            /// </summary>
            /// <param name="objectTypeID">操作对象id</param>
            /// <returns>操作对象描述</returns>
            public static string GetObjectTypeName(int objectTypeID)
            {
                switch (objectTypeID)
                {
                    case Equipment:
                        return "设备";
                    case Contract:
                        return "合同";
                    case Supplier:
                        return "供应商";
                    case Component:
                        return "零件";
                    case Consumable:
                        return "耗材";
                    default:
                        return "";
                }
            }

            /// <summary>
            /// 获取操作对象名称
            /// </summary>
            /// <param name="objectTypeID">操作对象id</param>
            /// <returns>操作对象名称</returns>
            public static string GetObjectName(int objectTypeID)
            {
                switch (objectTypeID)
                {
                    case Equipment:
                        return ObjectTypes.Equipment;
                    case Contract:
                        return ObjectTypes.Contract;
                    case Supplier:
                        return ObjectTypes.Supplier;
                    default:
                        return "";
                }
            }
        }

        /// <summary>
        /// 操作类型
        /// </summary>
        public class AuditOperations
        {
            /// <summary>
            /// 新增
            /// </summary>
            public const int Add = 1;
            /// <summary>
            /// 编辑
            /// </summary>
            public const int Update = 2;

            /// <summary>
            /// 获取系统日志类型
            /// </summary>
            /// <returns>合同状态信息</returns>
            public static List<KeyValueInfo> GetOperationTypes()
            {
                List<KeyValueInfo> statuses = new List<KeyValueInfo>();
                statuses.Add(new KeyValueInfo() { ID = AuditOperations.Add, Name = GetOperationName(AuditOperations.Add) });
                statuses.Add(new KeyValueInfo() { ID = AuditOperations.Update, Name = GetOperationName(AuditOperations.Update) });
                return statuses;
            }
            /// <summary>
            /// 获取操作对象
            /// </summary>
            /// <param name="objectTypeID">操作对象id</param>
            /// <returns>操作对象描述</returns>
            public static string GetOperationName(int objectTypeID)
            {
                switch (objectTypeID)
                {
                    case Add:
                        return "新增";
                    case Update:
                        return "编辑";
                    default:
                        return "";
                }
            }
        }

    }
}
