using System;
using DatabaseConnection;
using System.Data;
using System.Text;

// Search my itemlist with amount
public partial class selectUserItemList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userKey =Request.Form["userKey"]; // Test userKey "E3F55920C8"
        string query = "EXEC [dbo].[userItemList] @userKey = '" + userKey +"'";

        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        StringBuilder result = new StringBuilder();
        foreach (DataRow dataRow in dataTable.Rows)
        {
            foreach (DataColumn dataColumn in dataTable.Columns)
            {
                result.Append(dataRow[dataColumn] + "$");
            } // end in foreach
        } // end out foreach

        result.Remove(result.Length - 1, 1);
        Response.Write(result.ToString());
    }
}