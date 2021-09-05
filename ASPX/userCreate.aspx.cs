using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 처음 온 유저가 회원가입을 할 때 불러오는 페이지 입니다.
public partial class userCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 처음온 유저의 아이디와 비밀번호를 추출
        string userId = Request.Form["userId"];
        string userPassword = Request.Form["userPassword"];
        string userNickname = Request.Form["userNickname"];

        // 쿼리문 작성
        StringBuilder alterQuery = new StringBuilder();
        alterQuery.Append("EXEC [dbo].[duplicationCheck] @userId = '");
        alterQuery.Append(userId);
        alterQuery.Append("', @userPassword = '");
        alterQuery.Append(userPassword);
        alterQuery.Append("', @userNickname = '");
        alterQuery.Append(userNickname + "'");

        // 쿼리문 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(alterQuery.ToString());

        Response.Write(dataTable.Rows[0][0].ToString());
    }
}