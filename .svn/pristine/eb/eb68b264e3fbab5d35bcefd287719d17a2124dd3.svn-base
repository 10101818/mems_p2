using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataImport.Domain;
using DataImport.Util;

namespace DataImport.Domain
{
    public class DispatchReportInfo:EntityInfo
    {
        public int DispatchID { get; set; }				
        public KeyValueInfo Type  { get; set; }					
        public string FaultCode  { get; set; }		
        public string FaultDesc  { get; set; }		
        public string SolutionCauseAnalysis  { get; set; }
        public string SolutionWay  { get; set; }
        public bool IsPrivate { get; set; }
        public KeyValueInfo ServiceProvider { get; set; }
        public KeyValueInfo SolutionResultStatus { get; set; }
        public string SolutionUnsolvedComments { get; set; }
        public string DelayReason  { get; set; }
        public string Comments { get; set; }	
        public string FujiComments  { get; set; }
        public KeyValueInfo Status { get; set; }

        public DispatchReportInfo()
        {
            this.Type = new KeyValueInfo();
            this.SolutionResultStatus = new KeyValueInfo();
            this.ServiceProvider = new KeyValueInfo();
            this.Status = new KeyValueInfo();
        }

        public DispatchReportInfo(DataRow dr)
            :this()
        {
            this.DispatchID = SQLUtil.ConvertInt(dr["DispatchID"]);
            this.Type.ID = SQLUtil.ConvertInt(dr["ReportTypeID"]);
            this.FaultCode = SQLUtil.TrimNull(dr["ErrorCode"]);
            this.FaultDesc = SQLUtil.TrimNull(dr["FaultDescription"]);
            this.SolutionCauseAnalysis = SQLUtil.TrimNull(dr["Reason"]);
            this.SolutionWay = SQLUtil.TrimNull(dr["Solution"]);
            this.IsPrivate = SQLUtil.ConvertBoolean(dr["SpecialFormat"]);
            this.ServiceProvider.ID = SQLUtil.ConvertInt(dr["ServiceProvider"]);
            this.SolutionResultStatus.ID = SQLUtil.ConvertInt(dr["WorkSummaryID"]);
            this.SolutionUnsolvedComments = SQLUtil.TrimNull(dr["ProblemEscalation"]);
            this.DelayReason = SQLUtil.TrimNull(dr["MissedworkNote"]);
            this.Comments = SQLUtil.TrimNull(dr["Note"]);
            this.FujiComments = SQLUtil.TrimNull(dr["ReviewNote"]);
            this.Status.ID = SQLUtil.ConvertInt(dr["ServiceReportStatusID"]);
        }
    }

    public class ReportAccessoryInfo : EntityInfo
    {
        public int DispatchReportID { get; set; }
        public string Name { get; set; }
        public KeyValueInfo Source { get; set; }
        public int SupplierID { get; set; }
        public string NewSerialCode { get; set; }
        public string OldSerialCode { get; set; }
        public int Qty { get; set; }
        public double Amount { get; set; }


        public ReportAccessoryInfo()
        {
            this.Source = new KeyValueInfo();
        }

        public ReportAccessoryInfo(DataRow dr)
            : this()
        {
            this.DispatchReportID = SQLUtil.ConvertInt(dr["ServiceReportID"]);
            this.Name = SQLUtil.TrimNull(dr["Name"]);
            this.Source.ID = SQLUtil.ConvertInt(dr["Category"]);
            this.SupplierID = SQLUtil.ConvertInt(dr["SupplierID"]);
            this.NewSerialCode = SQLUtil.TrimNull(dr["New No#"]);
            this.OldSerialCode = SQLUtil.TrimNull(dr["Detach No#"]);
            this.Qty = SQLUtil.ConvertInt(dr["Quantity"]);
            this.Amount = SQLUtil.ConvertDouble(dr["NewPrice"]);
        } 
    }
}
