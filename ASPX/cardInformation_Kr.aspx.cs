using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

public partial class cardInformation_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // cardKey 추출
        string cardKey = Request.Form["cardKey"];

        // TEST
        // string cardKey = "9FB14E0123CA451F";

        // SQL문 작성, 카드키에 맞는 카드 정보를 찾음
        string query = "EXEC [dbo].[cardInformation_Kr] @cardKey='" + cardKey + "'";

        // SQL문 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        string result = null;

        for (int i = 0; i < dataTable.Columns.Count; i++)
            result += dataTable.Rows[0][i].ToString() + "$";

        // 마지막 구분자 삭제
        result = result.Remove(result.Length - 1);
        Response.Write(result);
    }
}