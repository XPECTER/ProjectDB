using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

public partial class selectDungeonRank : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 변수 입력받을 변수
        string userKey = Request.Form["userKey"];
        string zoneDefineKey = Request.Form["zoneDefineKey"];
        string dungeonDefineKey = Request.Form["dungeonDefineKey"];

        // SQL문 작성
        string query = "EXEC selectDungeonRank @userKey = '" + userKey + "', @zoneDefineKey = '" + zoneDefineKey
            + "', @dungeonDefineKey = '" + dungeonDefineKey + "'";

        // SQL 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);
        dataTable.TableName = "dungeonRankTbl";

        string result = null;

        for (int i = 0; i < dataTable.Rows.Count; i++)
        {
            for (int j = 0; j < dataTable.Columns.Count; j++)
            {
                result += dataTable.Rows[i][j].ToString() + "$";
            }
        }

        result = result.Remove(result.Length - 1);
        Response.Write(result);
    }
}