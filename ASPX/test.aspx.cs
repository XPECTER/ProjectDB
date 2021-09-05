using System;
using System.Text;
using System.Data;
using DatabaseConnection;
using System.Collections.Generic;
using WELLalgorithm;
using ticketFactorSelect;
using alterDatabaseConnection;

public partial class test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string query = "EXEC [dbo].[itemAmountCheck] @userKey = '05D6CF81B6', @itemDefineKey = 'TK10000'";

        DataTable dataTable = new DataTable();
		dataTable = SetDatabase.SetDatabaseReader(query);
		Response.Write(dataTable.Rows[0]["RESULT"].ToString());
    }
}