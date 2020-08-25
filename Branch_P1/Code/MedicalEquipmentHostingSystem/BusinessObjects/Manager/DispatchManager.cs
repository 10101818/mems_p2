using BusinessObjects.Aspect;
using BusinessObjects.DataAccess;
using BusinessObjects.Domain;
using BusinessObjects.Util;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.Manager
{
    /// <summary>
    /// 派工单manager
    /// </summary>
    [LoggingAspect(AspectPriority = 1)]
    public class DispatchManager
    {
        private DispatchDao dispatchDao = new DispatchDao();
        private RequestDao requestDao = new RequestDao();
        private FileDao fileDao = new FileDao();
        private HistoryDao historyDao = new HistoryDao();
        private DispatchJournalDao dispatchJournalDao = new DispatchJournalDao();
        private DispatchReportDao dispatchReportDao = new DispatchReportDao();
        private RequestManager requestManager = new RequestManager();
        private UserManager userManager = new UserManager();
        private UploadFileManager fileManager = new UploadFileManager();
        private EquipmentManager equipmentManager = new EquipmentManager();
        private EquipmentDao equipmentDao = new EquipmentDao();

        #region"Dispatch"
        /// <summary>
        /// 获取派工单列表信息
        /// </summary>
        /// <param name="userID">用户编号</param>
        /// <param name="userRoleID">用户角色编号</param>
        /// <param name="status">派工单状态</param>
        /// <param name="urgency">派工单</param>
        /// <param name="type">派工类型</param>
        /// <param name="filterField">搜索字段</param>
        /// <param name="filterText">搜索框填写内容</param>
        /// <param name="sortField">排序字段</param>
        /// <param name="sortDirection">排序方式</param>
        /// <param name="curRowNum">当前页数第一个数据的位置</param>
        /// <param name="pageSize">每页展示数据条数</param>
        /// <returns>派工单列表信息</returns>
        public List<DispatchInfo> QueryDispatches(int userID, int userRoleID, int status, int urgency, int type, string filterField, string filterText, string sortField, bool sortDirection, int curRowNum, int pageSize)
        {
            List<int> statusList = new List<int>();
            if (status != 0) statusList.Add(status);

            return QueryDispatches(userID, userRoleID, statusList, urgency, type, filterField, filterText, sortField, sortDirection, curRowNum, pageSize);
        }

        /// <summary>
        /// APP获取派工单信息
        /// </summary>
        /// <param name="userID">用户编号</param>
        /// <param name="userRoleID">用户角色编号</param>
        /// <param name="statusList">派工单状态集</param>
        /// <param name="urgency">派工单紧急程度</param>
        /// <param name="type">派工类型</param>
        /// <param name="filterField">搜索字段</param>
        /// <param name="filterText">搜索框填写内容</param>
        /// <param name="sortField">排序字段</param>
        /// <param name="sortDirection">排序方式</param>
        /// <param name="curRowNum">当前页数第一个数据的位置</param>
        /// <param name="pageSize">每页展示数据条数</param>
        /// <returns>派工单信息</returns>
        public List<DispatchInfo> QueryDispatches(int userID, int userRoleID, List<int> statusList, int urgency, int type, string filterField, string filterText, string sortField, bool sortDirection, int curRowNum, int pageSize)
        {
            List<DispatchInfo> dispatchInfos = dispatchDao.QueryDispatches(userID, userRoleID, statusList, urgency, type, filterField, filterText, sortField, sortDirection, curRowNum, pageSize);

            if (dispatchInfos.Count > 0)
            {
                List<RequestEqptInfo> requestEqpts = this.requestDao.GetRequestEgpts(SQLUtil.GetIDListFromObjectList(dispatchInfos, "RequestID"));

                foreach (DispatchInfo info in dispatchInfos)
                {
                    info.Request.Equipments = (from RequestEqptInfo temp in requestEqpts where temp.RequestID == info.RequestID select temp.Equipment).ToList();
                }
            }

            return dispatchInfos;
        }

        /// <summary>
        /// 根据派工单id获取派工单信息
        /// </summary>
        /// <param name="id">派工单编号</param>
        /// <returns>派工单信息</returns>
        public DispatchInfo GetDispatchByID(int id)
        {
            DispatchInfo dispatchInfo = this.dispatchDao.GetDispatchByID(id);
            if (dispatchInfo != null)
            {
                List<HistoryInfo> histories = this.historyDao.GetHistories(ObjectTypes.Dispatch, dispatchInfo.ID);
                if (histories != null && histories.Count > 0)
                {
                    foreach (HistoryInfo history in histories)
                    {
                        history.Action.Name = DispatchInfo.Actions.GetDesc(history.Action.ID);
                    }
                    dispatchInfo.Histories = histories;
                    dispatchInfo.SetHis4Comments();
                }
                dispatchInfo.Request = this.requestManager.GetRequest(dispatchInfo.Request.ID);
                UserInfo user = userManager.GetUser(dispatchInfo.Engineer.ID);
                if (user != null) dispatchInfo.Engineer.Name = user.Name;
            }

            return dispatchInfo;
        }

        /// <summary>
        /// 根据请求id获取最新派工单信息信息
        /// </summary>
        /// <param name="id">请求编号</param>
        /// <returns>派工单信息</returns>
        public DispatchInfo GetDispatchByRequestID(int id)
        {
            DispatchInfo dispatchInfo = new DispatchInfo();

            dispatchInfo = this.dispatchDao.GetDispatchByRequestID(id);
            if (dispatchInfo == null)
            {
                dispatchInfo = new DispatchInfo();
            }

            List<HistoryInfo> histories = this.historyDao.GetHistories(ObjectTypes.Dispatch, dispatchInfo.ID);
            if (histories != null && histories.Count > 0)
            {
                foreach (HistoryInfo history in histories)
                {
                    history.Action.Name = DispatchInfo.Actions.GetDesc(history.Action.ID);
                }
                dispatchInfo.Histories = histories;
                dispatchInfo.SetHis4Comments();
            }
            dispatchInfo.Request = this.requestManager.GetRequest(id);
            dispatchInfo.Engineer = userManager.GetUser(dispatchInfo.Engineer.ID);

            return dispatchInfo;
        }

        /// <summary>
        /// 根据服务凭证、作业报告状态修改派工单状态和请求状态
        /// </summary>
        /// <param name="dispatchID">派工单编号</param>
        /// <param name="user">操作的用户信息</param>
        private void UpdateDispatchStatusByJournalAndReport(int dispatchID, UserInfo user)
        {
            int dispatchStatusID = 0;
            int requestStatusID = 0;
            DispatchInfo dispatch = this.dispatchDao.GetDispatchByID(dispatchID);
            List<DispatchInfo> dispatches = this.dispatchDao.GetOpenDispatchesByRequestID(dispatch.Request.ID);
            RequestInfo request = this.requestDao.QueryRequestByID(dispatch.Request.ID);

            if (dispatch.DispatchReport.Status.ID == DispatchReportInfo.DispatchReportStatus.Approved && dispatch.DispatchJournal.Status.ID == DispatchJournalInfo.DispatchJournalStatus.Approved)
            {   //Journal和Report全部审批结束 ——派工单显示已审批、请求更新状态
                dispatchStatusID = DispatchInfo.Statuses.Approved;

                DispatchReportInfo dispatchReport = this.dispatchReportDao.GetDispatchReportByID(dispatch.DispatchReport.ID);
                if (request.Status.ID == RequestInfo.Statuses.Close)
                {
                    requestStatusID = RequestInfo.Statuses.Close;
                }
                else
                {
                    requestStatusID = DispatchReportInfo.SolutionResultStatuses.GetRequestStatusBySolutionResult(dispatchReport.SolutionResultStatus.ID);
                }

                this.requestDao.UpdateLastStatusID(dispatch.Request.ID, requestStatusID);
                if (requestStatusID == RequestInfo.Statuses.Close)
                {
                    this.requestDao.UpdateRequestCloseDate(dispatch.Request.ID);

                    dispatch.Request = this.requestManager.GetRequest(dispatch.Request.ID);
                    if (dispatch.Request.Source.ID == RequestInfo.Sources.SysRequest)
                    {
                        foreach (EquipmentInfo info in dispatch.Request.Equipments)
                        {
                            if (dispatch.RequestType.ID == RequestInfo.RequestTypes.Maintain)
                            {
                                this.equipmentManager.UpdateEquipmentLastMaintenanceCheck(info);
                            }
                            else if (dispatch.RequestType.ID == RequestInfo.RequestTypes.Correcting)
                            {
                                this.equipmentManager.UpdateEquipmentLastCorrectionCheck(info);
                            }
                            else if (dispatch.RequestType.ID == RequestInfo.RequestTypes.OnSiteInspection)
                            {
                                DateTime dt = dispatch.Request.SelectiveDate != DateTime.MinValue ? dispatch.Request.SelectiveDate : dispatch.Request.RequestDate;
                                this.equipmentManager.UpdateEquipmentLastPatrolCheck(info.ID, dt);
                            }
                        }
                    }
                }
                this.dispatchDao.UpdateDispatchEndDate(dispatchID);

                PassDispatchReportInternal(dispatchReport, user);

                HistoryInfo historyRequest = new HistoryInfo(dispatch.Request.ID, ObjectTypes.Request, user.ID, RequestInfo.Actions.Update);
                this.historyDao.AddHistory(historyRequest);//添加历史操作——请求 更新状态

                HistoryInfo historyDisptach = new HistoryInfo(dispatchID, ObjectTypes.Dispatch, user.ID, DispatchInfo.Actions.Finish);
                this.historyDao.AddHistory(historyDisptach);//添加历史操作——派工单 完成
            }
            else if (dispatch.DispatchReport.Status.ID < DispatchReportInfo.DispatchReportStatus.Pending && dispatch.DispatchJournal.Status.ID < DispatchJournalInfo.DispatchJournalStatus.Pending)
            {   //Journal和Report 未创建、两者均被退回、一者被退回 另一者未提交 未新建 ——派工单显示已响应,请求显示已响应
                dispatchStatusID = DispatchInfo.Statuses.Responded;
                if (request.Status.ID == RequestInfo.Statuses.Close)
                {
                    requestStatusID = RequestInfo.Statuses.Close;
                }
                else
                {
                    requestStatusID = RequestInfo.Statuses.Responded;
                    foreach (DispatchInfo info in dispatches)
                    {
                        if (info.ID != dispatchID && info.Status.ID == DispatchInfo.Statuses.Pending)
                        {
                            requestStatusID = RequestInfo.Statuses.Pending;
                            break;
                        }
                    }
                }
            }
            else
            {//其余情况均为 派工单状态——待审批
                dispatchStatusID = DispatchInfo.Statuses.Pending;
                if (request.Status.ID == RequestInfo.Statuses.Close)
                {
                    requestStatusID = RequestInfo.Statuses.Close;
                }
                else
                {
                    requestStatusID = RequestInfo.Statuses.Pending;
                }
            }

            this.requestDao.UpdateRequestStatus(dispatch.Request.ID, requestStatusID);
            this.dispatchDao.UpdateDispatchStatus(dispatchID, dispatchStatusID);
        }

        /// <summary>
        /// 开始作业
        /// </summary>
        /// <param name="dispatchID">派工单编号</param>
        /// <param name="requestID">请求编号</param>
        /// <param name="user">操作的用户信息</param>
        [TransactionAspect]
        public void ResponseDispatch(int dispatchID, int requestID, UserInfo user)
        {
            RequestInfo info = this.requestManager.GetRequest(requestID);

            int requestStatusID = RequestInfo.Statuses.Responded;
            if (info.Status.ID == RequestInfo.Statuses.Close || info.Status.ID == RequestInfo.Statuses.Pending)
            {
                requestStatusID = info.Status.ID;
            }

            if (info.ResponseDate == DateTime.MinValue)
            {
                this.requestDao.UpdateRequest4DispatchResponse(requestID, requestStatusID);
            }
            else
            {
                this.requestDao.UpdateRequestStatus(requestID, requestStatusID);
            }

            this.dispatchDao.UpdateDispatchStatus(dispatchID, DispatchInfo.Statuses.Responded);
            this.dispatchDao.UpdateDispatchStartDate(dispatchID);
            //添加历史操作——派工单 响应
            HistoryInfo historyDisptach = new HistoryInfo(dispatchID, ObjectTypes.Dispatch, user.ID, DispatchInfo.Actions.Response);
            this.historyDao.AddHistory(historyDisptach);
        }

        /// <summary>
        /// 取消派工单，修改派工单、请求、作业报告、服务凭证状态
        /// </summary>
        /// <param name="dispatchID">派工单编号</param>
        /// <param name="requestID">请求编号</param>
        /// <param name="user">用户信息</param>
        [TransactionAspect]
        public void CancelDispatch(int dispatchID, int requestID, UserInfo user)
        {
            RequestInfo info = this.requestDao.QueryRequestByID(requestID);
            DispatchInfo dispatch = this.dispatchDao.GetDispatchByID(dispatchID);

            List<DispatchInfo> dispatchInfos = this.dispatchDao.GetOpenDispatchesByRequestID(requestID);
            bool isExisted = dispatchInfos.Count > 1 ? true : false;

            if (isExisted == false)
            {
                this.requestDao.UpdateRequestStatus(requestID, info.LastStatus.ID);
            }
            else
            {
                int dispatchStatusID = 0;
                foreach (DispatchInfo temp in dispatchInfos)
                {
                    if (temp.ID != dispatchID && temp.Status.ID > dispatchStatusID)
                    {
                        dispatchStatusID = temp.Status.ID;
                    }
                }
                this.requestDao.UpdateRequestStatus(requestID, DispatchInfo.Statuses.GetRequestStatusByStatuses(dispatchStatusID));
            }

            this.dispatchDao.UpdateDispatchStatus(dispatchID, DispatchInfo.Statuses.Cancelled);

            this.dispatchJournalDao.UpdateDispatchJournalStatus(dispatch.DispatchJournal.ID, DispatchJournalInfo.DispatchJournalStatus.Cancelled, 0);

            this.dispatchReportDao.UpdateDispatchReportStatus(dispatch.DispatchReport.ID, DispatchReportInfo.DispatchReportStatus.Cancelled);

            //添加历史操作——派工单 关闭
            HistoryInfo historyDisptach = new HistoryInfo(dispatchID, ObjectTypes.Dispatch, user.ID, DispatchInfo.Actions.Cancelled);
            this.historyDao.AddHistory(historyDisptach);
        }

        #endregion


        #region"DispatchJournal"
        /// <summary>
        /// 获取服务凭证列表信息
        /// </summary>
        /// <param name="status">服务凭证审批状态</param>
        /// <param name="urgency">派工单紧急程度</param>
        /// <param name="filterField">搜索字段</param>
        /// <param name="filterText">搜索框填写内容</param>
        /// <param name="sortField">排序字段</param>
        /// <param name="sortDirection">排序方式</param>
        /// <param name="curRowNum">当前页数第一个数据的位置</param>
        /// <param name="pageSize">每页展示数据条数</param>
        /// <returns>服务凭证列表信息</returns>
        public List<DispatchJournalInfo> QueryDispatchJournals(int status, int urgency, string filterField, string filterText, string sortField, bool sortDirection, int curRowNum = 0, int pageSize = 0)
        {
            List<DispatchJournalInfo> dispatchJournals = dispatchDao.QueryDispatchJournals(status, urgency, filterField, filterText, sortField, sortDirection, curRowNum, pageSize);

            if (dispatchJournals.Count > 0)
            {
                List<RequestEqptInfo> requestEqpts = this.requestDao.GetRequestEgpts(SQLUtil.GetIDListFromObjectList(dispatchJournals, "RequestID"));

                foreach (DispatchJournalInfo info in dispatchJournals)
                {
                    info.Dispatch.Request.Equipments = (from RequestEqptInfo temp in requestEqpts where temp.RequestID == info.RequestID select temp.Equipment).ToList();
                }
            }

            return dispatchJournals;
        }

        /// <summary>
        /// 根据服务凭证id获取服务凭证信息
        /// </summary>
        /// <param name="dispatchJournalId">服务凭证编号</param>
        /// <returns>服务凭证信息</returns>
        public DispatchJournalInfo GetDispatchJournalByID(int dispatchJournalId)
        {
            DispatchJournalInfo info = this.dispatchJournalDao.GetDispatchJournalByID(dispatchJournalId);
            if (info != null)
            {
                List<HistoryInfo> histories = this.historyDao.GetHistories(ObjectTypes.DispatchJournal, info.ID);
                if (histories != null && histories.Count > 0)
                {
                    foreach (HistoryInfo history in histories)
                    {
                        history.Action.Name = DispatchJournalInfo.Actions.GetDesc(history.Action.ID);
                    }
                    info.Histories = histories;
                    info.SetHis4Comments();
                }

                if (info.SignatureFileName != "")
                {
                    string path = Path.Combine(Constants.DispatchJournalFolder, info.SignatureFileName);
                    if (!File.Exists(path)) path = Path.Combine(Constants.ImageFolder, Constants.ImageErrorName);

                    byte[] arr = File.ReadAllBytes(path);
                    info.FileContent = Convert.ToBase64String(arr);
                }
            }

            return info;
        }

        /// <summary>
        /// 保存服务凭证信息
        /// </summary>
        /// <param name="dispatchJournal">服务凭证信息</param>
        /// <param name="user">操作的用户信息</param>
        /// <returns>服务凭证信息</returns>
        [TransactionAspect]
        public DispatchJournalInfo SaveDispatchJournal(DispatchJournalInfo dispatchJournal, UserInfo user)
        {
            if (dispatchJournal.ID > 0)
            {
                this.dispatchJournalDao.UpdateDispatchJournal(dispatchJournal);
                FileUtil.DeleteFile(ObjectTypes.GetFileFolder(ObjectTypes.DispatchJournal), dispatchJournal.SignatureFileName);
            }
            else
                dispatchJournal.ID = this.dispatchJournalDao.AddDispatchJournal(dispatchJournal);


            byte[] fileContent = Convert.FromBase64String(dispatchJournal.FileContent);
            FileUtil.SaveFile(fileContent, Constants.DispatchJournalFolder, dispatchJournal.SignatureFileName);

            UpdateDispatchStatusByJournalAndReport(dispatchJournal.Dispatch.ID, user);
            //添加历史操作——服务凭证 提交
            HistoryInfo historyDisptach = new HistoryInfo(dispatchJournal.ID, ObjectTypes.DispatchJournal, user.ID, DispatchJournalInfo.Actions.Submit);
            this.historyDao.AddHistory(historyDisptach);

            return dispatchJournal;
        }

        /// <summary>
        /// 审批通过服务凭证
        /// </summary>
        /// <param name="journalID">服务凭证编号</param>
        /// <param name="dispatchID">派工单编号</param>
        /// <param name="resultStatusID">服务凭证结果</param>
        /// <param name="user">操作的用户信息</param>
        /// <param name="followProblem">待跟进问题</param>
        /// <param name="comments">审批备注</param>
        [TransactionAspect]
        public void PassDispatchJournal(int journalID, int dispatchID, int resultStatusID, UserInfo user, string followProblem = "", string comments = "")
        {
            this.dispatchJournalDao.UpdateDispatchJournalStatus(journalID, DispatchJournalInfo.DispatchJournalStatus.Approved, resultStatusID, followProblem, comments);
            UpdateDispatchStatusByJournalAndReport(dispatchID, user);

            HistoryInfo history = new HistoryInfo(journalID, ObjectTypes.DispatchJournal, user.ID, DispatchJournalInfo.Actions.Pass, comments);
            this.historyDao.AddHistory(history);
        }

        /// <summary>
        /// 审批拒绝服务凭证
        /// </summary>
        /// <param name="journalID">服务凭证编号</param>
        /// <param name="dispatchID">派工单编号</param>
        /// <param name="resultStatusID">服务凭证结果</param>
        /// <param name="user">操作的用户信息</param>
        /// <param name="followProblem">待跟进问题</param>
        /// <param name="comments">审批备注</param>
        [TransactionAspect]
        public void RejectDispatchJournal(int journalID, int dispatchID, int resultStatusID, UserInfo user, string followProblem, string comments)
        {
            this.dispatchJournalDao.UpdateDispatchJournalStatus(journalID, DispatchJournalInfo.DispatchJournalStatus.New, resultStatusID, followProblem, comments);
            UpdateDispatchStatusByJournalAndReport(dispatchID, user);

            HistoryInfo history = new HistoryInfo(journalID, ObjectTypes.DispatchJournal, user.ID, DispatchJournalInfo.Actions.Reject, comments);
            this.historyDao.AddHistory(history);
        }

        #endregion

        #region"DispatchReport"
        /// <summary>
        /// 根据作业报告id获取作业报告信息
        /// </summary>
        /// <param name="dispatchReportID">作业报告编号</param>
        /// <returns>作业报告信息</returns>
        public DispatchReportInfo GetDispatchReportByID(int dispatchReportID)
        {
            DispatchReportInfo dispatchReport = dispatchReportDao.GetDispatchReportByID(dispatchReportID);
            DispatchInfo dispatchInfo = this.dispatchDao.GetDispatchByID(dispatchReport.Dispatch.ID);
            dispatchReport.Dispatch = dispatchInfo.Copy4Base();
            if (dispatchReport != null)
            {
                UploadFileInfo fileInfo = this.fileDao.GetFile(ObjectTypes.DispatchReport, dispatchReport.ID);
                if (fileInfo != null)
                {
                    dispatchReport.FileInfo = fileInfo;
                }
                else
                {
                    dispatchReport.FileInfo = new UploadFileInfo();
                }

                List<HistoryInfo> histories = this.historyDao.GetHistories(ObjectTypes.DispatchReport, dispatchReport.ID);
                if (histories != null && histories.Count > 0)
                {
                    foreach (HistoryInfo history in histories)
                    {
                        history.Action.Name = DispatchReportInfo.Actions.GetDesc(history.Action.ID);
                    }
                    dispatchReport.Histories = histories;
                    dispatchReport.SetHis4Comments();
                }

                dispatchReport.ReportAccessories = dispatchReportDao.GetReportAccessoriesByDispatchReportID(dispatchReport.ID);
                if (dispatchReport.ReportAccessories.Count > 0)
                {
                    foreach (ReportAccessoryInfo reportAccessory in dispatchReport.ReportAccessories)
                    {
                        reportAccessory.FileInfos = this.fileDao.GetFiles(ObjectTypes.ReportAccessory, reportAccessory.ID);
                    }
                }
            }
            return dispatchReport;
        }

        /// <summary>
        /// 获取作业报告列表信息
        /// </summary>
        /// <param name="status">作业报告审批状态</param>
        /// <param name="urgency">派工单紧急程度</param>
        /// <param name="filterField">搜索字段</param>
        /// <param name="filterText">搜索框填写内容</param>
        /// <param name="sortField">排序字段</param>
        /// <param name="sortDirection">排序方式</param>
        /// <param name="curRowNum">当前页数第一个数据的位置</param>
        /// <param name="pageSize">每页展示数据条数</param>
        /// <returns>作业报告列表信息</returns>
        public List<DispatchReportInfo> QueryDispatchReports(int status, int urgency, string filterField, string filterText, string sortField, bool sortDirection, int curRowNum = 0, int pageSize = 0)
        {
            List<DispatchReportInfo> dispatchReports = dispatchDao.QueryDispatchReports(status, urgency, filterField, filterText, sortField, sortDirection, curRowNum, pageSize);

            if (dispatchReports.Count > 0)
            {
                List<RequestEqptInfo> requestEqpts = this.requestDao.GetRequestEgpts(SQLUtil.GetIDListFromObjectList(dispatchReports, "RequestID"));

                foreach (DispatchReportInfo info in dispatchReports)
                {
                    info.Dispatch.Request.Equipments = (from RequestEqptInfo temp in requestEqpts where temp.RequestID == info.RequestID select temp.Equipment).ToList();
                }
            }

            return dispatchReports;
        }

        /// <summary>
        /// 保存作业报告信息
        /// </summary>
        /// <param name="dispatchReport">作业报告信息</param>
        /// <param name="user">操作的用户信息</param>
        /// <returns>作业报告编号</returns>
        [TransactionAspect]
        public int SaveDispatchReport(DispatchReportInfo dispatchReport, UserInfo user)
        {
            if (dispatchReport.ID > 0)
            {
                this.dispatchReportDao.UpdateDispatchReport(dispatchReport);

                if (dispatchReport.Status.ID == DispatchReportInfo.DispatchReportStatus.Pending)
                {
                    UpdateDispatchStatusByJournalAndReport(dispatchReport.Dispatch.ID, user);

                    HistoryInfo history = new HistoryInfo(dispatchReport.ID, ObjectTypes.DispatchReport, user.ID, DispatchReportInfo.Actions.Submit, dispatchReport.FujiComments);
                    this.historyDao.AddHistory(history);
                }
                return dispatchReport.ID;
            }
            else
                return this.dispatchReportDao.AddDispatchReport(dispatchReport);
        }

        /// <summary>
        /// 审批通过作业报告
        /// </summary>
        /// <param name="info">作业报告信息</param>
        /// <param name="user">操作的用户信息</param>
        [TransactionAspect]
        public void PassDispatchReport(DispatchReportInfo info, UserInfo user)
        {
            info.Status.ID = DispatchInfo.DocStatus.Approved;
            this.dispatchReportDao.UpdateDispatchReport(info);

            HistoryInfo history = new HistoryInfo(info.ID, ObjectTypes.DispatchReport, user.ID, DispatchReportInfo.Actions.Pass, info.FujiComments);
            this.historyDao.AddHistory(history);

            UpdateDispatchStatusByJournalAndReport(info.Dispatch.ID, user);
        }

        /// <summary>
        /// 派工单状态已审批时根据作业报告信息修改设备信息
        /// </summary>
        /// <param name="dispatchReportInfo">作业报告信息</param>
        /// <param name="user">操作的用户信息</param>
        private void PassDispatchReportInternal(DispatchReportInfo dispatchReportInfo, UserInfo user)
        {            
            DispatchInfo dispatchInfo = this.dispatchDao.GetDispatchByID(dispatchReportInfo.Dispatch.ID);

            if (dispatchReportInfo.Type.ID != DispatchReportInfo.DispatchReportTypes.Common )
            {
                List<EquipmentInfo> equipments = this.requestDao.GetRequestEgpts(dispatchInfo.RequestID);
                foreach (EquipmentInfo equipment in equipments)
                {
                    if (dispatchInfo.RequestType.ID == RequestInfo.RequestTypes.AddEquipment)
                    {
                        equipment.PurchaseAmount = dispatchReportInfo.PurchaseAmount;
                        equipment.ServiceScope = dispatchReportInfo.ServiceScope;                        
                    }
                    else if (dispatchInfo.RequestType.ID == RequestInfo.RequestTypes.Repair)
                    {
                        if (dispatchReportInfo.EquipmentStatus.ID != MachineStatuses.Normal)
                            equipment.EquipmentStatus.ID = EquipmentInfo.EquipmentStatuses.Fault;
                        else
                            equipment.EquipmentStatus.ID = dispatchReportInfo.EquipmentStatus.ID;                            
                    }
                    else if (dispatchInfo.RequestType.ID == RequestInfo.RequestTypes.Accetance)
                    {
                        if (dispatchReportInfo.AcceptanceDate != DateTime.MinValue)
                        {
                            equipment.AcceptanceDate = dispatchReportInfo.AcceptanceDate;
                            equipment.Accepted = true;
                        }
                    }

                    this.equipmentManager.SaveEquipment(equipment, null, user);
                }
            }
        }

        /// <summary>
        /// 审批拒绝作业报告
        /// </summary>
        /// <param name="info">作业报告信息</param>
        /// <param name="user">操作的用户信息</param>
        [TransactionAspect]
        public void RejectDispatchReport(DispatchReportInfo info, UserInfo user)
        {
            info.Status.ID = DispatchReportInfo.DispatchReportStatus.New;
            this.dispatchReportDao.UpdateDispatchReport(info); 
            
            UpdateDispatchStatusByJournalAndReport(info.Dispatch.ID, user);

            HistoryInfo history = new HistoryInfo(info.ID, ObjectTypes.DispatchReport, user.ID, DispatchReportInfo.Actions.Reject, info.FujiComments);
            this.historyDao.AddHistory(history);
        }

        /// <summary>
        /// app审批通过作业报告
        /// </summary>
        /// <param name="info">作业报告信息</param>
        /// <param name="user">操作的用户信息</param>
        [TransactionAspect]
        public void PassDispatchReport4App(DispatchReportInfo info, UserInfo user)
        {
            info.Status.ID = DispatchInfo.DocStatus.Approved;
            SaveDispatchReport4App(info, user);

            HistoryInfo history = new HistoryInfo(info.ID, ObjectTypes.DispatchReport, user.ID, DispatchReportInfo.Actions.Pass, info.FujiComments);
            this.historyDao.AddHistory(history);

            UpdateDispatchStatusByJournalAndReport(info.Dispatch.ID, user);
        }

        /// <summary>
        /// app审批拒绝作业报告
        /// </summary>
        /// <param name="info">作业报告信息</param>
        /// <param name="user">操作的用户信息</param>
        [TransactionAspect]
        public void RejectDispatchReport4App(DispatchReportInfo info, UserInfo user)
        {
            info.Status.ID = DispatchReportInfo.DispatchReportStatus.New;
            SaveDispatchReport4App(info, user);
           
            UpdateDispatchStatusByJournalAndReport(info.Dispatch.ID, user);

            HistoryInfo history = new HistoryInfo(info.ID, ObjectTypes.DispatchReport, user.ID, DispatchReportInfo.Actions.Reject, info.FujiComments);
            this.historyDao.AddHistory(history);
        }

        /// <summary>
        /// app保存作业报告
        /// </summary>
        /// <param name="dispatchReport">作业报告信息</param>
        /// <param name="user">操作的用户信息</param>
        /// <returns>作业报告编号</returns>
        [TransactionAspect]
        public int SaveDispatchReport4App(DispatchReportInfo dispatchReport, UserInfo user)
        {
            if (dispatchReport.ID > 0)
            {
                DispatchReportInfo exsistReport = GetDispatchReportByID(dispatchReport.ID);
                this.dispatchReportDao.UpdateDispatchReport(dispatchReport);
                
                if (dispatchReport.FileInfo != null && dispatchReport.FileInfo.ID <= 0)
                {
                    this.fileManager.DeleteUploadFileByID(ObjectTypes.DispatchReport, exsistReport.FileInfo.ID);
                }
                else if (dispatchReport.FileInfo == null)
                {
                    this.fileManager.DeleteUploadFileByID(ObjectTypes.DispatchReport, exsistReport.FileInfo.ID);
                }
                if (dispatchReport.ReportAccessories != null && dispatchReport.ReportAccessories.Count > 0)
                {
                    List<int> newIdList = SQLUtil.GetIDListFromObjectList(dispatchReport.ReportAccessories);

                    foreach (ReportAccessoryInfo info in (from ReportAccessoryInfo temp in exsistReport.ReportAccessories where !newIdList.Contains(temp.ID) select temp))
                    {
                        DeleteReportAccessory(info.ID);
                    }
                }
                else if ((dispatchReport.ReportAccessories == null || dispatchReport.ReportAccessories.Count == 0) && exsistReport.ReportAccessories.Count > 0)
                {
                    foreach (ReportAccessoryInfo info in exsistReport.ReportAccessories)
                    {
                        DeleteReportAccessory(info.ID);
                    }
                }
            }
            else
            {
                dispatchReport.ID = this.dispatchReportDao.AddDispatchReport(dispatchReport);
            }

            if (dispatchReport.FileInfo != null && !string.IsNullOrEmpty(dispatchReport.FileInfo.FileName) && dispatchReport.FileInfo.ID <= 0)
            {
                dispatchReport.FileInfo.ObjectID = dispatchReport.ID;
                dispatchReport.FileInfo.ObjectName = ObjectTypes.DispatchReport;
                this.fileManager.SaveUploadFile(dispatchReport.FileInfo);
            }
            if (dispatchReport.ReportAccessories != null && dispatchReport.ReportAccessories.Count > 0)
            {
                foreach (ReportAccessoryInfo info in (from ReportAccessoryInfo temp in dispatchReport.ReportAccessories where temp.ID <= 0 select temp))
                {
                    info.DispatchReportID = dispatchReport.ID;
                    SaveReportAccessory(info, info.FileInfos);
                }
            }

            if (dispatchReport.Status.ID == DispatchReportInfo.DispatchReportStatus.Pending)
            {
                UpdateDispatchStatusByJournalAndReport(dispatchReport.Dispatch.ID, user);

                HistoryInfo history = new HistoryInfo(dispatchReport.ID, ObjectTypes.DispatchReport, user.ID, DispatchReportInfo.Actions.Submit, dispatchReport.FujiComments);
                this.historyDao.AddHistory(history);
            }
            return dispatchReport.ID;
        }

        #endregion

        #region"ReportAccess"
        /// <summary>
        /// 保存零配件信息
        /// </summary>
        /// <param name="reportAccessory">零配件信息</param>
        /// <param name="fileReportAccessories">零配件附件信息</param>
        /// <returns>零配件信息</returns>
        [TransactionAspect]
        public ReportAccessoryInfo SaveReportAccessory(ReportAccessoryInfo reportAccessory, List<UploadFileInfo> fileReportAccessories)
        {
            reportAccessory.ID = this.dispatchReportDao.AddReportAccessory(reportAccessory);
            if (fileReportAccessories != null)
            {
                foreach (UploadFileInfo file in fileReportAccessories)
                {
                    file.ObjectID = reportAccessory.ID;
                    file.ObjectName = ObjectTypes.ReportAccessory;
                    file.ID = this.fileManager.SaveUploadFile(file).ID;
                    file.FileContent = "";
                }
                reportAccessory.FileInfos = fileReportAccessories;
            }
            return reportAccessory;
        }

        /// <summary>
        /// 删除零配件信息
        /// </summary>
        /// <param name="reportAccessoryID">零配件编号</param>
        [TransactionAspect]
        public void DeleteReportAccessory(int reportAccessoryID)
        {
            List<UploadFileInfo> accessoryFiles = this.fileDao.GetFiles(ObjectTypes.ReportAccessory, reportAccessoryID);
            if (accessoryFiles != null && accessoryFiles.Count > 0)
            {
                foreach (UploadFileInfo accessoryFile in accessoryFiles)
                {
                    this.fileManager.DeleteUploadFileByID(ObjectTypes.ReportAccessory, accessoryFile.ID);
                }
            }
            dispatchReportDao.DeleteReportAccessory(reportAccessoryID);
        }

        #endregion

    }
}

