using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 최초 실행시 혹은 패치 후 처음 실행 시 던전 목록을 불러오는 페이지 입니다.
public partial class selectDungeonList_Kr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 쿼리문 작성
        string query = "EXEC [dbo].[dungeonList_Kr]";

        // 쿼리문 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        StringBuilder result = new StringBuilder();

        foreach (DataRow dataRow in dataTable.Rows)
        {
            foreach (DataColumn dataColumn in dataTable.Columns)
            {
                result.Append(dataRow[dataColumn] + "$");
            }
        }

        result.Remove(result.Length - 1, 1);
        Response.Write(result.ToString());
    }
}