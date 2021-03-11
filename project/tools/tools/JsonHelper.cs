using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;

namespace tools
{
    /// <summary>
    /// json帮助类
    /// </summary>
    public class JsonHelper
    {
        /// <summary> 
        /// 对象转JSON 
        /// </summary> 
        /// <param name="obj">对象</param> 
        /// <param name="dateTimeFormat">时间序列化格式</param>
        /// <returns>JSON格式的字符串</returns> 
        public static string ObjectToJSON(object obj, string dateTimeFormat = "yyyy-MM-dd HH:mm:ss")
        {
            IsoDateTimeConverter timeFormat = new IsoDateTimeConverter();
            timeFormat.DateTimeFormat = dateTimeFormat;
            try
            {
                return JsonConvert.SerializeObject(obj, Formatting.Indented, timeFormat);
            }
            catch (Exception ex)
            {
                throw new Exception("JSONHelper.ObjectToJSON(): " + ex.Message);
            }
        }
        /// <summary>
        /// 对象转JSON
        /// </summary>
        /// <param name="obj">对象</param>
        /// <param name="PropSettings">属性设置</param>
        /// <returns>JSON格式的字符串</returns>
        public static string ObjectToJSON(object obj, JsonSerializerSettings PropSettings)
        {
            try
            {
                return JsonConvert.SerializeObject(obj, Formatting.Indented, PropSettings);
            }
            catch (Exception ex)
            {

                throw new Exception("JSONHelper.ObjectToJSON(): " + ex.Message);
            }
        }
        /// <summary> 
        /// 数据表转键值对集合 www.2cto.com  
        /// 把DataTable转成 List集合, 存每一行 
        /// 集合中放的是键值对字典,存每一列 
        /// </summary> 
        /// <param name="dt">数据表</param> 
        /// <returns>哈希表数组</returns> 
        public static List<Dictionary<string, object>> DataTableToList(DataTable dt)
        {
            List<Dictionary<string, object>> list
                 = new List<Dictionary<string, object>>();

            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, object> dic = new Dictionary<string, object>();
                foreach (DataColumn dc in dt.Columns)
                {
                    dic.Add(dc.ColumnName, dr[dc.ColumnName]);
                }
                list.Add(dic);
            }
            return list;
        }

        /// <summary> 
        /// 数据集转键值对数组字典 
        /// </summary> 
        /// <param name="dataSet">数据集</param> 
        /// <returns>键值对数组字典</returns> 
        public static Dictionary<string, List<Dictionary<string, object>>> DataSetToDic(DataSet ds)
        {
            Dictionary<string, List<Dictionary<string, object>>> result = new Dictionary<string, List<Dictionary<string, object>>>();

            foreach (DataTable dt in ds.Tables)
                result.Add(dt.TableName, DataTableToList(dt));

            return result;
        }

        /// <summary> 
        /// 数据表转JSON 
        /// </summary> 
        /// <param name="dataTable">数据表</param> 
        /// <returns>JSON字符串</returns> 
        public static string DataTableToJSON(DataTable dt)
        {
            return ObjectToJSON(DataTableToList(dt));
        }

        /// <summary> 
        /// JSON文本转对象,泛型方法 
        /// </summary> 
        /// <typeparam name="T">类型</typeparam> 
        /// <param name="jsonText">JSON文本</param> 
        /// <returns>指定类型的对象</returns> 
        public static T JSONToObject<T>(string jsonText)
        {
            try
            {
                if (string.IsNullOrEmpty(jsonText)) return default(T);
                return JsonConvert.DeserializeObject<T>(jsonText);
            }
            catch (Exception ex)
            {
                throw new Exception("JsonHelper.JSONToObject(): " + ex.Message);
            }
        }

        /// <summary>
        /// JSON文本转对象集合,泛型方法 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="jsonText"></param>
        /// <returns></returns>
        public static List<T> JSONToObjects<T>(string jsonText)
        {
            try
            {
                return JsonConvert.DeserializeObject<List<T>>(jsonText);
            }
            catch (Exception ex)
            {
                throw new Exception("JsonHelper.JSONToObject(): " + ex.Message);
            }
        }

