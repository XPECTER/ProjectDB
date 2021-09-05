using System;
using DatabaseConnection;
using System.Data;
using System.IO;
using System.Text;

// 카드 합성시 호출되는 페이지입니다.
public partial class cardCompose : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 합성하려면 카드 2개가 있어야겠죠?
        string cardKey_1 = Request.Form["cardKey_1"];
        string cardKey_2 = Request.Form["cardKey_2"];

        // DB에서 테이블을 가져와야 하니까 dataTable을 선언합니다. 
        DataTable dataTable = new DataTable();
        string query = "EXEC 카드합성프로시저";
        dataTable = SetDatabase.SetDatabaseReader(query);

        // dataTable에 첫 번째열의 첫 번째 속성을 가져옵니다. 리턴되는 값은 카드가 합성되고 난 뒤의 define키겠죠.
        string composeResult = dataTable.Rows[0][0].ToString();
        Response.Write(composeResult);
    }
}