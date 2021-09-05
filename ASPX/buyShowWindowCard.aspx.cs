using System;
using DatabaseConnection;
using System.Data;
using System.IO;
using System.Text;

public partial class buyShowWindowCard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userKey = Request.Form["userKey"];
        string cardDefineKey = Request.Form["cardDefineKey"];
        string buyMoneyType = Request.Form["buyMoneyType"];
        //string showWindowNum = Request.Form["showWindowNum"];
        string orderNum = Request.Form["orderNum"];
        string price = Request.Form["price"];

        // 해당 슬롯 번호와 진열장 번호에 맞는 카드 정의 키를 '_'로 바꿈 
        string query = "EXEC [dbo].[buyShowWindowSlot" + orderNum + "] @userKey = '" + userKey
            + "', @showWindowNum = " + orderNum;

        string alterQuery = "EXEC [dbo].[buyShowWindowCard] @userKey = '" + userKey +"', @cardDefineKey = '"+ cardDefineKey +"'"
            + "";


        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);
        
        // 가격에 따른 소지금 차감
        query = "EXEC buyShowWindowCard @userKey = '" + userKey + "', @buyMoneyType = '"
            + buyMoneyType + "', @price = " + price;
        dataTable.Clear();
        dataTable = SetDatabase.SetDatabaseReader(query);
        
        // 진열장에서 고른 카드 정의 키를 가지고 실제 카드 생성
        query = "EXEC createCard @userKey = '" + userKey + "', @cardDefineKey = '"
            + cardDefineKey + "'";
        dataTable.Clear();
        dataTable = SetDatabase.SetDatabaseReader(query);
        dataTable.TableName = "createCard";

        Response.Write(dataTable.Rows[0]["RESULT"].ToString());
    }
}