        /// <summary> 
        /// 将JSON文本转换为数据表数据 
        /// </summary> 
        /// <param name="jsonText">JSON文本</param> 
        /// <returns>数据表字典</returns> 
        public static Dictionary<string, List<Dictionary<string, object>>> TablesDataFromJSON(string jsonText)
        {
            return JSONToObject<Dictionary<string, List<Dictionary<string, object>>>>(jsonText);
        }

        /// <summary> 
        /// 将JSON文本转换成数据行 
        /// </summary> 
        /// <param name="jsonText">JSON文本</param> 
        /// <returns>数据行的字典</returns> 
        public static Dictionary<string, object> DataRowFromJSON(string jsonText)
        {
            return JSONToObject<Dictionary<string, object>>(jsonText);
        }
        #region 生产datagrid
        /// <summary>
        /// datatable数据转成标准的easyui datagrid 数据格式
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string DtToDataGrid(DataTable dt)
        {
            var datastr = "{\"total\":0,\"rows\":[]}";
            var dtstr = DataTableToJSON(dt);
            try
            {
                datastr = "{\"total\":" + dt.Rows.Count + ",\"rows\":" + dtstr + "}";
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return datastr;
        }
        /// <summary>
        /// 实体对象集合数据转换成标准的easyui datagrid数据格式
        /// </summary>
        /// <typeparam name="T">实体类型</typeparam>
        /// <param name="entites">实体集合</param>
        /// <param name="total">集合总数</param>
        /// <param name="dateTimeFormat">时间格式设置</param>
        /// <returns></returns>
        public static string EntityToDataGrid<T>(IList<T> entites, int total, string dateTimeFormat = "yyyy-MM-dd")
        {
            string datastr = "{\"total\":0,\"rows\":[]}";
            try
            {
                string dtstr = ObjectToJSON(entites, dateTimeFormat);
                datastr = "{\"total\":" + total + ",\"rows\":" + dtstr + "}";
            }
            catch (Exception ex) { throw new Exception(ex.Message); }
            return datastr;
        }
        #endregion
        #region 生产JGrid

        public static string DataTable2Json(DataTable dt, int page, convertType type, string formatDateTime = "yyyy-MM-dd")
        {
            var jsonString = string.Empty;
            switch (type)
            {
                case convertType.Default:
                    jsonString = DataTable2Default(dt, formatDateTime);
                    break;
                case convertType.Table:
                    jsonString = DataTable2Table(dt, page, -1, formatDateTime);
                    break;
            }
            return jsonString;
        }

        public static string DataTable2Table(object dt, int page, long total = -1, string formatDateTime = "yyyy-MM-dd")
        {
            Hashtable ht = new Hashtable();
            ht["page"] =
            ht["total"] = total;
            ht["rows"] = dt;
            return JsonConvert.SerializeObject(ht, Formatting.Indented, new IsoDateTimeConverter { DateTimeFormat = formatDateTime });
        }

        private static string DataTable2Default(object dt, string formatDateTime = "yyyy-MM-dd")
        {
            return Newtonsoft.Json.JsonConvert.SerializeObject(dt, Formatting.None, new IsoDateTimeConverter { DateTimeFormat = formatDateTime });

        }
        public static string FlexiGridJson<T>(IList<T> list, int page, long total = -1, string isDisabled = null)
        {
            DataTable dt = GetDataTableFromIList<T>(list.ToList());
            StringBuilder jsonBuilder = new StringBuilder();
            //  ht["page"] =
            //ht["total"] = total;
            //  ht["rows"] = dt;
            jsonBuilder.Append("{\"page\":");
            jsonBuilder.Append(page + ",\"total\":");
            jsonBuilder.Append(total + ",\"rows\":");
            jsonBuilder.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                jsonBuilder.Append("\"check\":\"<input type='checkbox' class='checkboxes' name='ids' value='");
                jsonBuilder.Append(dt.Rows[i][0].ToString() + "'");
                jsonBuilder.Append(isDisabled != dt.Rows[i][0].ToString() ? "" : "disabled");
                jsonBuilder.Append("/>\",");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }

            if (dt.Rows.Count != 0)
            {
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            }
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();

        }

