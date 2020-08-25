using DataImport.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataImport.Domain
{
    public class DispatchInfo : EntityInfo
    {
        public RequestInfo Request { get; set; }
        public KeyValueInfo RequestType { get; set; }
        public KeyValueInfo Urgency { get; set; }
        public KeyValueInfo MachineStatus { get; set; }
        public UserInfo Engineer { get; set; }
        public DateTime ScheduleDate { get; set; }
        public string LeaderComments { get; set; }
        public KeyValueInfo Status { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public DispatchInfo()
        {
            this.Request = new RequestInfo();
            this.RequestType = new KeyValueInfo();
            this.Urgency = new KeyValueInfo();
            this.MachineStatus = new KeyValueInfo();
            this.Engineer = new UserInfo();
            this.Status = new KeyValueInfo();
        }

        public DispatchInfo(DataRow dr)
            : this()
        {
            this.Request.ID = SQLUtil.ConvertInt(dr["RequestID"]);
            this.RequestType.ID = SQLUtil.ConvertInt(dr["RequestType"]);
            this.Urgency.ID = SQLUtil.ConvertInt(dr["EmergencyLevelID"]);
            this.MachineStatus.ID = SQLUtil.ConvertInt(dr["EquipmentStatusID"]);
            this.Engineer.ID = SQLUtil.ConvertInt(dr["EngineerID"]);
            this.ScheduleDate = SQLUtil.ConvertDateTime(dr["ScheduleDate"]);
            this.LeaderComments = SQLUtil.TrimNull(dr["Note"]);
            this.Status.ID = SQLUtil.ConvertInt(dr["DispatchStatusID"]);
            this.CreateDate = SQLUtil.ConvertDateTime(dr["CreateDate"]);
            this.StartDate = SQLUtil.ConvertDateTime(dr["StartDate"]);
            this.EndDate = SQLUtil.ConvertDateTime(dr["EndDate"]);
        } 
    }
}
