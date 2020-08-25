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
    public class EquipmentInfo : EntityInfo
    {
        public KeyValueInfo EquipmentLevel { get; set; }
        public string Name { get; set; }
        public string EquipmentCode { get; set; }
        public string SerialCode { get; set; }
        public int ManufacturerID { get; set; }
        public int EquipmentClass1 { get; set; }
        public int EquipmentClass2 { get; set; }
        public int EquipmentClass3 { get; set; }
        public int ResponseTimeLength { get; set; }
        public bool FixedAsset { get; set; }
        public string AssetCode { get; set; }
        public KeyValueInfo AssetLevel { get; set; }
        public int DepreciationYears { get; set; }
        public DateTime ValidityStartDate { get; set; }
        public DateTime ValidityEndDate { get; set; }
        public string SaleContractName { get; set; }
        public int SupplierID { get; set; }
        public string PurchaseWay { get; set; }
        public double PurchaseAmount { get; set; }
        public DateTime PurchaseDate { get; set; }
        public bool IsImport { get; set; }
        public KeyValueInfo Department { get; set; }
        public string InstalSite { get; set; }
        public DateTime InstalDate { get; set; }
        public bool Accepted { get; set; }
        public DateTime AcceptanceDate { get; set; }
        public KeyValueInfo UsageStatus { get; set; }
        public KeyValueInfo EquipmentStatus { get; set; }
        public DateTime ScrapDate { get; set; }
        public int MaintenancePeriod { get; set; }
        public KeyValueInfo MaintenanceType { get; set; }
        public DateTime LastMaintenanceDate { get; set; }
        public int PatrolPeriod { get; set; }
        public KeyValueInfo PatrolType { get; set; }
        public DateTime LastPatrolDate { get; set; }
        public int CorrectionPeriod { get; set; }
        public KeyValueInfo CorrectionType { get; set; }
        public DateTime LastCorrectionDate { get; set; }
        public KeyValueInfo MandatoryTestStatus { get; set; }
        public DateTime MandatoryTestDate { get; set; }
        public bool RecallFlag { get; set; }
        public DateTime RecallDate { get; set; }
        public DateTime CreateDate { get; set; }
        public int CreateUserID { get; set; }

        public string Brand { get; set; }
        public string Comments { get; set; }
        public DateTime ManufacturingDate { get; set; }
        public DateTime UseageDate { get; set; }
        public int FujiClass2ID { get; set; }
        public string CTSerialCode { get; set; }
        public double CTUsedSeconds { get; set; }

        public int DepartmentID { get { return this.Department.ID; } }

        public EquipmentInfo() 
        {
            this.EquipmentLevel = new KeyValueInfo();
            this.AssetLevel = new KeyValueInfo();
            this.Department = new KeyValueInfo();
            this.UsageStatus = new KeyValueInfo();
            this.EquipmentStatus = new KeyValueInfo();
            this.MaintenanceType = new KeyValueInfo();
            this.PatrolType = new KeyValueInfo();
            this.CorrectionType = new KeyValueInfo();
            this.MandatoryTestStatus = new KeyValueInfo();
        }

        public EquipmentInfo(DataRow dr)
            : this()
        {
            this.EquipmentLevel.ID = SQLUtil.ConvertInt(dr["EquipmentLevel"]);
            this.Name = SQLUtil.TrimNull(dr["Name"]);
            this.EquipmentCode = SQLUtil.TrimNull(dr["Model"]);
            this.SerialCode = SQLUtil.TrimNull(dr["SerialNo#"]);
            this.ManufacturerID = SQLUtil.ConvertInt(dr["ManufacturerID"]);
            this.EquipmentClass1 = SQLUtil.ConvertInt(dr["EquipmentClass1"]);
            this.EquipmentClass2 = SQLUtil.ConvertInt(dr["EquipmentClass2"]);
            this.EquipmentClass3 = SQLUtil.ConvertInt(dr["EquipmentClass3"]);
            this.ResponseTimeLength = SQLUtil.ConvertInt(dr["StandardResponseTime(minutes)"]);
            this.FixedAsset = SQLUtil.ConvertBoolean(dr["FixedAsset"]);
            this.AssetCode = SQLUtil.TrimNull(dr["AssetNumber"]);
            this.AssetLevel.ID = SQLUtil.ConvertInt(dr["AssetClassID"]);
            this.DepreciationYears = SQLUtil.ConvertInt(dr["DepreciationYears"]);
            this.ValidityStartDate = SQLUtil.ConvertDateTime(dr["DurationofCertificateStartDate"]);
            this.ValidityEndDate = SQLUtil.ConvertDateTime(dr["DurationofCertificateEndDate"]);
            this.SaleContractName = SQLUtil.TrimNull(dr["SalesContract"]);
            this.SupplierID = SQLUtil.ConvertInt(dr["DealerID"]);
            this.PurchaseWay = SQLUtil.TrimNull(dr["PurchaseType"]);
            this.PurchaseAmount = SQLUtil.ConvertDouble(dr["PurchaseAmount"]);
            this.PurchaseDate = SQLUtil.ConvertDateTime(dr["PurchaseDate"]);
            this.IsImport = SQLUtil.ConvertBoolean(dr["ProductionDistrict"]);
            this.Department.ID = SQLUtil.ConvertInt(dr["DepartmentID"]);
            this.InstalSite = SQLUtil.TrimNull(dr["InstallationLocation"]);
            this.InstalDate = SQLUtil.ConvertDateTime(dr["InstalDate"]);
            this.Accepted = SQLUtil.ConvertBoolean(dr["AcceptanceStatus"]);
            this.AcceptanceDate = SQLUtil.ConvertDateTime(dr["AcceptanceDate"]);
            this.UsageStatus.ID = SQLUtil.ConvertInt(dr["StatusofUse"]); 
            this.EquipmentStatus.ID = SQLUtil.ConvertInt(dr["EquipmentStatusID"]);
            this.ScrapDate = SQLUtil.ConvertDateTime(dr["DisposalDate"]);
            this.MaintenancePeriod = SQLUtil.ConvertInt(dr["MaintenancePeriod"]);
            this.MaintenanceType.ID = SQLUtil.ConvertInt(dr["MaintenanceTypeID"]);
            this.PatrolPeriod = SQLUtil.ConvertInt(dr["PatrolPeriod"]);
            this.PatrolType.ID = SQLUtil.ConvertInt(dr["PatrolTypeID"]);
            this.CorrectionPeriod = SQLUtil.ConvertInt(dr["CalibrationPeriod"]);
            this.CorrectionType.ID = SQLUtil.ConvertInt(dr["CalibrationTypeID"]);
            this.MandatoryTestStatus.ID = SQLUtil.ConvertInt(dr["InspectionFlag"]);
            this.MandatoryTestDate = SQLUtil.ConvertDateTime(dr["InspectionDate"]);
            this.RecallFlag = SQLUtil.ConvertBoolean(dr["RecallFlag"]);
            this.RecallDate = SQLUtil.ConvertDateTime(dr["RecallDate"]);
            this.CreateDate = SQLUtil.ConvertDateTime(dr["CreateDate"]);
            this.CreateUserID = SQLUtil.ConvertInt(dr["CreateUserID"]);
            this.Brand = SQLUtil.TrimNull(dr["Brand"]);
            this.Comments = SQLUtil.TrimNull(dr["Comments"]);
            this.ManufacturingDate = SQLUtil.ConvertDateTime(dr["ManufacturingDate"]);
            this.UseageDate = SQLUtil.ConvertDateTime(dr["UseageDate"]);
            this.FujiClass2ID = SQLUtil.ConvertInt(dr["FujiClass2ID"]);
            this.CTSerialCode = SQLUtil.TrimNull(dr["CTSerialCode"]);
            this.CTUsedSeconds = SQLUtil.ConvertDouble(dr["CTUsedSeconds"]);
        }
    }
}
