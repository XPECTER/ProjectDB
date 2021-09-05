using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 이 페이지는 구역(zone) 테이블의 모든 정보를 가져옵니다.
public partial class selectZoneList_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 쿼리문 작성
        string query = "EXEC zoneList_Kr";

        // 쿼리문 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);
        dataTable.TableName = "zoneDefineTbl_Kr";

        string result = null;

        // dataSet을 일반 string으로
        for (int i = 0; i < dataTable.Rows.Count; i++)
        {
            for (int j = 0; j < dataTable.Columns.Count; j++)
            {
                result += dataTable.Rows[i][j].ToString() + "$";
            }
        }

        // 끝에는 \가 없어야 한대요 ㅠㅁㅠ
        result = result.Remove(result.Length - 1);
        // 속도 문제로 XML대신 약속된 STRING형태로 작성
        Response.Write(result);

        // 쿼리문 실행 결과를 XML로 작성
        //StringWriter stringWriter = new StringWriter();
        //dataTable.WriteXml(stringWriter);
        //Response.ContentType = "text/xml";
        //Response.ContentEncoding = Encoding.UTF8;
        //Response.Write(stringWriter);
        //Response.Flush();
    }
}