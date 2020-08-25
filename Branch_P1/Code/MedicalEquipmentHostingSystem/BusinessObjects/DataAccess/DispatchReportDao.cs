using BusinessObjects.Aspect;
using BusinessObjects.Domain;
using BusinessObjects.Util;
using PostSharp.Extensibility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DataAccess
{
    /// <summary>
    /// 作业报告dao
    /// </summary>
    [LoggingAspect(AspectPriority = 1)]
    [ConnectionAspect(AspectPriority = 2, AttributeTargetTypeAttributes = MulticastAttributes.Public)]
    public class DispatchReportDao:BaseDao
    {
        #region"tblDispatchReport"
        /// <summary>
        /// 根据作业报告ID获取作业报告信息
        /// </summary>
        /// <param name="dispatchReportID">作业报告ID</param>
        /// <returns>作业报告信息</returns>
        public DispatchReportInfo GetDispatchReportByID(int dispatchReportID)
        {
            sqlStr = "SELECT re.* FROM tblDispatchReport re " +
                " WHERE re.ID=@ID ";
            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                command.Parameters.Add("@ID", SqlDbType.Int).Value = dispatchReportID;
                DataRow dr = GetDataRow(command);
                if (dr != null)
                    return new DispatchReportInfo(dr);
                else
                    return null;
            }
        }
        /// <summary>
        /// 新增作业报告
        /// </summary>
        /// <param name="dispatchReport">作业报告信息</param>
        /// <returns>作业报告ID</returns>
        public int AddDispatchReport(DispatchReportInfo dispatchReport)
        {
            sqlStr = "INSERT INTO tblDispatchReport(DispatchID ,TypeID ,FaultCode ,"+
                " FaultDesc ,SolutionCauseAnalysis ,SolutionWay,IsPrivate, ServiceProvider,SolutionResultStatusID ," +
                " SolutionUnsolvedComments ,DelayReason,Comments,FujiComments ,StatusID, " +
                " EquipmentStatus, PurchaseAmount, ServiceScope, Result, IsRecall,AcceptanceDate) " +
                " VALUES(@DispatchID ,@TypeID ,@FaultCode ," +
                " @FaultDesc ,@SolutionCauseAnalysis , @SolutionWay,@IsPrivate,@ServiceProvider,@SolutionResultStatusID ," +
                " @SolutionUnsolvedComments ,@DelayReason,@Comments,@FujiComments,@StatusID,  " +
                " @EquipmentStatus, @PurchaseAmount, @ServiceScope, @Result, @IsRecall,@AcceptanceDate); " +
                " SELECT @@IDENTITY";

            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                command.Parameters.Add("@DispatchID", SqlDbType.Int).Value = dispatchReport.Dispatch.ID;
                command.Parameters.Add("@TypeID", SqlDbType.Int).Value = dispatchReport.Type.ID;
                command.Parameters.Add("@FaultCode", SqlDbType.NVarChar).Value =  SQLUtil.TrimNull(dispatchReport.FaultCode);
                command.Parameters.Add("@FaultDesc", SqlDbType.NVarChar).Value =  SQLUtil.TrimNull(dispatchReport.FaultDesc);
                command.Parameters.Add("@SolutionCauseAnalysis", SqlDbType.NVarChar).Value =  SQLUtil.TrimNull(dispatchReport.SolutionCauseAnalysis);
                command.Parameters.Add("@SolutionWay", SqlDbType.NVarChar).Value =  SQLUtil.TrimNull(dispatchReport.SolutionWay);
                command.Parameters.Add("@IsPrivate", SqlDbType.Bit).Value = dispatchReport.IsPrivate;
                command.Parameters.Add("@ServiceProvider", SqlDbType.Int).Value = SQLUtil.ZeroToNull(dispatchReport.ServiceProvider.ID); 
                command.Parameters.Add("@SolutionResultStatusID", SqlDbType.Int).Value = dispatchReport.SolutionResultStatus.ID;
                command.Parameters.Add("@SolutionUnsolvedComments", SqlDbType.NVarChar).Value =  SQLUtil.TrimNull(dispatchReport.SolutionUnsolvedComments);
                command.Parameters.Add("@DelayReason", SqlDbType.NVarChar).Value =  SQLUtil.TrimNull(dispatchReport.DelayReason);
                command.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.Comments);
                command.Parameters.Add("@FujiComments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.FujiComments);
                command.Parameters.Add("@StatusID", SqlDbType.Int).Value = dispatchReport.Status.ID;

                command.Parameters.Add("@EquipmentStatus", SqlDbType.Int).Value = dispatchReport.EquipmentStatus.ID;
                command.Parameters.Add("@PurchaseAmount", SqlDbType.Decimal).Value = SQLUtil.ConvertDouble(dispatchReport.PurchaseAmount);
                command.Parameters.Add("@ServiceScope", SqlDbType.Bit).Value = dispatchReport.ServiceScope;
                command.Parameters.Add("@Result", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.Result);
                command.Parameters.Add("@IsRecall", SqlDbType.Bit).Value = dispatchReport.IsRecall;
                command.Parameters.Add("@AcceptanceDate", SqlDbType.DateTime).Value = SQLUtil.MinDateToNull(dispatchReport.AcceptanceDate);

                dispatchReport.ID = SQLUtil.ConvertInt(command.ExecuteScalar());
            }
            return dispatchReport.ID;
        }
        /// <summary>
        /// 更新作业报告
        /// </summary>
        /// <param name="dispatchReport">作业报告信息</param>
        public void UpdateDispatchReport(DispatchReportInfo dispatchReport)
        {
            sqlStr = "UPDATE tblDispatchReport SET DispatchID=@DispatchID ,TypeID=@TypeID ," +
                " FaultCode=@FaultCode ,FaultDesc=@FaultDesc ," +
                " SolutionCauseAnalysis=@SolutionCauseAnalysis,SolutionWay=@SolutionWay," +
                " IsPrivate=@IsPrivate,ServiceProvider=@ServiceProvider,SolutionResultStatusID=@SolutionResultStatusID ," +
                " SolutionUnsolvedComments=@SolutionUnsolvedComments ,DelayReason=@DelayReason,Comments=@Comments," +
                " FujiComments=@FujiComments ,StatusID=@StatusID, " +
                " EquipmentStatus=@EquipmentStatus, PurchaseAmount=@PurchaseAmount, ServiceScope=@ServiceScope, Result= @Result, IsRecall=@IsRecall,AcceptanceDate=@AcceptanceDate";
            sqlStr += " WHERE ID = @ID";

            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                command.Parameters.Add("@DispatchID", SqlDbType.Int).Value = dispatchReport.Dispatch.ID;
                command.Parameters.Add("@TypeID", SqlDbType.Int).Value = dispatchReport.Type.ID;
                command.Parameters.Add("@FaultCode", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.FaultCode);
                command.Parameters.Add("@FaultDesc", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.FaultDesc);
                command.Parameters.Add("@SolutionCauseAnalysis", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.SolutionCauseAnalysis);
                command.Parameters.Add("@SolutionWay", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.SolutionWay);
                command.Parameters.Add("@IsPrivate", SqlDbType.Bit).Value = dispatchReport.IsPrivate;
                command.Parameters.Add("@ServiceProvider", SqlDbType.Int).Value = SQLUtil.ZeroToNull(dispatchReport.ServiceProvider.ID);
                command.Parameters.Add("@SolutionResultStatusID", SqlDbType.Int).Value = dispatchReport.SolutionResultStatus.ID;
                command.Parameters.Add("@SolutionUnsolvedComments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.SolutionUnsolvedComments);
                command.Parameters.Add("@DelayReason", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.DelayReason);
                command.Parameters.Add("@Comments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.Comments);
                command.Parameters.Add("@FujiComments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.FujiComments);
                command.Parameters.Add("@StatusID", SqlDbType.Int).Value = dispatchReport.Status.ID;
                command.Parameters.Add("@ID", SqlDbType.Int).Value = dispatchReport.ID;

                command.Parameters.Add("@EquipmentStatus", SqlDbType.Int).Value = dispatchReport.EquipmentStatus.ID;
                command.Parameters.Add("@PurchaseAmount", SqlDbType.Decimal).Value = SQLUtil.ConvertDouble(dispatchReport.PurchaseAmount);
                command.Parameters.Add("@ServiceScope", SqlDbType.Bit).Value = dispatchReport.ServiceScope;
                command.Parameters.Add("@Result", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(dispatchReport.Result);
                command.Parameters.Add("@IsRecall", SqlDbType.Bit).Value = dispatchReport.IsRecall;
                command.Parameters.Add("@AcceptanceDate", SqlDbType.DateTime).Value = SQLUtil.MinDateToNull(dispatchReport.AcceptanceDate);

                command.ExecuteNonQuery();
            }
        }
        /// <summary>
        /// 更新作业报告审批信息
        /// </summary>
        /// <param name="reportID">作业报告ID</param>
        /// <param name="statusID">审批后作业报告状态</param>
        /// <param name="fujiComments">审批备注</param>
        /// <param name="solutionResultStatusID">作业报告结果ID</param>
        /// <param name="solutionUnsolvedComments">问题升级</param>
        public void UpdateDispatchReportStatus(int reportID, int statusID, string fujiComments = "", int solutionResultStatusID = 0, string solutionUnsolvedComments = "")
        {
            sqlStr = "UPDATE tblDispatchReport SET FujiComments=@FujiComments ,StatusID=@StatusID, SolutionResultStatusID=@SolutionResultStatusID, " +
                " SolutionUnsolvedComments=@SolutionUnsolvedComments" +
                     " WHERE ID = @ID";

            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                command.Parameters.Add("@StatusID", SqlDbType.Int).Value = statusID;
                command.Parameters.Add("@FujiComments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(fujiComments);
                command.Parameters.Add("@SolutionResultStatusID", SqlDbType.Int).Value = solutionResultStatusID;
                command.Parameters.Add("@SolutionUnsolvedComments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(solutionUnsolvedComments);
                command.Parameters.Add("@ID", SqlDbType.Int).Value = reportID;

                command.ExecuteNonQuery();
            }
        }
        /// <summary>
        /// 审批通过作业报告信息
        /// </summary>
        /// <param name="reportID">作业报告ID</param>
        /// <param name="solutionResultStatusID">作业报告结果ID</param>
        /// <param name="solutionUnsolvedComments">问题升级</param>
        /// <param name="fujiComments">审批备注</param>
        public void PassDispatchReport(int reportID, int solutionResultStatusID, string solutionUnsolvedComments, string fujiComments)
        {
            sqlStr = "UPDATE tblDispatchReport SET SolutionResultStatusID=@SolutionResultStatusID, FujiComments=@FujiComments ,StatusID=@StatusID, " +
                " SolutionUnsolvedComments=@SolutionUnsolvedComments " +
                     " WHERE ID = @ID";

            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                command.Parameters.Add("@FujiComments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(fujiComments);
                command.Parameters.Add("@SolutionResultStatusID", SqlDbType.Int).Value = solutionResultStatusID;
                command.Parameters.Add("@StatusID", SqlDbType.Int).Value = DispatchReportInfo.DispatchReportStatus.Approved;
                command.Parameters.Add("@SolutionUnsolvedComments", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(solutionUnsolvedComments);
                command.Parameters.Add("@ID", SqlDbType.Int).Value = reportID;

                command.ExecuteNonQuery();
            }
        }

        #endregion

        #region"tblReportAccessory"
        /// <summary>
        /// 根据作业报告ID获取零配件信息
        /// </summary>
        /// <param name="dispatchReportID">作业报告ID</param>
        /// <returns>零配件信息</returns>
        public List<ReportAccessoryInfo> GetReportAccessoriesByDispatchReportID(int dispatchReportID)
        {
            List<ReportAccessoryInfo> reportAccessories = new List<ReportAccessoryInfo>();
            sqlStr = "SELECT a.*,s.ID SupplierID,s.Name SupplierName FROM tblReportAccessory a " +
                " LEFT JOIN tblSupplier s ON s.ID=a.SupplierID "+
                " WHERE a.DispatchReportID=@DispatchReportID ";
            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                command.Parameters.Add("@DispatchReportID", SqlDbType.Int).Value = dispatchReportID;
                using (DataTable dt = GetDataTable(command))
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        reportAccessories.Add(new ReportAccessoryInfo(dr));
                    }
                }
                return reportAccessories;
            }
        }
        /// <summary>
        /// 新增零配件信息
        /// </summary>
        /// <param name="reportAccessory">零配件信息信息</param>
        /// <returns>零配件信息ID</returns>
        public int AddReportAccessory(ReportAccessoryInfo reportAccessory)
        {
            sqlStr = "INSERT INTO tblReportAccessory(DispatchReportID, Name, SourceID, SupplierID, NewSerialCode, OldSerialCode, Qty, Amount) " +
                     " VALUES(@DispatchReportID, @Name, @SourceID, @SupplierID, @NewSerialCode, @OldSerialCode, @Qty, @Amount); " +
                     " SELECT @@IDENTITY";

            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                command.Parameters.Add("@DispatchReportID", SqlDbType.Int).Value = reportAccessory.DispatchReportID;
                command.Parameters.Add("@Name", SqlDbType.NVarChar).Value = SQLUtil.TrimNull(reportAccessory.Name);
                command.Parameters.Add("@SourceID", SqlDbType.Int).Value = reportAccessory.Source.ID;
                command.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SQLUtil.ZeroToNull(reportAccessory.Supplier.ID);
                command.Parameters.Add("@NewSerialCode", SqlDbType.VarChar).Value = SQLUtil.TrimNull(reportAccessory.NewSerialCode);
                command.Parameters.Add("@OldSerialCode", SqlDbType.VarChar).Value = SQLUtil.TrimNull(reportAccessory.OldSerialCode);
                command.Parameters.Add("@Qty", SqlDbType.Int).Value = reportAccessory.Qty;
                command.Parameters.Add("@Amount", SqlDbType.Decimal).Value = reportAccessory.Amount;

                reportAccessory.ID = SQLUtil.ConvertInt(command.ExecuteScalar());
            }
            return reportAccessory.ID;
        }
        /// <summary>
        /// 根据零配件ID删除零配件
        /// </summary>
        /// <param name="reportAccessoryID">零配件ID</param>
        public void DeleteReportAccessory(int reportAccessoryID)
        {
            sqlStr = " DELETE FROM tblReportAccessory WHERE ID=@ID";
            using (SqlCommand command = ConnectionUtil.GetCommand(sqlStr))
            {
                command.Parameters.Add("@ID", SqlDbType.Int).Value = reportAccessoryID;
                command.ExecuteNonQuery();
            }
        }

        #endregion
    }
}
