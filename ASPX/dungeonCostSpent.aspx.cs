using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 던전 코스트를 소비했을 때 불러오는 페이지 입니다/
public partial class dungeonCostSpent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 클라이언트가 보낸 변수 추출
        string userKey = Request.Form["userKey"];
        string dungeonCost = Request.Form["dungeonCost"];

        // TEST
        //string userKey = "E3F55920C8";
        //string dungeonCost = "3";

        // 쿼리문 작성
        string query = "EXEC dungeonCostSpent @userKey = '" + userKey + "', @dungeonCost = " + dungeonCost;

        // 쿼리문 실행, 불러온 테이블의 이름 설정
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);
        dataTable.TableName = "userGameTbl";

        Response.Write(dataTable.Rows[0]["RESULT"].ToString());

        // 쿼리문 실행 결과를 XML로 작성
        //StringWriter stringWriter = new StringWriter();
        //dataTable.WriteXml(stringWriter);
        //Response.ContentType = "text/xml";
        //Response.ContentEncoding = Encoding.UTF8;
        //Response.Write(stringWriter);
        //Response.Flush();
    }
}