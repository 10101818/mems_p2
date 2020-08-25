using DataImport.Domain;
using DataImport.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataImport.Domain
{
    /// <summary>
    /// 耗材info
    /// </summary>
    public class ConsumableInfo : EntityInfo
    { 
        /// <summary>
        /// 富士II类ID
        /// </summary>
        public int FujiClass2ID { get; set; }
        /// <summary>
        /// 耗材名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 耗材描述
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 耗材类型
        /// </summary>
        public int TypeID { get; set; }
        /// <summary>
        /// 标准单价
        /// </summary>
        public double StdPrice { get; set; }
        /// <summary>
        /// 更换频率
        /// </summary>
        public double ReplaceTimes { get; set; }
        /// <summary>
        /// 单次保养耗材成本
        /// </summary>
        public double CostPer { get; set; }
        /// <summary>
        /// 添加日期
        /// </summary>
        public DateTime AddDate { get; set; }
        /// <summary>
        /// 耗材info
        /// </summary>
        public ConsumableInfo() 
        {
        }
        /// <summary>
        /// 耗材info
        /// </summary>
        /// <param name="dr">dr</param>
        public ConsumableInfo(DataRow dr)
            : this()
        {
            this.ID = SQLUtil.ConvertInt(dr["ID"]);
            this.FujiClass2ID = SQLUtil.ConvertInt(dr["FujiClass2ID"]);
            this.Name = SQLUtil.TrimNull(dr["Name"]);
            this.Description = SQLUtil.TrimNull(dr["Description"]);
            this.TypeID = SQLUtil.ConvertInt(dr["TypeID"]);
            this.StdPrice = SQLUtil.ConvertDouble(dr["StdPrice"]);
            this.ReplaceTimes = SQLUtil.ConvertDouble(dr["ReplaceTimes"]);
            this.CostPer = SQLUtil.ConvertDouble(dr["CostPer"]);
            this.AddDate = SQLUtil.ConvertDateTime(dr["AddDate"]);
        }
    }
}
