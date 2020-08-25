using DataImport.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataImport.Domain
{
    public class SupplierInfo:EntityInfo
    { 
        public KeyValueInfo SupplierType { get; set; }
	    public string Name { get; set;}  
	    public string Province  { get; set;} 
	    public string Mobile  { get; set;} 
	    public string Address  { get; set;} 
	    public string Contact  { get; set;} 
	    public string ContactMobile  { get; set;}
	    public DateTime AddDate  { get; set;}
        public bool IsActive { get; set; }

        public SupplierInfo()
        {
            this.SupplierType = new KeyValueInfo();
        }

        public SupplierInfo(DataRow dr)
            :this()
        {
            this.SupplierType.ID = SQLUtil.ConvertInt(dr["TypeID"]);
            this.Name = SQLUtil.TrimNull(dr["Name"]);
            this.Province = SQLUtil.TrimNull(dr["State/City"]);
            this.Mobile = SQLUtil.TrimNull(dr["Phone"]);
            this.Address = SQLUtil.TrimNull(dr["Address"]);
            this.Contact = SQLUtil.TrimNull(dr["ContactPerson"]);
            this.ContactMobile = SQLUtil.TrimNull(dr["ContactPhone"]);
            this.AddDate = SQLUtil.ConvertDateTime(dr["AddDate"]);
            this.IsActive = SQLUtil.ConvertBoolean(dr["Status"]);
        }
    }
}