        public static string FlexiGridToJson<T>(DataTable dt, int page, long total = -1, string isDisabled = null)
        {
            //DataTable dt = GetDataTableFromIList<T>(list.ToList());
            StringBuilder jsonBuilder = new StringBuilder();
            //  ht["page"] =
            //ht["total"] = total;
            //  ht["rows"] = dt;
            jsonBuilder.Append("{\"page\":");
            jsonBuilder.Append(page + ",\"total\":");
            jsonBuilder.Append(total + ",\"rows\":");
            jsonBuilder.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                jsonBuilder.Append("\"check\":\"<input type='checkbox' class='checkboxes' name='ids' value='");
                jsonBuilder.Append(dt.Rows[i][1].ToString() + "'");
                jsonBuilder.Append(isDisabled != dt.Rows[i][1].ToString() ? "" : "disabled");
                jsonBuilder.Append("/>\",");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }

            if (dt.Rows.Count != 0)
            {
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            }
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();

        }
        public static DataTable GetDataTableFromIList<T>(List<T> aIList)
        {

            DataTable _returnTable = new DataTable();
            if (aIList.Count > 0)
            {
                object _baseObj = aIList[0];
                System.Type objectType = _baseObj.GetType();
                PropertyInfo[] properties = objectType.GetProperties();
                DataColumn _col;
                foreach (PropertyInfo property in properties)
                {
                    _col = new DataColumn();
                    _col.ColumnName = (string)property.Name;
                    _col.DataType = property.PropertyType;
                    _returnTable.Columns.Add(_col);
                }
                DataRow _row;
                foreach (object objItem in aIList)
                {

                    _row = _returnTable.NewRow();
                    foreach (PropertyInfo property in properties)
                    {
                        _row[property.Name] = property.GetValue(objItem, null);

                    }
                    _returnTable.Rows.Add(_row);

                }
            }
            return _returnTable;
        }

        public enum convertType
        {
            Default, Table
        }
        #endregion

        public static DataTable JsonToDataTable(string strJson)

        {

            //转换json格式

            strJson = strJson.Replace(",\"", "*\"").Replace("\":", "\"#").ToString();

            //取出表名   

            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);

            string strName = rg.Match(strJson).Value;

            DataTable tb = null;

            //去除表名   

            strJson = strJson.Substring(strJson.IndexOf("[") + 1);

            strJson = strJson.Substring(0, strJson.IndexOf("]"));

            //获取数据   

            rg = new Regex(@"(?<={)[^}]+(?=})");

            MatchCollection mc = rg.Matches(strJson);

            for (int i = 0; i < mc.Count; i++)

            {

                string strRow = mc[i].Value;

                string[] strRows = strRow.Split('*');

                //创建表   

                if (tb == null)

                {

                    tb = new DataTable();

                    tb.TableName = strName;

                    foreach (string str in strRows)

                    {

                        var dc = new DataColumn();

                        string[] strCell = str.Split('#');

                        if (strCell[0].Substring(0, 1) == "\"")

                        {

                            int a = strCell[0].Length;

                            dc.ColumnName = strCell[0].Substring(1, a - 2);

                        }

                        else

                        {

                            dc.ColumnName = strCell[0];

                        }

                        tb.Columns.Add(dc);

                    }

                    tb.AcceptChanges();

                }

                //增加内容   

                DataRow dr = tb.NewRow();

                for (int r = 0; r < strRows.Length; r++)

                {

                    dr[r] = strRows[r].Split('#')[1].Trim().Replace("，", ",").Replace("：", ":").Replace("\"", "");

                }

                tb.Rows.Add(dr);

                tb.AcceptChanges();

            }

            return tb;

        }
    }
}

