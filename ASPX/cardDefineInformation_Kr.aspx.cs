using System;
using DatabaseConnection;
using System.Data;
using System.IO;
using System.Text;

public partial class cardDefineInformation_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 추출
        string cardDefineKey = Request.Form["cardDefineKey"];
        
        // TEST
        //string cardDefineKey = "10000000";

        // 쿼리 작성
        string query = "EXEC [dbo].[cardDefineInformation_Kr] @cardDefineKey = '" + cardDefineKey + "'";

        // 쿼리 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        // 내용 출력
        string result = null;

        for (int i = 0; i < dataTable.Columns.Count; i++)
            result += dataTable.Rows[0][i].ToString() + "$";

        result = result.Remove(result.Length - 1);
        Response.Write(result);

        /*//StringBuilder로 작성했는데 조회하는 레코드가 적으면 string이 더 빠르다.
        //string 0.006s : stringBuilder 0.019s
         * 
        StringBuilder stringBuilder = new StringBuilder();

        for (int i = 0; i < dataTable.Columns.Count; i++)
        {
            stringBuilder.Append(dataTable.Rows[0][i].ToString());
            stringBuilder.Append("$");
        }
        
        // 맨 마지막 구분자 삭제
        stringBuilder.Remove(stringBuilder.Length - 1, 1);
        Response.Write(stringBuilder);
        */
    }
}