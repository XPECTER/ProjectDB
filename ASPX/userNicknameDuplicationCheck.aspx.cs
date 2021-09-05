using System;
using DatabaseConnection;
using System.Data;
using System.IO;
using System.Text;

public partial class userNicknameDuplicationCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 변수 추출
        string userNickname = Request.Form["userNickname"];

        // TEST용
        //string userNickname = "TEST";

        // 쿼리문 작성
        string query = "EXEC userNicknameDuplicationCheck @userNickname = '" + userNickname + "'";

        // 쿼리 결과 정제
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);
        dataTable.TableName = "userTbl";

        // 속도 문제로 XML을 일반 STRING으로 대체
        Response.Write(dataTable.Rows[0]["RESULT"].ToString());
        dataTable.Clear();

        // 쿼리 결과를 XML로 작성
        //StringWriter stringWriter = new StringWriter();
        //dataTable.WriteXml(stringWriter);
        //Response.ContentType = "text/xml";
        //Response.ContentEncoding = Encoding.UTF8;
        //Response.Write(stringWriter);
        //Response.Flush();
    }
}