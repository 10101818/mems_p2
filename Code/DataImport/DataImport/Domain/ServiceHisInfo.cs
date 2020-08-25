using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using DataImport.Util;

namespace DataImport.Domain
{
    public class ServiceHisInfo : EntityInfo
    {
        public int EquipmentID { get; set; }
        public DateTime TransDate { get; set; }
        public double Income { get; set; }

        public ServiceHisInfo()
        {
        }

        public ServiceHisInfo(DataRow dr)
            :this()
        {
            this.EquipmentID = SQLUtil.ConvertInt(dr["EquipmentID"]);
            this.TransDate = SQLUtil.ConvertDateTime(dr["TransDate"]);
            this.Income = SQLUtil.ConvertDouble(dr["Income"]);
        }
    }
}