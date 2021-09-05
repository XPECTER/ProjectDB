using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 최초 실행시 혹은 패치 후 미션 리스트를 불러오는 페이지 입니다.
public partial class selectMissionList_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 쿼리문 작성
        string query = "EXEC missionList_Kr";

        // 쿼리문 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);
        dataTable.TableName = "missionDefineTbl_Kr";

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