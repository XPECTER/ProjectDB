using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 던전을 클리어 했을 떄 불러오는 페이지 입니다.
public partial class dungeonClear : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userKey = Request.Form["userKey"];
        string zoneDefineKey = Request.Form["zoneDefineKey"];
        string dungeonDefineKey = Request.Form["dungeonDefineKey"];
        string clearRank = Request.Form["clearRank"];
        string clearTime = Request.Form["clearTime"];

        string query = null;
        query =  "EXEC dungeonClear @userKey='" + userKey + "', @zoneDefineKey='" + zoneDefineKey
                + "', @dungeonDefineKey='" + dungeonDefineKey + "', @clearRank='" + clearRank 
                + "', @clearTime='" + clearTime + "'";

        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        Response.Write(dataTable.Rows[0]["RESULT"].ToString());
    }
}