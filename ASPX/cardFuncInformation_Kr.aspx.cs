using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

public partial class cardFuncInformation_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // cardSKillDefineKey를 추출
        string cardSkillDefineKey = Request.Form["cardSkillDefineKey"];

        // TEST
        //string cardSkillDefineKey = "a1";

        // SQL문 작성, 해당 스킬 정의 키로 스킬 정보를 검색
        string query = "EXEC [dbo].[cardSkillInformation_Kr] @cardSkillDefineKey = '" + cardSkillDefineKey + "'";

        // SQL문 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        StringBuilder result = new StringBuilder();

        for (int i = 0; i < dataTable.Columns.Count; i++)
            result.Append(dataTable.Rows[0][i].ToString() + "$");

        // 끝에는 \가 없어야 한대요 ㅠㅁㅠ
        result.Remove(result.Length - 1, 1);
        Response.Write(result.ToString());
    }
}