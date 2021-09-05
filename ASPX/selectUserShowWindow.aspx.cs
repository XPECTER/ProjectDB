using System;
using DatabaseConnection;
using System.Data;
using System.IO;
using System.Text;

public partial class selectUserShowWindow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userKey = Request.Form["userKey"];
        //string userKey = "E3F55920C8";
        string query = "EXEC [dbo].[selectUserShowWindow] @userKey = '" + userKey + "'";
        
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < dataTable.Columns.Count; i++)
            result.Append(dataTable.Rows[0][i].ToString() + "$");

        result.Remove(result.Length - 1, 1);
        Response.Write(result.ToString());
    }
}