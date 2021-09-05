using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// cardDefineTbl에 모든 레코드를 문자열로 바꿔서 리턴 
public partial class selectCardDefineList_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // query
        string query = "EXEC [dbo].[cardDefineList_Kr]";

        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        // dataTable을 StringBuilder로
        StringBuilder stringBuilder = new StringBuilder();
        foreach(DataRow dataRow in dataTable.Rows)
        {
            foreach(DataColumn dataColumn in dataTable.Columns)
            {
                stringBuilder.Append(dataRow[dataColumn]);
                stringBuilder.Append("$");
            }
        }

        // 마지막에 있는 구분자 제거
        stringBuilder.Remove(stringBuilder.Length-1, 1);
        Response.Write(stringBuilder);
    }
}