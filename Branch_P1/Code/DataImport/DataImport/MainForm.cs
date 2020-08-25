using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using DataImport.Util;
using DataImport.Domain;
using DataImport.DataAccess;
using System.Data.OleDb;

namespace DataImport
{
    public partial class MainForm : Form
    {
        private LogFileWriter log = new LogFileWriter();

        private ImportDao importDao = new ImportDao();
        private QueryDao queryDao = new QueryDao();

        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            try
            {
                this.lblVersion.Text = "Version: " + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
                this.lblStatus.Text = "";
            }
            catch (Exception ex)
            {
                log.WriteLog("Error happened in Load event: " + ex.Message, ex.StackTrace);
                UIUtil.ShowError("Unexcepted Error happened: " + ex.Message, "Error");
                this.BeginInvoke(new MethodInvoker(this.Close));
            }
        }

        private void btnFileBrowse_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog ofd = new OpenFileDialog())
            {
                ofd.Multiselect = false;
                ofd.CheckFileExists = true;
                ofd.Filter = "Excel Worksheets 2007 (*.xlsx)|*.xlsx|Excel Worksheets 2003 (*.xls)|*.xls";
                if (ofd.ShowDialog() == DialogResult.OK)
                {
                    this.txtImportFile.Text = ofd.FileName;
                }
            }
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            try
            {
                this.btnImport.Enabled = false;
                this.UpdateStatus(string.Empty);

                if (UIUtil.CheckTextBoxEmpty(this.txtImportFile, this.lblImportFile.Text) == false) return;

                this.UpdateStatus("Verifying file...");
                FileInfo fileInfo = new FileInfo(this.txtImportFile.Text);
                if (VerifyFile(fileInfo) == false) return;

                this.Cursor = Cursors.WaitCursor;

                this.UpdateStatus("Parsing file...");
                Dictionary<string, List<EntityInfo>> dicList = null;
                if (ParseFile(fileInfo, out dicList) == false) return;

                this.UpdateStatus("Start importing file...");
                if (ImportData(dicList) == false) return;

                this.UpdateStatus("Successfully imported file");

                AutoGenerateRequests();

                this.UpdateStatus("Successfully finished all the work");
                UIUtil.ShowInfo("Successfully finished all the work.", "Succeed");  
            }
            catch (Exception ex)
            {
                log.WriteLog("Error happened in Import button: " + ex.Message, ex.StackTrace);
                UIUtil.ShowError("Unexcepted Error happened: " + ex.Message, "Error");
            }
            finally
            {
                this.btnImport.Enabled = true;
                this.Cursor = Cursors.Default;
            }
        }

        private void UpdateStatus(string message)
        {
            this.lblStatus.Text = message;
            this.statusStrip1.Refresh();
        }

        private bool VerifyFile(FileInfo fileInfo)
        {
            if (!fileInfo.Exists)
            {
                UIUtil.ShowWarning("Selected file does not exist.", "Select File");
                return false;
            }

            if (!fileInfo.Extension.Equals(".xls", StringComparison.OrdinalIgnoreCase) && !fileInfo.Extension.Equals(".xlsx", StringComparison.OrdinalIgnoreCase))
            {
                UIUtil.ShowWarning("Incorrect file extension.", "Select File");
                return false;
            }

            return true;
        }

        #region "import excel sheets"
        private const string SHEET_NAME_SUPPLIER = "Supplier";
        private const string SHEET_NAME_EQUIPMENT = "Equipment";
        private const string SHEET_NAME_CONTRACT = "Contract";
        private const string SHEET_NAME_CONTRACT_EQUIPMENT = "ContractEquipment";
        private const string SHEET_NAME_REQUEST = "Request";
        private const string SHEET_NAME_REQUEST_EQUIPMENT = "RequestEquipment";
        private const string SHEET_NAME_DISPATCH = "Assignment";
        private const string SHEET_NAME_DISPATCH_JOURNAL = "Voucher";
        private const string SHEET_NAME_DISPATCH_REPORT = "ServiceReport";
        private const string SHEET_NAME_REPORT_ACCESSORY = "SpareParts"; 
        private const string SHEET_NAME_INCOME = "Income";

        private List<string> _SheetNames = new List<string> { SHEET_NAME_SUPPLIER, SHEET_NAME_EQUIPMENT, SHEET_NAME_CONTRACT, SHEET_NAME_CONTRACT_EQUIPMENT,
                                                              SHEET_NAME_REQUEST, SHEET_NAME_REQUEST_EQUIPMENT, SHEET_NAME_DISPATCH,SHEET_NAME_DISPATCH_JOURNAL, 
                                                              SHEET_NAME_DISPATCH_REPORT, SHEET_NAME_REPORT_ACCESSORY, SHEET_NAME_INCOME };
        
        private bool ImportData(Dictionary<string, List<EntityInfo>> dicList)
        {
            try
            {
                if (this.cbCleanData.Checked)
                {
                    this.UpdateStatus("Clean existing data...");
                    importDao.CleanData();
                }

                foreach (string sheetName in _SheetNames)
                {
                    this.UpdateStatus(string.Format("Importing {0} data...", sheetName));

                    if (SHEET_NAME_SUPPLIER.Equals(sheetName))
                        importDao.ImportSupplier(dicList[sheetName]);
                    else if (SHEET_NAME_EQUIPMENT.Equals(sheetName))
                        importDao.ImportEquipment(dicList[sheetName]);
                    else if (SHEET_NAME_CONTRACT.Equals(sheetName))
                        importDao.ImportContract(dicList[sheetName]);
                    else if (SHEET_NAME_CONTRACT_EQUIPMENT.Equals(sheetName))
                        importDao.ImportContractEqpt(dicList[sheetName]);
                    else if (SHEET_NAME_REQUEST.Equals(sheetName))
                        importDao.ImportRequest(dicList[sheetName]);
                    else if (SHEET_NAME_REQUEST_EQUIPMENT.Equals(sheetName))
                        importDao.ImportRequestEqpt(dicList[sheetName]);
                    else if (SHEET_NAME_DISPATCH.Equals(sheetName))
                        importDao.ImportDispatch(dicList[sheetName]);
                    else if (SHEET_NAME_DISPATCH_JOURNAL.Equals(sheetName))
                        importDao.ImportDispatchJournal(dicList[sheetName]);
                    else if (SHEET_NAME_DISPATCH_REPORT.Equals(sheetName))
                        importDao.ImportDispatchReport(dicList[sheetName]);
                    else if (SHEET_NAME_REPORT_ACCESSORY.Equals(sheetName))
                        importDao.ImportReportAccessory(dicList[sheetName]);
                    else if (SHEET_NAME_INCOME.Equals(sheetName))
                        importDao.ImportServiceHis(dicList[sheetName]);
                }

                return true;
            }
            catch (Exception ex)
            {
                log.WriteLog("Error happened in importing the data: " + ex.Message, ex.StackTrace);
                UIUtil.ShowError("Unexcepted Error happened during importing the data: " + ex.Message, "Import Data");
                return false;
            }
        }

        private bool ParseFile(FileInfo fileInfo, out Dictionary<string, List<EntityInfo>> dicList)
        {
            dicList = new Dictionary<string, List<EntityInfo>>();
            try
            {
                Dictionary<string, DataTable> dicTable = new Dictionary<string, DataTable>();

                if (GetDataFromExcel(fileInfo.FullName, dicTable) == false) return false;

                List<EntityInfo> entityInfos = null;
                foreach (string sheetName in _SheetNames)
                {
                    entityInfos = new List<EntityInfo>();

                    foreach (DataRow dr in dicTable[sheetName].Rows)
                    {
                        if (SHEET_NAME_SUPPLIER.Equals(sheetName))
                            entityInfos.Add(new SupplierInfo(dr));
                        else if (SHEET_NAME_EQUIPMENT.Equals(sheetName))
                            entityInfos.Add(new EquipmentInfo(dr));
                        else if (SHEET_NAME_CONTRACT.Equals(sheetName))
                            entityInfos.Add(new ContractInfo(dr));
                        else if (SHEET_NAME_CONTRACT_EQUIPMENT.Equals(sheetName))
                            entityInfos.Add(new ContractEqptInfo(dr));
                        else if (SHEET_NAME_REQUEST.Equals(sheetName))
                            entityInfos.Add(new RequestInfo(dr));
                        else if (SHEET_NAME_REQUEST_EQUIPMENT.Equals(sheetName))
                            entityInfos.Add(new RequestEqptInfo(dr));
                        else if (SHEET_NAME_DISPATCH.Equals(sheetName))
                            entityInfos.Add(new DispatchInfo(dr));
                        else if (SHEET_NAME_DISPATCH_JOURNAL.Equals(sheetName))
                            entityInfos.Add(new DispatchJournalInfo(dr));
                        else if (SHEET_NAME_DISPATCH_REPORT.Equals(sheetName))
                            entityInfos.Add(new DispatchReportInfo(dr));
                        else if (SHEET_NAME_REPORT_ACCESSORY.Equals(sheetName))
                            entityInfos.Add(new ReportAccessoryInfo(dr));
                        else if (SHEET_NAME_INCOME.Equals(sheetName))
                            entityInfos.Add(new ServiceHisInfo(dr));
                    }

                    dicList.Add(sheetName, entityInfos);
                }

                return true;
            }
            catch (Exception ex)
            {
                log.WriteLog("Error happened in parsing the excel file: " + ex.Message, ex.StackTrace);
                UIUtil.ShowError("Unexcepted Error happened during parsing the excel file: " + ex.Message, "Parse Excel File");
                return false;
            }
        }

        private Boolean GetDataFromExcel(string filePath, Dictionary<string, DataTable> dicTable)
        {
            try
            {
                using (OleDbConnection conn = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties=\"Excel 12.0;HDR=YES;IMEX=1\""))
                {
                    DataTable dt = null;
                    foreach (string sheetName in _SheetNames)
                    {
                        dt = new DataTable();
                        using (OleDbDataAdapter da = new OleDbDataAdapter(string.Format("SELECT * FROM [{0}$]", sheetName), conn))
                        {
                            da.Fill(dt);

                            dicTable.Add(sheetName, dt);
                        }
                    }             
                }
            }
            catch (Exception e)
            {
                UIUtil.ShowError("Error happened during reading excel file: " + e.Message, "Read Excel File");
                log.WriteLog("GetDataFromExcel has error: " + e.Message, e.StackTrace);
                return false;
            }

            return true;
        }

        #endregion

        #region "Auto generate requests"
        private Random rd = null;

        private void AutoGenerateRequests()
        {
            List<EquipmentInfo> equipmentInfos = this.queryDao.GetEquipments();
            int nextRequestId = this.queryDao.GetMaxRequestID();
            int nextDispatchId = this.queryDao.GetMaxDispatchID();
            int nextDispatchReportId = this.queryDao.GetMaxDispatchReportID();

            DateTime minDate = equipmentInfos.Min(t => t.InstalEndDate);
            if (minDate < DateTime.Today.AddYears(-3)) minDate = DateTime.Today.AddYears(-3);
            minDate = new DateTime(minDate.Year, minDate.Month, 1);

            this.rd = new Random();
            this.UpdateStatus("Start auto generating 'Repair' requests for expense...");
            for (int i = minDate.Year; i <= DateTime.Today.Year; i++)
            {
                GenerateRequestRepair4Expense(ref nextRequestId, ref nextDispatchId, ref nextDispatchReportId, new DateTime(i, 1, 1));
            }

            this.UpdateStatus("Start auto generating 'Maintenance' requests...");
            for (int i = minDate.Year; i <= DateTime.Today.Year; i++)
            {
                GenerateRequestMaintenance(equipmentInfos, ref nextRequestId, ref nextDispatchId, new DateTime(i, 1, 1));
            }

            this.UpdateStatus("Start auto generating 'Regular Patrol' requests...");
            DateTime currentMonth = minDate;
            DateTime previousMonth = DateTime.Today.AddDays(0 - DateTime.Today.Day);
            int index = 0;
            while(currentMonth < previousMonth)
            {
                GenerateRequestRegularPatrol(GetThirdEquipments(equipmentInfos, index), ref nextRequestId, ref nextDispatchId, currentMonth);

                index++;
                if (index == 3) index = 0;

                currentMonth = currentMonth.AddMonths(1);
            }

            this.UpdateStatus("Start auto generating 'Repair' requests...");
            currentMonth = minDate;
            while (currentMonth < previousMonth)
            {
                GenerateRequestRepair(equipmentInfos, ref nextRequestId, ref nextDispatchId, currentMonth);

                currentMonth = currentMonth.AddMonths(1);
            }
        }

        private void GenerateRequestRepair4Expense(ref int nextRequestId, ref int nextDispatchId, ref int nextDispatchReportId, DateTime fromDate)
        {
            DateTime yearEnd = GetYearEndDate(fromDate);

            List<ServiceHisInfo> incomeInfos = this.queryDao.GetServiceHis(fromDate.Year);

            List<EntityInfo> requestInfos = new List<EntityInfo>();
            List<EntityInfo> requestEqupInfos = new List<EntityInfo>();
            List<EntityInfo> dispatchInfos = new List<EntityInfo>();
            List<EntityInfo> journalInfos = new List<EntityInfo>();
            List<EntityInfo> reportInfos = new List<EntityInfo>();
            List<EntityInfo> reportAccessoryInfos = new List<EntityInfo>();

            foreach (ServiceHisInfo info in incomeInfos)
            {
                nextRequestId++;
                RequestInfo requestInfo = new RequestInfo();
                requestInfo.ID = nextRequestId;
                requestInfo.RequestType.ID = RequestInfo.RequestTypes.Repair;
                requestInfo.Source.ID = 1;
                requestInfo.RequestUser.ID = 6;
                requestInfo.FaultDesc = "无法开机";
                requestInfo.Status.ID = 99;
                requestInfo.DealType.ID = 1;
                requestInfo.Priority.ID = 1;
                requestInfo.MachineStatus.ID = 1;
                requestInfo.RequestDate = GetRandom(fromDate, fromDate, yearEnd, yearEnd);
                requestInfo.RequestDate = requestInfo.RequestDate.AddHours(this.rd.Next(8, 14)).AddMinutes(this.rd.Next(0, 60));
                requestInfo.DistributeDate = requestInfo.RequestDate.AddMinutes(this.rd.Next(2, 5));
                requestInfo.ResponseDate = requestInfo.DistributeDate.AddMinutes(this.rd.Next(5, 10));             
                requestInfo.CloseDate = requestInfo.ResponseDate.AddMinutes(this.rd.Next(30, 60));

                requestInfos.Add(requestInfo);
                requestEqupInfos.Add(new RequestEqptInfo() { RequestID = requestInfo.ID, EquipmentID = info.EquipmentID });

                nextDispatchId++;
                DispatchInfo dispatchInfo = new DispatchInfo();
                dispatchInfo.ID = nextDispatchId;
                dispatchInfo.Request.ID = requestInfo.ID;
                dispatchInfo.RequestType.ID = requestInfo.RequestType.ID;
                dispatchInfo.Urgency.ID = 1;
                dispatchInfo.MachineStatus.ID = 1;
                dispatchInfo.Engineer.ID = 4;
                dispatchInfo.ScheduleDate = requestInfo.DistributeDate;
                dispatchInfo.Status.ID = 4;
                dispatchInfo.CreateDate = dispatchInfo.ScheduleDate;
                dispatchInfo.StartDate = requestInfo.ResponseDate;
                dispatchInfo.EndDate = requestInfo.CloseDate;
                dispatchInfos.Add(dispatchInfo);

                DispatchJournalInfo journalInfo = new DispatchJournalInfo();
                journalInfo.DispatchID = dispatchInfo.ID;
                journalInfo.FaultCode = "错误代码112";
                journalInfo.JobContent = "检查电源和操作系统";
                journalInfo.ResultStatus.ID = 2;
                journalInfo.Advice = "恢复出厂设置";
                journalInfo.UserName = "秦医生";
                journalInfo.UserMobile = "18866881888";
                journalInfo.Status.ID = 3;
                journalInfos.Add(journalInfo);

                nextDispatchReportId++;
                DispatchReportInfo reportInfo = new DispatchReportInfo();
                reportInfo.ID = nextDispatchReportId;
                reportInfo.DispatchID = dispatchInfo.ID;
                reportInfo.Type.ID = 1;
                reportInfo.FaultCode = "112";
                reportInfo.FaultDesc = "无法开机";
                reportInfo.SolutionCauseAnalysis = "系统设置错误";
                reportInfo.SolutionWay = "恢复出厂设置";
                reportInfo.SolutionResultStatus.ID = 4;
                reportInfo.Status.ID = 3;
                reportInfos.Add(reportInfo);

                ReportAccessoryInfo accessoryInfo = new ReportAccessoryInfo();
                accessoryInfo.DispatchReportID = reportInfo.ID;
                accessoryInfo.Name = "监控";
                accessoryInfo.Source.ID = 1;
                accessoryInfo.SupplierID = 3;
                accessoryInfo.NewSerialCode = this.rd.Next(100000, 500000).ToString();
                accessoryInfo.OldSerialCode = this.rd.Next(500000, 1000000).ToString();
                accessoryInfo.Qty = 1;
                if (info.EquipmentID == 528)
                    accessoryInfo.Amount = this.rd.Next((int)(info.Income * 1.29), (int)(info.Income * 1.31));
                else 
                    accessoryInfo.Amount = this.rd.Next((int)(info.Income * 0.29), (int)(info.Income * 0.31));
                reportAccessoryInfos.Add(accessoryInfo);
            }

            this.importDao.ImportRequest(requestInfos);
            this.importDao.ImportRequestEqpt(requestEqupInfos);
            this.importDao.ImportDispatch(dispatchInfos);
            this.importDao.ImportDispatchJournal(journalInfos);
            this.importDao.ImportDispatchReport(reportInfos);
            this.importDao.ImportReportAccessory(reportAccessoryInfos);
        }

        private void GenerateRequestRepair(List<EquipmentInfo> equipmentInfos, ref int nextRequestId, ref int nextDispatchId, DateTime fromDate)
        {
            DateTime monthEnd = fromDate.AddMonths(1).AddDays(-1);

            List<EquipmentInfo> toProcessEquips = (from EquipmentInfo temp in equipmentInfos
                                                   where temp.InstalEndDate <= fromDate && (temp.ScrapDate == DateTime.MinValue || temp.ScrapDate >= monthEnd)
                                                   select temp).ToList();

            List<EntityInfo> requestInfos = new List<EntityInfo>();
            List<EntityInfo> requestEqupInfos = new List<EntityInfo>();
            List<EntityInfo> dispatchInfos = new List<EntityInfo>();
            List<EntityInfo> journalInfos = new List<EntityInfo>();
            List<EntityInfo> reportInfos = new List<EntityInfo>();

            int totalEquips = this.rd.Next(70, 80 + 1);
            int quickResponseEquips = (int)Math.Ceiling(totalEquips * 0.9) + 1;
            List<int> equipIndexs = new List<int>();
            int tryCount = 0;
            int rdMinutes = 0;
            while(tryCount < totalEquips * 2)
            {
                int rdIndex = this.rd.Next(0, toProcessEquips.Count);
                if (!equipIndexs.Contains(rdIndex))
                {
                    nextRequestId++;
                    RequestInfo requestInfo = new RequestInfo();
                    requestInfo.ID = nextRequestId;
                    requestInfo.RequestType.ID = RequestInfo.RequestTypes.Repair;
                    requestInfo.Source.ID = 1;
                    requestInfo.RequestUser.ID = 6;
                    requestInfo.FaultDesc = "无法开机";
                    requestInfo.Status.ID = 99;
                    requestInfo.DealType.ID = 1;
                    requestInfo.Priority.ID = 1;
                    requestInfo.MachineStatus.ID = 1;
                    requestInfo.RequestDate = GetRandom(fromDate, toProcessEquips[rdIndex].InstalEndDate, toProcessEquips[rdIndex].ScrapDate, monthEnd);
                    requestInfo.RequestDate = requestInfo.RequestDate.AddHours(this.rd.Next(8, 14)).AddMinutes(this.rd.Next(0, 60));
                    if (equipIndexs.Count <= quickResponseEquips)
                    {
                        rdMinutes = this.rd.Next(2, 5);
                        requestInfo.DistributeDate = requestInfo.RequestDate.AddMinutes(rdMinutes);
                        requestInfo.ResponseDate = requestInfo.DistributeDate.AddMinutes(this.rd.Next(5, 15 - rdMinutes));
                    }
                    else
                    {
                        rdMinutes = this.rd.Next(5, 10);
                        requestInfo.DistributeDate = requestInfo.RequestDate.AddMinutes(rdMinutes);
                        requestInfo.ResponseDate = requestInfo.DistributeDate.AddMinutes(this.rd.Next(10, 30 - rdMinutes));
                    }
                    requestInfo.CloseDate = requestInfo.ResponseDate.AddMinutes(this.rd.Next(30, 60));

                    requestInfos.Add(requestInfo);
                    requestEqupInfos.Add(new RequestEqptInfo() { RequestID = requestInfo.ID, EquipmentID = toProcessEquips[rdIndex].ID });

                    nextDispatchId++;
                    DispatchInfo dispatchInfo = new DispatchInfo();
                    dispatchInfo.ID = nextDispatchId;
                    dispatchInfo.Request.ID = requestInfo.ID;
                    dispatchInfo.RequestType.ID = requestInfo.RequestType.ID;
                    dispatchInfo.Urgency.ID = 1;
                    dispatchInfo.MachineStatus.ID = 1;
                    dispatchInfo.Engineer.ID = 4;
                    dispatchInfo.ScheduleDate = requestInfo.DistributeDate;
                    dispatchInfo.Status.ID = 4;
                    dispatchInfo.CreateDate = dispatchInfo.ScheduleDate;
                    dispatchInfo.StartDate = requestInfo.ResponseDate;
                    dispatchInfo.EndDate = requestInfo.CloseDate;
                    dispatchInfos.Add(dispatchInfo);

                    DispatchJournalInfo journalInfo = new DispatchJournalInfo();
                    journalInfo.DispatchID = dispatchInfo.ID;
                    journalInfo.FaultCode = "错误代码112";
                    journalInfo.JobContent = "检查电源和操作系统";
                    journalInfo.ResultStatus.ID = 2;
                    journalInfo.Advice = "恢复出厂设置";
                    journalInfo.UserName = "秦医生";
                    journalInfo.UserMobile = "18866881888";
                    journalInfo.Status.ID = 3;
                    journalInfos.Add(journalInfo);

                    DispatchReportInfo reportInfo = new DispatchReportInfo();
                    reportInfo.DispatchID = dispatchInfo.ID;
                    reportInfo.Type.ID = 1;
                    reportInfo.FaultCode = "112";
                    reportInfo.FaultDesc = "无法开机";
                    reportInfo.SolutionCauseAnalysis = "系统设置错误";
                    reportInfo.SolutionWay = "恢复出厂设置";
                    reportInfo.SolutionResultStatus.ID = 4;
                    reportInfo.Status.ID = 3;
                    reportInfos.Add(reportInfo);

                    equipIndexs.Add(rdIndex);
                    if (equipIndexs.Count == totalEquips) break;
                }

                tryCount++;
            }

            this.importDao.ImportRequest(requestInfos);
            this.importDao.ImportRequestEqpt(requestEqupInfos);
            this.importDao.ImportDispatch(dispatchInfos);
            this.importDao.ImportDispatchJournal(journalInfos);
            this.importDao.ImportDispatchReport(reportInfos);
        }

        private void GenerateRequestMaintenance(List<EquipmentInfo> equipmentInfos, ref int nextRequestId, ref int nextDispatchId, DateTime fromDate)
        {
            List<EquipmentInfo> toProcessEquips = (from EquipmentInfo temp in equipmentInfos 
                                                   where temp.InstalEndDate <= fromDate && (temp.ScrapDate == DateTime.MinValue || temp.ScrapDate.Year >= fromDate.Year) select temp).ToList();

            List<EntityInfo> requestInfos = new List<EntityInfo>();
            List<EntityInfo> requestEqupInfos = new List<EntityInfo>();
            List<EntityInfo> dispatchInfos = new List<EntityInfo>();
            List<EntityInfo> journalInfos = new List<EntityInfo>();
            List<EntityInfo> reportInfos = new List<EntityInfo>();

            DateTime yearEnd = GetYearEndDate(fromDate);

            foreach(EquipmentInfo info in toProcessEquips)
            {
                nextRequestId ++;
                RequestInfo requestInfo = new RequestInfo();
                requestInfo.ID = nextRequestId;
                requestInfo.RequestType.ID = RequestInfo.RequestTypes.Maintain;
                requestInfo.Source.ID = 3;
                requestInfo.FaultType.ID = 1;
                requestInfo.FaultDesc = "运行缓慢";
                requestInfo.Status.ID = 99;
                requestInfo.DealType.ID = 1;
                requestInfo.Priority.ID = 1;
                requestInfo.RequestDate = GetRandom(fromDate, info.InstalEndDate, info.ScrapDate, yearEnd);
                requestInfo.DistributeDate = requestInfo.RequestDate.AddHours(this.rd.Next(8, 12)).AddMinutes(this.rd.Next(0, 60));
                requestInfo.ResponseDate = requestInfo.DistributeDate.AddMinutes(this.rd.Next(5, 30));
                requestInfo.CloseDate = requestInfo.DistributeDate.AddHours(this.rd.Next(2, 6)).AddMinutes(this.rd.Next(0, 60));

                requestInfos.Add(requestInfo);
                requestEqupInfos.Add(new RequestEqptInfo() { RequestID = requestInfo.ID, EquipmentID = info.ID });

                nextDispatchId++;
                DispatchInfo dispatchInfo = new DispatchInfo();
                dispatchInfo.ID = nextDispatchId;
                dispatchInfo.Request.ID = requestInfo.ID;
                dispatchInfo.RequestType.ID = requestInfo.RequestType.ID;
                dispatchInfo.Urgency.ID = 1;
                dispatchInfo.MachineStatus.ID = 3;
                dispatchInfo.Engineer.ID = 4;
                dispatchInfo.ScheduleDate = requestInfo.DistributeDate;
                dispatchInfo.Status.ID = 4;
                dispatchInfo.CreateDate = dispatchInfo.ScheduleDate;
                dispatchInfo.StartDate = requestInfo.ResponseDate;
                dispatchInfo.EndDate = requestInfo.CloseDate;
                dispatchInfos.Add(dispatchInfo);

                DispatchJournalInfo journalInfo = new DispatchJournalInfo();
                journalInfo.DispatchID = dispatchInfo.ID;
                journalInfo.FaultCode = "没问题";
                journalInfo.JobContent = "检查软件和设备";
                journalInfo.ResultStatus.ID = 2;
                journalInfo.UserName = "华医生";
                journalInfo.UserMobile = "18866868868";
                journalInfo.Status.ID = 3;
                journalInfos.Add(journalInfo);

                DispatchReportInfo reportInfo = new DispatchReportInfo();
                reportInfo.DispatchID = dispatchInfo.ID;
                reportInfo.Type.ID = 201;
                reportInfo.SolutionCauseAnalysis = "检查操作系统和设备";
                reportInfo.SolutionWay = "替换监控";
                reportInfo.ServiceProvider.ID = 1;
                reportInfo.SolutionResultStatus.ID = 4;
                reportInfo.Status.ID = 3;
                reportInfos.Add(reportInfo);
            }

            this.importDao.ImportRequest(requestInfos);
            this.importDao.ImportRequestEqpt(requestEqupInfos);
            this.importDao.ImportDispatch(dispatchInfos);
            this.importDao.ImportDispatchJournal(journalInfos);
            this.importDao.ImportDispatchReport(reportInfos);
        }

        private void GenerateRequestRegularPatrol(List<EquipmentInfo> equipmentInfos, ref int nextRequestId, ref int nextDispatchId, DateTime fromDate)
        {
            DateTime monthEnd = fromDate.AddMonths(1).AddDays(-1);

            List<EquipmentInfo> toProcessEquips = (from EquipmentInfo temp in equipmentInfos
                                                   where temp.InstalEndDate <= fromDate && (temp.ScrapDate == DateTime.MinValue || temp.ScrapDate >= monthEnd)
                                                   select temp).ToList();

            List<EntityInfo> requestInfos = new List<EntityInfo>();
            List<EntityInfo> requestEqupInfos = new List<EntityInfo>();
            List<EntityInfo> dispatchInfos = new List<EntityInfo>();
            List<EntityInfo> journalInfos = new List<EntityInfo>();
            List<EntityInfo> reportInfos = new List<EntityInfo>();

            foreach (EquipmentInfo info in toProcessEquips)
            {
                nextRequestId++;
                RequestInfo requestInfo = new RequestInfo();
                requestInfo.ID = nextRequestId;
                requestInfo.RequestType.ID = RequestInfo.RequestTypes.OnSiteInspection;
                requestInfo.Source.ID = 3;
                requestInfo.FaultDesc = "检查设备";
                requestInfo.Status.ID = 99;
                requestInfo.DealType.ID = 1;
                requestInfo.Priority.ID = 1;
                requestInfo.RequestDate = GetRandom(fromDate, fromDate, DateTime.MinValue, monthEnd);
                requestInfo.DistributeDate = requestInfo.RequestDate.AddHours(this.rd.Next(8, 12)).AddMinutes(this.rd.Next(0, 60));
                requestInfo.ResponseDate = requestInfo.DistributeDate.AddMinutes(this.rd.Next(5, 30));
                requestInfo.CloseDate = requestInfo.DistributeDate.AddHours(this.rd.Next(2, 6)).AddMinutes(this.rd.Next(0, 60));

                requestInfos.Add(requestInfo);

                requestEqupInfos.Add(new RequestEqptInfo() { RequestID = requestInfo.ID, EquipmentID = info.ID });

                nextDispatchId++;
                DispatchInfo dispatchInfo = new DispatchInfo();
                dispatchInfo.ID = nextDispatchId;
                dispatchInfo.Request.ID = requestInfo.ID;
                dispatchInfo.RequestType.ID = requestInfo.RequestType.ID;
                dispatchInfo.Urgency.ID = 1;
                dispatchInfo.MachineStatus.ID = 1;
                dispatchInfo.Engineer.ID = 4;
                dispatchInfo.ScheduleDate = requestInfo.DistributeDate;
                dispatchInfo.Status.ID = 4;
                dispatchInfo.CreateDate = dispatchInfo.ScheduleDate;
                dispatchInfo.StartDate = requestInfo.ResponseDate;
                dispatchInfo.EndDate = requestInfo.CloseDate;
                dispatchInfos.Add(dispatchInfo);

                DispatchJournalInfo journalInfo = new DispatchJournalInfo();
                journalInfo.DispatchID = dispatchInfo.ID;
                journalInfo.FaultCode = "检查设备";
                journalInfo.JobContent = "检查设备";
                journalInfo.ResultStatus.ID = 2;
                journalInfo.UserName = "李医生";
                journalInfo.UserMobile = "18866988878";
                journalInfo.Status.ID = 3;
                journalInfos.Add(journalInfo);

                DispatchReportInfo reportInfo = new DispatchReportInfo();
                reportInfo.DispatchID = dispatchInfo.ID;
                reportInfo.Type.ID = 401;
                reportInfo.SolutionCauseAnalysis = "检查设备";
                reportInfo.SolutionWay = "没问题";
                reportInfo.ServiceProvider.ID = 1;
                reportInfo.SolutionResultStatus.ID = 4;
                reportInfo.Status.ID = 3;
                reportInfos.Add(reportInfo);
            }

            this.importDao.ImportRequest(requestInfos);
            this.importDao.ImportRequestEqpt(requestEqupInfos);
            this.importDao.ImportDispatch(dispatchInfos);
            this.importDao.ImportDispatchJournal(journalInfos);
            this.importDao.ImportDispatchReport(reportInfos);
        }

        private List<EquipmentInfo> GetThirdEquipments(List<EquipmentInfo> equipmentInfos, int index)
        {
            int thirdOfEquipCount = equipmentInfos.Count / 3;

            List<EquipmentInfo> toProcessEquips = null;
            if (index == 0 || index == 3)
            {
                toProcessEquips = equipmentInfos.GetRange(0, thirdOfEquipCount);
            }
            else  if (index == 1)
            {
                toProcessEquips = equipmentInfos.GetRange(thirdOfEquipCount, thirdOfEquipCount);
            }
            else
            {
                toProcessEquips = equipmentInfos.GetRange(thirdOfEquipCount * 2, equipmentInfos.Count - thirdOfEquipCount * 2);
            }
            return toProcessEquips;
        }

        private DateTime GetYearEndDate(DateTime fromDate)
        {
            if (fromDate.Year == DateTime.Today.Year)
                return DateTime.Today.AddDays(0 - DateTime.Today.Day);
            else
                return new DateTime(fromDate.Year, 12, 31);
        }

        private DateTime GetRandom(DateTime fromDate, DateTime installDate, DateTime scrapDate, DateTime toDate)
        {
            DateTime date1 = (fromDate > installDate) ? fromDate : installDate;
            DateTime date2 = (scrapDate == DateTime.MinValue || scrapDate > toDate) ? toDate : scrapDate;

            int days = (date2 - date1).Days;
            if (days > 1)
            {
                days = this.rd.Next(0, days);

                return date1.AddDays(days);
            }
            else
            {
                return date1;
            }
        }
        #endregion
    }
}
