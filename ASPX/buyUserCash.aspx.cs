using System;
using System.Data;
using DatabaseConnection;
using System.Text;

// loading page by creditcard
public partial class buyUserCash : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userKey = Request.Form["userKey"];
        string itemPackageKey = Request.Form["itemPackageDefineKey"];
        string query = "EXEC [dbo].[buyUserCash] @userKey = '" + userKey +"' @itemPackageDefineKey = '" + itemPackageKey +"'";
        
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        Response.Write(dataTable.Rows[0]["RESULT"].ToString());
    }
}