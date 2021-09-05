using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 이 페이지는 유저가 로그인을 했을 때 실행되는 페이지 입니다.
public partial class userLogIn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 아이디와 비밀번호를 추출
        string userId = Request.Form["userId"];
        string userPassword = Request.Form["userPassword"];
        //string version = Request.Form["version"];

        // test
        //string userId = "kongjy007@naver.com";
        //string userPassword = "11111111";

        DataTable dataTable = new DataTable();
        //string query = "SELECT version FROM versionTbl ORDER BY ";
        //dataTable = SetDatabase.SetDatabaseReader(query);
        //string currentVersion = dataTable.Rows[0][0].ToString();

        // 쿼리문 작성
        string query = "EXEC userLogIn @userId='" + userId + "', @userPassword='" + userPassword + "'";

        // 쿼리문 실행
        dataTable = SetDatabase.SetDatabaseReader(query);

         string result = null;

         // 속도 문제로 인해 XML을 일반 string으로 대체. 구분자는 '\'를 사용한다.
         for (int i = 0; i < dataTable.Columns.Count; i++)
            result += dataTable.Rows[0][i].ToString() + "$";

         // 끝에는 \가 없어야 한대요 ㅠㅁㅠ
         result = result.Remove(result.Length - 1);
         Response.Write(result);
         dataTable.Clear();        
    }
}