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
    /// 零件info
    /// </summary>
    public class ComponentInfo : EntityInfo
    { 
        /// <summary>
        /// 富士II类ID
        /// </summary>
        public int FujiClass2ID { get; set; }
        /// <summary>
        /// 零件名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 零件描述
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 零件类型
        /// </summary>
        public int TypeID { get; set; }
        /// <summary>
        /// 零件标准单价
        /// </summary>
        public double StdPrice { get; set; }
        /// <summary>
        /// 标准使用量
        /// </summary>
        public int Usage { get; set; }
        /// <summary>
        /// CT球管 理论使用寿命
        /// </summary>
        public int TotalSeconds { get; set; }
        /// <summary>
        /// CT球管 秒次/人
        /// </summary>
        public double SecondsPer { get; set; }
        /// <summary>
        /// 添加日期
        /// </summary>
        public DateTime AddDate { get; set; }
        /// <summary>
        /// 零件info
        /// </summary>
        public ComponentInfo() 
        {
        }
        /// <summary>
        /// 零件info
        /// </summary>
        /// <param name="dr">dr</param>
        public ComponentInfo(DataRow dr)
            : this()
        {
            this.ID = SQLUtil.ConvertInt(dr["ID"]);
            this.FujiClass2ID = SQLUtil.ConvertInt(dr["FujiClass2ID"]);
            this.Name = SQLUtil.TrimNull(dr["Name"]);
            this.Description = SQLUtil.TrimNull(dr["Description"]);
            this.TypeID = SQLUtil.ConvertInt(dr["TypeID"]);
            this.StdPrice = SQLUtil.ConvertDouble(dr["StdPrice"]);
            this.Usage = SQLUtil.ConvertInt(dr["Usage"]);
            this.TotalSeconds = SQLUtil.ConvertInt(dr["TotalSeconds"]);
            this.SecondsPer = SQLUtil.ConvertDouble(dr["SecondsPer"]);
            this.AddDate = SQLUtil.ConvertDateTime(dr["AddDate"]);
        }
    }
}
