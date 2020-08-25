﻿using DataImport.Domain;
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
    /// 富士I类info
    /// </summary>
    public class FujiClass1Info : EntityInfo
    {
        /// <summary>
        /// 富士I类名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 添加日期
        /// </summary>
        public DateTime AddDate { get; set; }

        /// <summary>
        /// 富士I类info
        /// </summary>
        public FujiClass1Info()
        {
        }
        /// <summary>
        /// 富士I类info
        /// </summary>
        /// <param name="dr">dr</param>
        public FujiClass1Info(DataRow dr)
            : this()
        {
            this.ID = SQLUtil.ConvertInt(dr["ID"]);
            this.Name = SQLUtil.TrimNull(dr["Name"]);
            this.Description = SQLUtil.TrimNull(dr["Description"]);
            this.AddDate = SQLUtil.ConvertDateTime(dr["AddDate"]);
        }
    }
    /// <summary>
    /// 富士1类关联信息
    /// </summary>
    public class FujiClass1EqpType : EntityInfo
    {
        /// <summary>
        /// 设备类别1
        /// </summary>
        public int EquipmentType1ID { get; set; }
        /// <summary>
        /// 设备类别2
        /// </summary>
        public int EquipmentType2ID { get; set; }
        /// <summary>
        /// 富士I类
        /// </summary>
        public int FujiClass1ID { get; set; }

        /// <summary>
        /// 富士类别关联信息
        /// </summary>
        public FujiClass1EqpType()
        {
        }
        /// <summary>
        /// 富士类别关联信息
        /// </summary>
        /// <param name="dr">dr</param>
        public FujiClass1EqpType(DataRow dr)
            : this()
        {
            this.EquipmentType1ID = SQLUtil.ConvertInt(dr["EquipmentType1ID"]);
            this.EquipmentType2ID = SQLUtil.ConvertInt(dr["EquipmentType2ID"]);
            this.FujiClass1ID = SQLUtil.ConvertInt(dr["FujiClass1ID"]);
        }
    }
}