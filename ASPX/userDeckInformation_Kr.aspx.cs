using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 해당 유저의 덱 정보를 불러오는 페이지 입니다.
public partial class deckInformation_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string userKey = "E3F55920C8"; 
		string userKey = Request.Form["userKey"];
        string query = "EXEC [dbo].[userDeckInformation_Kr] @userKey = '" + userKey + "'";

        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        StringBuilder result = new StringBuilder();

        foreach(DataRow dataRow in dataTable.Rows)
        {
            foreach(DataColumn dataColumn in dataTable.Columns)
            {
                result.Append(dataRow[dataColumn] + "$");
            }
        }

        result.Remove(result.Length - 1, 1);
        Response.Write(result.ToString());
    }
}
