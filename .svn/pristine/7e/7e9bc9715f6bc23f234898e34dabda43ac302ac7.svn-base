using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BusinessObjects.Util;
using BusinessObjects.Manager;

namespace BusinessObjects.Domain
{
    /// <summary>
    /// 重写方法
    /// </summary>
    public class EntityInfo
    {
        /// <summary>
        /// id
        /// </summary>
        /// <value>
        /// The identifier.
        /// </value>
        public int ID { get; set; }

        /// <summary>
        /// 重写equals方法
        /// </summary>
        /// <param name="obj">传入值</param>
        /// <returns>是否相等</returns>
        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }

            if (this.ID == ((EntityInfo)obj).ID)
                return true;
            else
                return false;
        }
        /// <summary>
        /// 重写GetHashCode方法
        /// </summary>
        /// <returns>GetHashCode</returns>
        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        public object Clone()
        {
            return this.MemberwiseClone();
        }

        /// <summary>
        /// 获取系统编号
        /// </summary>
        /// <param name="objectName">类型</param>
        /// <param name="id">id</param>
        /// <returns>系统编号</returns>
        public static string GenerateOID(string objectName, int id)
        {
            int leadingZeros = 0;

            string prefix = null;
            switch (objectName)
            {
                case ObjectTypes.Equipment:
                    prefix = "ZC";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.Contract:
                    prefix = "HT";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.Supplier:
                    prefix = "GYS";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.Request:
                    prefix = "C";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.Dispatch:
                    prefix = "PGD";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.DispatchJournal:
                    prefix = "FWPZ";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.DispatchReport:
                    prefix = "ZYBG";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.ReportAccessory:
                    prefix = "LPJ";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.CustomReport:
                    prefix = "ZB";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.Notice:
                    prefix = "GB";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.Department:
                    prefix = "KS";
                    leadingZeros = 8;
                    break;
                case ObjectTypes.SysAuditLog:
                    prefix = "XTRZ";
                    leadingZeros = 8;
                    break;
                default:
                    return null;
            }

            
            return string.Format("{0}{1}", prefix, id.ToString("D" + leadingZeros));
        }
    }

    /// <summary>
    /// 定义KeyValueInfo类型数据
    /// </summary>
    public class KeyValueInfo
    {
        /// <summary>
        /// key
        /// </summary>
        /// <value>
        /// The identifier.
        /// </value>
        public int ID { get; set; }
        /// <summary>
        /// value
        /// </summary>
        /// <value>
        /// The name.
        /// </value>
        public string Name { get; set; }
    }
    /// <summary>
    /// 定义文件流信息
    /// </summary>
    public class FileStreamInfo
    {
        /// <summary>
        /// key
        /// </summary>
        /// <value>
        /// The name of the file.
        /// </value>
        public string FileName { get; set; }
        /// <summary>
        /// value
        /// </summary>
        /// <value>
        /// The stream.
        /// </value>
        public Stream Stream { get; set; }
    }

    /// <summary>
    /// 文件信息
    /// </summary>
    public class UploadFileInfo : EntityInfo
    {
        /// <summary>
        /// 文件编号
        /// </summary>
        /// <value>
        /// The object identifier.
        /// </value>
        public int ObjectID { get; set; }
        /// <summary>
        /// 文件名称
        /// </summary>
        /// <value>
        /// The name of the file.
        /// </value>
        public string FileName { get; set; }
        /// <summary>
        /// 文件类型
        /// </summary>
        /// <value>
        /// The type of the file.
        /// </value>
        public int FileType { get; set; }
        /// <summary>
        /// 文件描述
        /// </summary>
        /// <value>
        /// The file desc.
        /// </value>
        public string FileDesc { get; set; }
        /// <summary>
        /// Gets or sets the add date.
        /// </summary>
        /// <value>
        /// The add date.
        /// </value>
        public DateTime AddDate { get; set; }
        /// <summary>
        /// Gets or sets the name of the object.
        /// </summary>
        /// <value>
        /// The name of the object.
        /// </value>
        public string ObjectName { get; set; }
        /// <summary>
        /// Gets or sets the content of the file.
        /// </summary>
        /// <value>
        /// The content of the file.
        /// </value>
        public string FileContent { get; set; }

        private int Seq { get; set; }

        /// <summary>
        /// 文件信息
        /// </summary>
        public UploadFileInfo() { }
        /// <summary>
        /// 获取文件信息
        /// </summary>
        /// <param name="dr">The dr.</param>
        public UploadFileInfo(DataRow dr)
        {
            this.ID = SQLUtil.ConvertInt(dr["ID"]);
            this.ObjectName = SQLUtil.TrimNull(dr["ObjectName"]);
            this.ObjectID = SQLUtil.ConvertInt(dr["ObjectID"]);
            this.FileName = SQLUtil.TrimNull(dr["FileName"]);
            this.FileDesc = SQLUtil.TrimNull(dr["FileDesc"]);
            this.FileType = SQLUtil.ConvertInt(dr["FileType"]);
            this.AddDate = SQLUtil.ConvertDateTime(dr["AddDate"]);
            this.Seq = SQLUtil.ConvertInt(dr["Seq"]);

            SetDisplayFileName();
        }

        private void SetDisplayFileName()
        {
            string name = GetDisplayFileName();

            if(name != "") this.FileName = name + new FileInfo(this.FileName).Extension;
        }

        /// <summary>
        /// 获取显示的文件名称
        /// </summary>
        /// <returns>文件名称</returns>
        public string GetDisplayFileName()
        {
            string name = "";

            switch(this.ObjectName)
            {
                case ObjectTypes.Equipment:
                    name = EquipmentInfo.FileTypes.GetFileName(this.FileType);
                    break;
               //case ObjectTypes.Contract:
               //    name = ContractInfo.FileTypes.GetFileName(this.FileType);
               //    break;
               //case ObjectTypes.Supplier:
               //    name = SupplierInfo.FileTypes.GetFileName(this.FileType);
               //    break;
                case ObjectTypes.Request:
                    name = string.Format("{0}_{1}", RequestInfo.FileTypes.GetFileName(this.FileType), this.Seq);
                    break;
                case ObjectTypes.DispatchReport:
                    name = DispatchReportInfo.FileTypes.GetFileName(this.FileType);
                    break;
                case ObjectTypes.ReportAccessory:
                    name = ReportAccessoryInfo.FileTypes.GetFileName(this.FileType);
                    break;
                default:
                    break;
            }

            return name;
        }

        /// <summary>
        /// 获取文件名称
        /// </summary>
        /// <returns>文件名称</returns>
        public string GetFileName()
        {
            return string.Format("{0}_{1}{2}", this.ObjectID, this.ID, new FileInfo(this.FileName).Extension);
        }
    }

    /// <summary>
    /// 流程信息
    /// </summary>
    public class HistoryInfo : EntityInfo
    {
        /// <summary>
        /// The object.
        /// </summary>
        /// <value>
        /// The object.
        /// </value>
        public KeyValueInfo Object { get; set; }
        /// <summary>
        /// 用户信息
        /// </summary>
        /// <value>
        /// The operator.
        /// </value>
        public UserInfo Operator { get; set; }
        /// <summary>
        /// 操作
        /// </summary>
        /// <value>
        /// The action.
        /// </value>
        public KeyValueInfo Action { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        /// <value>
        /// The comments.
        /// </value>
        public string Comments { get; set; }
        /// <summary>
        /// 日期
        /// </summary>
        /// <value>
        /// The trans date.
        /// </value>
        public DateTime TransDate { get; set; }

        /// <summary>
        /// 获取流程信息
        /// </summary>
        public string VerifyHistory { get { return string.Format("{0} {1} - {2}: {3}{4}", TransDate.ToString("yyyy-MM-dd HH:mm:ss"), Operator.Role.Name == "" ? "计划服务" : Operator.Role.Name, Operator.Name == "" ? "系统" : Operator.Name, Action.Name, (Comments == "" ? "" : " - " + Comments)); } }
        /// <summary>
        /// 历史信息
        /// </summary>
        public HistoryInfo()
        {
            this.Object = new KeyValueInfo();
            this.Operator = new UserInfo();
            this.Action = new KeyValueInfo();
        }

        /// <summary>
        /// 历史信息
        /// </summary>
        /// <param name="dr">The dr.</param>
        public HistoryInfo(DataRow dr)
            : this()
        {
            this.ID = SQLUtil.ConvertInt(dr["ID"]);
            this.Object.ID = SQLUtil.ConvertInt(dr["ObjectID"]);
            this.Operator.ID = SQLUtil.ConvertInt(dr["OperatorID"]);
            this.Operator.Name = this.Operator.ID == 0 ? "" : SQLUtil.TrimNull(dr["OperatorName"]);
            this.Operator.Role.ID = SQLUtil.ConvertInt(dr["OperatorRoleID"]);
            this.Operator.Role.Name = this.Operator.Role.ID==0?"":LookupManager.GetRoleDesc(this.Operator.Role.ID);
            this.Action.ID = SQLUtil.ConvertInt(dr["Action"]);
            this.Comments = SQLUtil.TrimNull(dr["Comments"]);
            this.TransDate = SQLUtil.ConvertDateTime(dr["TransDate"]);
        }

        /// <summary>
        /// 历史信息
        /// </summary>
        /// <param name="objectID">The object identifier.</param>
        /// <param name="objectName">Name of the object.</param>
        /// <param name="operatorID">角色编号</param>
        /// <param name="actionID">操作</param>
        /// <param name="comments">备注</param>
        public HistoryInfo(int objectID, string objectName, int operatorID, int actionID, string comments = "")
            : this()
        {
            this.Object.ID = objectID;
            this.Object.Name = objectName;
            this.Operator.ID = operatorID;
            this.Action.ID = actionID;
            this.Comments = comments;
        }

        /// <summary>
        /// 历史信息
        /// </summary>
        /// <param name="objectID">The object identifier.</param>
        /// <param name="objectName">Name of the object.</param>
        /// <param name="operatorID">角色编号</param>
        /// <param name="comments">备注</param>
        public HistoryInfo(int objectID, string objectName, int operatorID, string comments = "")
            : this()
        {
            this.Object.ID = objectID;
            this.Object.Name = objectName;
            this.Operator.ID = operatorID;
            this.Comments = comments;
        }
    }
}
