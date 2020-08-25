using System;
using System.Text;
using System.IO;
using System.Windows.Forms;

namespace DataImport.Util
{
    public class LogFileWriter
    {
        private string logPath = System.AppDomain.CurrentDomain.BaseDirectory.ToString() + @"\logs\";

        public void WriteLog(string errMessage, string errDetail)
        {
            if (!Directory.Exists(logPath))
            {
                Directory.CreateDirectory(logPath);
            }

            using (StreamWriter writer = File.AppendText(Path.Combine(logPath, Application.ProductName + "_" + DateTime.Now.ToString("yyyyMMdd") + ".log")))
            {
                writer.WriteLine(DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss") + " " + errMessage);
                if (!string.IsNullOrEmpty(errDetail))
                    writer.WriteLine(errDetail);
            }
        }
    }
}
