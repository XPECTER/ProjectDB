using System;
using DatabaseConnection;
using System.Data;
using System.IO;
using System.Text;

public partial class selectTicketList_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string query = "EXEC [dbo].[ticketList]";

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
        Response.Write(result);
    }
}