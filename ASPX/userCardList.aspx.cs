using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 해당 유저의 카드 리스트를 불러오는 페이지 입니다.
public partial class userCardList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 넘겨받은 userKey를 추출
        string userKey = Request.Form["userKey"];

        // 쿼리문 작성
        string query = "EXEC [dbo].[userCardList] @userKey = '" + userKey + "'";

        // 쿼리 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        StringBuilder stringBuilder = new StringBuilder();
        foreach (DataRow dataRow in dataTable.Rows)
        {
            foreach (DataColumn dataColumn in dataTable.Columns)
            {
                stringBuilder.Append(dataRow[dataColumn]);
                stringBuilder.Append("$");
            }
        }

        // 마지막 구분자 제거
        stringBuilder.Remove(stringBuilder.Length - 1, 1);
        Response.Write(stringBuilder);
    }
}