using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

public partial class sellCard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // userKey 추출
        string userKey = Request.Form["userKey"];

        // cardKey 추출. Client에서 ,(콤마)로 붙여서 최대 10개까지 준다
        string cardKey = Request.Form["cardKey"];
        

        // ,(콤마)로 이어진 문자열에 ,를 공백으로 치환
        cardKey = cardKey.Replace(",", " ");
        // 공백 단위로 끊어서 배열에 저장
        string[] cardKeys;
        cardKeys = cardKey.Split(' ');

        // 받은 카드의 개수만큼 프로시저 실행 후 판매가격 합산
        string query = null;
        DataTable dataTable = new DataTable();
        int totalPrice = 0;

        // 입력받은 카드의 수 만큼 프로시저 실행
        for (int i = 0; i < cardKeys.Length; i++)
        {
            // 이 쿼리는 보유한 카드를 삭제하면서 해당 금액을 반환한다. totalPrice에 누적
            query = "EXEC sellCard @userKey='" + userKey + "', @cardKey='" + cardKeys[i] + "'";
            dataTable = SetDatabase.SetDatabaseReader(query);
            totalPrice += int.Parse(dataTable.Rows[0]["obtainableSellUserGold"].ToString());
        }

        // 이 쿼리는 판매 누적 금액을 업데이트 하는 쿼리문이다.
        query = "EXEC caculateSellCard @userKey = '" + userKey + "', @totalPrice = " + totalPrice;
        dataTable = SetDatabase.SetDatabaseReader(query);

        Response.Write(dataTable.Rows[0]["RESULT"].ToString());
        dataTable.Clear();
    }
}