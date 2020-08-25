using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Windows.Forms;
using System.Drawing;
using System.IO;

namespace DataImport.Util
{
    public static class UIUtil
    {
        public static void ShowError(string message, string caption, bool topMost = false)
        {
            if (topMost == false)
                MessageBox.Show(message, caption, MessageBoxButtons.OK, MessageBoxIcon.Error);
            else
                MessageBox.Show(new Form() { TopMost = true }, message, caption, MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        public static void ShowWarning(string message, string caption, bool topMost = false)
        {
            if (topMost == false)
                MessageBox.Show(message, caption, MessageBoxButtons.OK, MessageBoxIcon.Warning);
            else
                MessageBox.Show(new Form() { TopMost = true }, message, caption, MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }

        public static void ShowInfo(string message, string caption, bool topMost = false)
        {
            if (topMost == false)
                MessageBox.Show(message, caption, MessageBoxButtons.OK, MessageBoxIcon.Information);
            else
                MessageBox.Show(new Form() { TopMost = true }, message, caption, MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        public static DialogResult ShowConfirm(string message, string caption, bool topMost = false)
        {
            if (topMost == false)
                return MessageBox.Show(message, caption, MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            else
                return MessageBox.Show(new Form() { TopMost = true }, message, caption, MessageBoxButtons.YesNo, MessageBoxIcon.Question);
        }

        public static DialogResult ShowConfirmCancel(string message, string caption, bool topMost = false)
        {
            if (topMost == false)
                return MessageBox.Show(message, caption, MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2);
            else
                return MessageBox.Show(new Form() { TopMost = true }, message, caption, MessageBoxButtons.OKCancel, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2);
        }

        public static Boolean CheckTextBoxEmpty(TextBox txtBox, String fieldName)
        {
            txtBox.Text = txtBox.Text.Trim();

            if (txtBox.Text == String.Empty)
            {
                MessageBox.Show(String.Format("Please enter {0}.", fieldName), "Input", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtBox.Focus();
                return false;
            }
            else
            {
                return true;
            }
        }

        public static Boolean CheckComboBoxSelected(ComboBox comboBox, String fieldName)
        {
            if (comboBox.SelectedIndex == -1)
            {
                MessageBox.Show(String.Format("Please select {0}.", fieldName), "Input", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                comboBox.Focus();
                return false;
            }
            else
            {
                return true;
            }
        }

        public static Boolean CheckNumericField(TextBox txtBox, string fieldName, int precision, bool notZero, double maxValue = 0)
        {
            double d;
            if (double.TryParse(txtBox.Text, out d) == false)
            {
                ShowWarning(string.Format("{0} should be a numeric value.", fieldName), "Warning");
                txtBox.Focus();
                return false;
            }

            if (precision > 0)
            {
                if (txtBox.Text.IndexOf(".") > -1)
                {
                    if (txtBox.Text.Substring(txtBox.Text.IndexOf(".") + 1).Length > precision)
                    {
                        ShowWarning(string.Format("{0} can have {1} precision.", fieldName, precision), "Warning");
                        txtBox.Focus();
                        return false;
                    }
                }
            }

            if (notZero == true)
            {
                if (Convert.ToDecimal(txtBox.Text) <= 0)
                {
                    ShowWarning(string.Format("{0} should be greater than zero.", fieldName), "Warning");
                    txtBox.Focus();
                    return false;
                }
            }

            if (maxValue > 0)
            {
                if (Convert.ToDouble(txtBox.Text) > maxValue)
                {
                    ShowWarning(string.Format("{0} should not exceeds {1}.", fieldName, maxValue), "Warning");
                    txtBox.Focus();
                    return false;
                }
            }

            return true;
        }

        public static void SetGridRowColor(DataGridView dgvLines)
        {
            for (int i = 0; i < dgvLines.Rows.Count; i++)
            {
                if (i % 2 == 0)
                {
                    dgvLines.Rows[i].DefaultCellStyle.BackColor = Color.White;
                }
                else
                {
                    dgvLines.Rows[i].DefaultCellStyle.BackColor = Color.WhiteSmoke;
                }
                dgvLines.Rows[i].HeaderCell.ToolTipText = (i + 1).ToString();
            }
        }

        public static void SetGridComboBoxDataSource(DataGridViewComboBoxColumn cb, DataTable dt, string valueMember, string displayMember = "", Boolean insertEmpty = false, string emptyValue = "", string emptyDisplay = "")
        {
            if (insertEmpty == true)
            {
                DataRow dr = dt.NewRow();
                dr[valueMember] = emptyValue;
                if (displayMember != "")
                    dr[displayMember] = emptyDisplay;
                dt.Rows.InsertAt(dr, 0);
            }

            cb.DataSource = dt;
            cb.ValueMember = valueMember;
            if (displayMember != "")
                cb.DisplayMember = displayMember;
        }

        public static void SetGridComboBoxDataSource(DataGridViewComboBoxColumn cb, List<string> items, Boolean insertEmpty = false)
        {
            if (insertEmpty == true)
            {
                items.Insert(0, string.Empty);
            }

            cb.Items.Clear();
            cb.Items.AddRange(items.ToArray());
        }

        public static void SetComboBoxDataSource(ComboBox cb, DataTable dt, string valueMember, string displayMember = "", Boolean insertEmpty = false, string emptyValue = "", string emptyDisplay = "")
        {
            if (insertEmpty == true)
            {
                DataRow dr = dt.NewRow();
                dr[valueMember] = emptyValue;
                if (displayMember != "")
                    dr[displayMember] = emptyDisplay;
                dt.Rows.InsertAt(dr, 0);
            }

            cb.DataSource = dt;
            cb.ValueMember = valueMember;
            if (displayMember != "")
                cb.DisplayMember = displayMember;

            cb.SelectedIndex = -1;
        }

        public static void SetComboBoxDataSource(ComboBox cb, List<string> items, Boolean insertEmpty = false)
        {
            if (insertEmpty == true)
            {
                items.Insert(0, string.Empty);
            }

            cb.Items.Clear();
            cb.Items.AddRange(items.ToArray());
            cb.SelectedIndex = -1;
        }

        public static void FormatDateTime4Grid(DataGridViewCellFormattingEventArgs e)
        {
            if (SQLUtil.TrimNull(e.Value) == string.Empty) return;

            DateTime d = (DateTime)e.Value;

            if (d == DateTime.MinValue)
                e.Value = "";
            else
                e.Value = d.ToShortDateString();

            e.FormattingApplied = true;
        }

        public static string RemoveLeadingZero(string key)
        {
            return key.TrimStart('0');
        }

        public static Boolean IsInteger(char key)
        {
            if (((int)(key) >= 48 && (int)(key) <= 57) || (int)(key) == 8)
                return true;
            else
                return false;
        }

        public static Boolean IsDouble(char key)
        {
            if (((int)(key) >= 48 && (int)(key) <= 57) || (int)(key) == 8 || (int)(key) == 46)
                return true;
            else
                return false;
        }

        public static Boolean IsChar(char key)
        {
            if (((int)(key) >= 65 && (int)(key) <= 90) || (int)(key) == 8)
                return true;
            else if ((int)(key) >= 97 && (int)(key) <= 122)
                return true;
            else
                return false;
        }

        public static void CheckFolderExist(string folderPath)
        {
            if (Directory.Exists(folderPath) == false)
            {
                Directory.CreateDirectory(folderPath);
            }
        }
    }
}
