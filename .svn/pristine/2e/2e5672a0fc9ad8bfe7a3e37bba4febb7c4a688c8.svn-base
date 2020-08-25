using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataImport.Util;

namespace DataImport.Domain
{
    public class ContractInfo:EntityInfo
    {
        public int SupplierID { get; set; }
        public string ContractNum { get; set; }
        public string Name { get; set; }
        public KeyValueInfo Type { get; set; }
        public KeyValueInfo Scope { get; set; }
        public string ScopeComments { get; set; }
        public double Amount { get; set; }
        public string ProjectNum { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Comments { get; set; }

        public ContractInfo()
        {
            this.Type = new KeyValueInfo();
            this.Scope = new KeyValueInfo();

        }

        public ContractInfo(DataRow dr)
            :this()
        {
            this.ContractNum = SQLUtil.TrimNull(dr["Number"]);
            this.Name = SQLUtil.TrimNull(dr["Name"]);
            this.Type.ID = SQLUtil.ConvertInt(dr["TypeID"]);
            this.Scope.ID = SQLUtil.ConvertInt(dr["ServiceScopeID"]);
            this.ScopeComments = SQLUtil.TrimNull(dr["ScopeComments"]);
            this.Amount = SQLUtil.ConvertDouble(dr["Amount"]);
            this.ProjectNum = SQLUtil.TrimNull(dr["ProjectNum"]);
            this.StartDate = SQLUtil.ConvertDateTime(dr["StartDate"]);
            this.EndDate = SQLUtil.ConvertDateTime(dr["EndDate"]);
            this.Comments = SQLUtil.TrimNull(dr["Note"]);      
            this.SupplierID = SQLUtil.ConvertInt(dr["SupplierID"]);
        }
    }

    public class ContractEqptInfo : EntityInfo
    {
        public int ContractID { get; set; }
        public int EquipmentID { get; set; }

        public ContractEqptInfo(){ }

        public ContractEqptInfo(DataRow dr)
            : this()
        {
            this.ContractID = SQLUtil.ConvertInt(dr["ContractID"]);
            this.EquipmentID = SQLUtil.ConvertInt(dr["EquipmentID"]);
        }
    }
}
