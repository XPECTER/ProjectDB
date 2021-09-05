using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

public partial class selectFuncDefineList_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 쿼리문 작성
        string query = "EXEC selectCardSkillDefineList_Kr";

        // 쿼리문 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);
        
        // 12000개 레코드 변환시간 : 5s
        StringBuilder stringBuilder = new StringBuilder();
        foreach(DataRow dataRow in dataTable.Rows)
        {
            foreach(DataColumn dataColumn in dataTable.Columns)
            {
                stringBuilder.Append(dataRow[dataColumn]);
                stringBuilder.Append("$");
            }
        }

        // 맨 끝에 있는 구분자 제거
        stringBuilder.Remove(stringBuilder.Length-1, 1);
        Response.Write(stringBuilder);
    }
}