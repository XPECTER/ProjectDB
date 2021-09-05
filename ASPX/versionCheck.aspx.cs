using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

public partial class versionCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string query = "EXEC [dbo].[versionCheck]";

        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        StringBuilder result = new StringBuilder();

        for (int i = 0; i < dataTable.Columns.Count; i++)
            result.Append(dataTable.Rows[0][i].ToString() + "$");

        result.Remove(result.Length - 1, 1);
        Response.Write(result.ToString());
    }
}