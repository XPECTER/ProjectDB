using System;
using DatabaseConnection;
using System.Data;
using System.Text;

public partial class selectItemDefineList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string query = "EXEC [dbo].[selectItemDefineList]";

        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        StringBuilder result = new StringBuilder();
        foreach(DataRow dataRow in dataTable.Rows)
        {
            foreach(DataColumn dataColumn in dataTable.Columns)
            {
                result.Append(dataRow[dataColumn]+ "$");
            } // end in foreach
        } // end out foreach

        result.Remove(result.Length - 1, 1);
        Response.Write(result.ToString());
    } // end Page_Load
}