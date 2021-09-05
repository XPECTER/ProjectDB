using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;
using System.Data.SqlClient;

public partial class databaseConnectionCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string query = "SELECT 1";

        DataTable dataTable = new DataTable();

        try {
            SetDatabase.SetDatabaseReader(query);
            Response.Write("success");
        }
        catch(SqlException se) {
            Response.Write("false");
        }

        dataTable.Dispose();
    }
}