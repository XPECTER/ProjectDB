using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

public partial class challengeDeckRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userKey = Request.Form["userKey"];
        string query = "EXEC [dbo].[challengeDeckRegister] @userKey = '" + userKey + "'";

        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        string result = dataTable.Rows[0]["RESULT"].ToString();

        Response.Write(result);
    }
}