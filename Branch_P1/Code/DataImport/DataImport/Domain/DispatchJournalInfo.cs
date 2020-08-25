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
    public class DispatchJournalInfo : EntityInfo
    {
        public int DispatchID { get; set; }
        public string FaultCode { get; set; }
        public string JobContent { get; set; }
        public KeyValueInfo ResultStatus { get; set; }
        public string FollowProblem { get; set; }
        public string UnconfirmedProblem { get; set; }
        public string Advice { get; set; }
        public string UserName { get; set; }
        public string UserMobile { get; set; }
        public bool Signed { get; set; }
        public string FileContent { get; set; }
        public string FujiComments { get; set; }
        public KeyValueInfo Status { get; set; }

        public DispatchJournalInfo()
        {
            this.Status = new KeyValueInfo();
            this.ResultStatus = new KeyValueInfo();
        }

        public DispatchJournalInfo(DataRow dr)
            :this()
        {
            this.DispatchID = SQLUtil.ConvertInt(dr["DispatchID"]);
            this.FaultCode = SQLUtil.TrimNull(dr["FaultDescription/ErrorCode/Reason"]);
            this.JobContent = SQLUtil.TrimNull(dr["WorkContent"]);
            this.FollowProblem = SQLUtil.TrimNull(dr["FollowUpItem"]);
            this.Advice = SQLUtil.TrimNull(dr["Suggestion"]);
            this.UserName = SQLUtil.TrimNull(dr["UserName"]);
            this.UserMobile = SQLUtil.TrimNull(dr["UserMobile"]);
            this.Status.ID = SQLUtil.ConvertInt(dr["VoucherStatusID"]);
            this.ResultStatus.ID = SQLUtil.ConvertInt(dr["ServiceSummaryID"]);
        }
    }
}
