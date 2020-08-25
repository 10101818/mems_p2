using System;
using System.Text;
using System.Collections.Generic;
using System.Data;
using System.Collections;

namespace DataImport.Util
{
    public static class SQLUtil
    {
        public static String TrimNull(Object obj)
        {
            if (obj == DBNull.Value)
                return "";
            else if (obj == null)
                return "";
            else
                return obj.ToString().Trim();
        }

        public static Boolean ConvertBoolean(Object obj)
        {
            if (obj == DBNull.Value || obj == null)
                return false;
            else if (TrimNull(obj) == "1")
                return true;
            else if (TrimNull(obj) == "0")
                return false;
            else
                return Convert.ToBoolean(obj);
        }

        public static double ConvertDouble(Object obj)
        {
            if (obj == DBNull.Value || obj == null)
                return 0;
            else if (TrimNull(obj) == "")
                return 0;
            else
                return Convert.ToDouble(obj);
        }

        public static int ConvertInt(Object obj)
        {
            if (obj == DBNull.Value || obj == null)
                return 0;
            else if (TrimNull(obj) == "")
                return 0;
            else
                return Convert.ToInt32(obj);
        }

        public static long ConvertLong(Object obj)
        {
            if (obj == DBNull.Value || obj == null)
                return 0;
            else
                return Convert.ToInt64(obj);
        }

        public static int ConvertIntFromDouble(Object obj)
        {
            if (obj == DBNull.Value || obj == null)
                return 0;
            else
                return (int)Convert.ToDouble(obj);
        }

        public static long ConvertLongFromDouble(Object obj)
        {
            if (obj == DBNull.Value || obj == null)
                return 0;
            else
                return (long)Convert.ToDouble(obj);
        }

        public static String ConvertDateTimeString(Object obj)
        {
            if (obj == DBNull.Value || obj == null)
                return "";
            else
                return Convert.ToDateTime(obj).ToShortDateString();
        }

        public static DateTime ConvertDateTime(object obj)
        {
            if (obj == DBNull.Value || obj == null)
                return DateTime.MinValue;
            else
                return Convert.ToDateTime(obj);
        }

        public static string ConvertToInStr(List<long> values)
        {
            string inStr = "";
            foreach (long value in values)
            {
                if (inStr.Length > 0)
                    inStr += ",";
                inStr += value.ToString();
            }

            return inStr;
        }

        public static string ConvertToInStr(List<string> values)
        {
            string inStr = "";
            foreach (string value in values)
            {
                if (inStr.Length > 0)
                    inStr += ",";
                inStr += "'" + value + "'";
            }

            return inStr;
        }

        public static string ConvertToStr(List<string> values)
        {
            string inStr = "";
            foreach (string value in values)
            {
                if (inStr.Length > 0)
                    inStr += ",";
                inStr += value;
            }

            return inStr;
        }

        public static List<string> GetValueListFromObjectList(IList objects, string valueFeildName = "Value")
        {
            List<string> strs = new List<string>();

            foreach (Object obj in objects)
            {
                strs.Add((string)obj.GetType().GetProperty(valueFeildName).GetValue(obj, null));
            }

            return strs;
        }

        public static List<string> GetStringListFromDataTable(DataTable dt, string fieldName = "")
        {
            List<string> results = new List<string>();

            foreach (DataRow dr in dt.Rows)
            {
                if (fieldName == "")
                    results.Add(TrimNull(dr[0]));
                else
                    results.Add(TrimNull(dr[fieldName]));
            }

            return results;
        }

        public static List<int> GetIDListFromDataTable(DataTable dt, string idFeildName = "ID")
        {
            List<int> ids = new List<int>();
            int id;
            foreach (DataRow dr in dt.Rows)
            {
                id = SQLUtil.ConvertInt(dr[idFeildName]);

                if (!ids.Contains(id)) ids.Add(id);
            }

            return ids;
        }

        public static List<int> GetIDListFromObjectList(IList objects, string idFeildName = "ID")
        {
            List<int> ids = new List<int>();
            int id;
            foreach (Object obj in objects)
            {
                id = (int)obj.GetType().GetProperty(idFeildName).GetValue(obj, null);

                if (!ids.Contains(id)) ids.Add(id);
            }

            return ids;
        }

        #region "Return DBNull"
        public static object EmptyStringToNull(string strData)
        {
            if (string.IsNullOrEmpty(strData))
                return DBNull.Value;
            else
                return strData.Trim();
        }

        public static object ZeroToNull(int intData)
        {
            if (intData == 0)
                return DBNull.Value;
            else
                return intData;
        }

        public static object MinDateToNull(DateTime daData)
        {
            if (daData == DateTime.MinValue)
                return DBNull.Value;
            else
                return daData;
        }

        public static object FalseToNull(bool boolData)
        {
            if (boolData == false)
                return DBNull.Value;
            else
                return boolData;
        }

        public static object NullToDBNull(object objData)
        {
            if (objData == null)
                return DBNull.Value;
            else
                return objData;
        }
        #endregion
    }
}
