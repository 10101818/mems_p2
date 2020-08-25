using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataImport.Domain;
using DataImport.Util;

namespace DataImport.Domain
{
    public class RequestInfo : EntityInfo
    {
        public KeyValueInfo Source { get; set; }
        public KeyValueInfo RequestType { get; set; }
        public UserInfo RequestUser { get; set; }
        public String Subject { get; set; }
        public String FaultDesc { get; set; }
        public KeyValueInfo MachineStatus { get; set; }
        public KeyValueInfo FaultType { get; set; }
        public KeyValueInfo Status { get; set; }
        public KeyValueInfo DealType { get; set; }
        public KeyValueInfo Priority { get; set; }
        public DateTime RequestDate { get; set; }
        public DateTime DistributeDate { get; set; }
        public DateTime ResponseDate { get; set; }
        public DateTime CloseDate { get; set; }
        public KeyValueInfo LastStatus { get; set; }
        public Boolean IsRecall { get; set; }
        public DateTime SelectiveDate { get; set; }

        public RequestInfo()
        {
            this.Source = new KeyValueInfo();
            this.RequestType = new KeyValueInfo();
            this.RequestUser = new UserInfo();
            this.MachineStatus = new KeyValueInfo();
            this.FaultType = new KeyValueInfo();
            this.Status = new KeyValueInfo();
            this.DealType = new KeyValueInfo();
            this.Priority = new KeyValueInfo();
            this.LastStatus = new KeyValueInfo();
        }

        public RequestInfo(DataRow dr)
            : this()
        {
            this.Source.ID = SQLUtil.ConvertInt(dr["Category"]);
            this.IsRecall = SQLUtil.ConvertBoolean(dr["IsRecall"]);
            this.RequestType.ID = SQLUtil.ConvertInt(dr["RequestType"]);
            this.RequestUser.ID = SQLUtil.ConvertInt(dr["CustomerID"]);
            this.RequestUser.Name = SQLUtil.TrimNull(dr["CustomerName"]);
            this.RequestUser.Mobile = SQLUtil.TrimNull(dr["CustomerMobile"]);
            this.Subject = SQLUtil.TrimNull(dr["Subject"]);
            this.FaultDesc = SQLUtil.TrimNull(dr["FaultDescription"]);
            this.MachineStatus.ID = SQLUtil.ConvertInt(dr["EquipmentStatusID"]);
            this.FaultType.ID = SQLUtil.ConvertInt(dr["FaultTypeID"]);
            this.Status.ID = SQLUtil.ConvertInt(dr["RequestStatusID"]);
            this.DealType.ID = SQLUtil.ConvertInt(dr["SolutionID"]);
            this.Priority.ID = SQLUtil.ConvertInt(dr["EmergencyLevelID"]);
            this.RequestDate = SQLUtil.ConvertDateTime(dr["RequestDate"]);
            this.DistributeDate = SQLUtil.ConvertDateTime(dr["DistributeDate"]);
            this.ResponseDate = SQLUtil.ConvertDateTime(dr["ResponseDate"]);
            this.CloseDate = SQLUtil.ConvertDateTime(dr["CloseDate"]);
            this.SelectiveDate = SQLUtil.ConvertDateTime(dr["RescheduledDate"]);
        }

        public static class RequestTypes
        {
            public const int Repair = 1;
            public const int Maintain = 2;
            public const int Inspection = 3;
            public const int OnSiteInspection = 4;
            public const int Correcting = 5;
            public const int AddEquipment = 6;
            public const int AdverseEvent = 7;
            public const int ContractArchives = 8;
            public const int Accetance = 9;
            public const int Allocation = 10;
            public const int Borrow = 11;
            public const int Inventory = 12;
            public const int Scrap = 13;
            public const int Others = 14;
        }

    }

    public class RequestEqptInfo : EntityInfo
    {
        public int RequestID { get; set; }
        public int EquipmentID { get; set; }

        public RequestEqptInfo()
        {
        }

        public RequestEqptInfo(DataRow dr)
            : this()
        {
            this.RequestID = SQLUtil.ConvertInt(dr["RequestID"]);
            this.EquipmentID = SQLUtil.ConvertInt(dr["EquipmentID"]);
        }
    }
}
