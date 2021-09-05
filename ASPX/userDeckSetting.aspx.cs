using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;

// 덱 세팅 페이지에서 유저가 덱 세팅을 완료했을 때 불러오는 페이지 입니다.
public partial class userDeckSetting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // 넘겨받은 유저키와 덱 번호, 덱에 사용된 카드들의 카드키를 추출합니다.
        string userKey = Request.Form["userKey"];
        string deckNum = Request.Form["deckNum"];
        string cardKey_0 = Request.Form["cardKey_0"];
        string cardKey_1 = Request.Form["cardKey_1"];
        string cardKey_2 = Request.Form["cardKey_2"];
        string cardKey_3 = Request.Form["cardKey_3"];
        string cardKey_4 = Request.Form["cardKey_4"];
        string cardKey_5 = Request.Form["cardKey_5"];
        string cardKey_6 = Request.Form["cardKey_6"];
        string cardKey_7 = Request.Form["cardKey_7"];
        string cardKey_8 = Request.Form["cardKey_8"];
        string cardKey_9 = Request.Form["cardKey_9"];
        string cardKey_10 = Request.Form["cardKey_10"];
        string cardKey_11 = Request.Form["cardKey_11"];
        string cardKey_12 = Request.Form["cardKey_12"];
        string cardKey_13 = Request.Form["cardKey_13"];
        string cardKey_14 = Request.Form["cardKey_14"];
        string cardKey_15 = Request.Form["cardKey_15"];
        string cardKey_16 = Request.Form["cardKey_16"];
        string cardKey_17 = Request.Form["cardKey_17"];
        string cardKey_18 = Request.Form["cardKey_18"];
        string cardKey_19 = Request.Form["cardKey_19"];
        string cardKey_20 = Request.Form["cardKey_20"];
        string cardKey_21 = Request.Form["cardKey_21"];
        string cardKey_22 = Request.Form["cardKey_22"];
        string cardKey_23 = Request.Form["cardKey_23"];
        string cardKey_24 = Request.Form["cardKey_24"];
        string cardKey_25 = Request.Form["cardKey_25"];
        string cardKey_26 = Request.Form["cardKey_26"];
        string cardKey_27 = Request.Form["cardKey_27"];
        string cardKey_28 = Request.Form["cardKey_28"];
        string cardKey_29 = Request.Form["cardKey_29"];
        string cardKey_30 = Request.Form["cardKey_30"];
        string cardKey_31 = Request.Form["cardKey_31"];
        string cardKey_32 = Request.Form["cardKey_32"];
        string cardKey_33 = Request.Form["cardKey_33"];
        string cardKey_34 = Request.Form["cardKey_34"];
        string cardKey_35 = Request.Form["cardKey_35"];
        string cardKey_36 = Request.Form["cardKey_36"];
        string cardKey_37 = Request.Form["cardKey_37"];
        string cardKey_38 = Request.Form["cardKey_38"];
        string cardKey_39 = Request.Form["cardKey_39"];
        string cardKey_40 = Request.Form["cardKey_40"];
        string cardKey_41 = Request.Form["cardKey_41"];
        string cardKey_42 = Request.Form["cardKey_42"];
        string cardKey_43 = Request.Form["cardKey_43"];
        string cardKey_44 = Request.Form["cardKey_44"];
        string cardKey_45 = Request.Form["cardKey_45"];
        string cardKey_46 = Request.Form["cardKey_46"];
        string cardKey_47 = Request.Form["cardKey_47"];
        string cardKey_48 = Request.Form["cardKey_48"];
        
        // 쿼리문 작성
        string query = "EXEC userDeckSetting @userKey= '" + userKey + "', @deckNum = " + deckNum
            + ", @cardKey_0 = '" + cardKey_0 + "', @cardKey_1 = '" + cardKey_1
            + "', @cardKey_2 = '" + cardKey_2 + "', @cardKey_3 = '" + cardKey_3
            + "', @cardKey_4 = '" + cardKey_4 + "', @cardKey_5 = '" + cardKey_5 
            + "', @cardKey_6 = '" + cardKey_6 + "', @cardKey_7 = '" + cardKey_7
            + "', @cardKey_8 = '" + cardKey_8 + "', @cardKey_9 = '" + cardKey_9 
            + "', @cardKey_10 = '" + cardKey_10 + "', @cardKey_11 = '" + cardKey_11
            + "', @cardKey_12 = '" + cardKey_12 + "', @cardKey_13 = '" + cardKey_13 
            + "', @cardKey_14 = '" + cardKey_14 + "', @cardKey_15 = '" + cardKey_15
            + "', @cardKey_16 = '" + cardKey_16 + "', @cardKey_17 = '" + cardKey_17 
            + "', @cardKey_18 = '" + cardKey_18 + "', @cardKey_19 = '" + cardKey_19
            + "', @cardKey_20 = '" + cardKey_20 + "', @cardKey_21 = '" + cardKey_21 
            + "', @cardKey_22 = '" + cardKey_22 + "', @cardKey_23 = '" + cardKey_23 
            + "', @cardKey_24 = '" + cardKey_24 + "', @cardKey_25 = '" + cardKey_25 
            + "', @cardKey_26 = '" + cardKey_26 + "', @cardKey_27 = '" + cardKey_27 
            + "', @cardKey_28 = '" + cardKey_28 + "', @cardKey_29 = '" + cardKey_29 
            + "', @cardKey_30 = '" + cardKey_30 + "', @cardKey_31 = '" + cardKey_31 
            + "', @cardKey_32 = '" + cardKey_32 + "', @cardKey_33 = '" + cardKey_33 
            + "', @cardKey_34 = '" + cardKey_34 + "', @cardKey_35 = '" + cardKey_35 
            + "', @cardKey_36 = '" + cardKey_36 + "', @cardKey_37 = '" + cardKey_37 
            + "', @cardKey_38 = '" + cardKey_38 + "', @cardKey_39 = '" + cardKey_39 
            + "', @cardKey_40 = '" + cardKey_40 + "', @cardKey_41 = '" + cardKey_41 
            + "', @cardKey_42 = '" + cardKey_42 + "', @cardKey_43 = '" + cardKey_43
            + "', @cardKey_44 = '" + cardKey_44 + "', @cardKey_45 = '" + cardKey_45 
            + "', @cardKey_46 = '" + cardKey_46 + "', @cardKey_47 = '" + cardKey_47 
            + "', @cardKey_48 = '" + cardKey_48 + "'";

        // 쿼리문 실행
        DataTable dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);
        dataTable.TableName = "RESULT";
        
        // 속도 문제로 XML을 일반 STRING으로 대체
        Response.Write(dataTable.Rows[0]["RESULT"].ToString());
        dataTable.Clear();

        // 쿼리문 실행 결과를 XML로 작성
        //StringWriter stringWriter = new StringWriter();
        //dataTable.WriteXml(stringWriter);
        //Response.ContentType = "text/xml";
        //Response.ContentEncoding = Encoding.UTF8;
        //Response.Write(stringWriter);
        //Response.Flush();
    }
}