using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;
using WELLalgorithm;
using ticketFactorSelect;

// 티켓을 사용했을 때 불러오는 페이지 입니다. 임시 테스트중
public partial class useTicketTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //gachaCount.Attributes["onKeyPress"] = "if((event.keyCode<48) || (event.keyCode>57)) {return false;}";
    }

    protected void commonGachaTest_Click(object sender, EventArgs e)
    {
        // 테스트용 티켓 키 TK000(모두 랜덤)
        string ticketDefineKey = "TK000";
        //string ticketDefineKey = Request.Form["ticketDefineKey"];

        string query = "SELECT * FROM ticketTestTbl WHERE ticketDefineKEy = '" + ticketDefineKey + "'";
        DataTable dataTable = SetDatabase.SetDatabaseReader(query);
        
        // CardTypeAndJob Select Part
        string[,] cardTypeAndJobArray = new string[2, 6];
        ////cardTypeAndJobArray = ticketFactor.cardTypeAndJobSelect(dataTable.Rows[0]["cardType"].ToString(), dataTable.Rows[0]["jobType"].ToString());
        
        // Card Rarity Select Part
        //List<uint> rarityList = new List<uint>();
        //rarityList = ticketFactor.raritySelect(dataTable.Rows[0]["rarity"].ToString());

        // Card Element Select Part
        List<uint> elementList = new List<uint>();
        elementList = ticketFactor.elementSelect(dataTable.Rows[0]["element"].ToString());

        // 위 조건에 맞는 카드 정의 키 6개 소환!
        List<string> cardDefineKeyList = new List<string>();
        string startSeason = dataTable.Rows[0]["startSeason"].ToString();
        string endSeason = dataTable.Rows[0]["endSeason"].ToString();

        //cardDefineKeyList = ticketFactor.cardDefineKeySelect(rarityList, cardTypeAndJobArray, 
        //    elementList, startSeason, endSeason);

        Response.Write("카드 정의 키 : ");
        foreach (string cardDefineKey in cardDefineKeyList)
            Response.Write(cardDefineKey.ToString() + ", ");
        Response.Write("<br/>");
    }

    /// <summary>
    /// 사용한 쿠폰에 따라 카드의 레어도를 결정합니다. 5성이 적어도 한 장 포함되어있다면
    /// 총 다섯 가지 경우(5성한 장, 5성 두 장, 5성 한 장과 4성 두 장, 5성 한 장과 4성 한 장)
    /// 중 한 가지가 선택되게 됩니다. 확률은 기획자가 테스트하며 조정됩니다.
    /// </summary>
    public static List<uint> raritySelect(string rarityFactor)
    {
        List<uint> rarityList = new List<uint>();
        uint firstDice = 0, secondDice = 0;

        // 고급 티켓 체크
        if (rarityFactor == "5")
        {
            rarityList.Add(5);
        }
        else if (rarityFactor == "4")
        {
            rarityList.Add(4);
        }

        // 첫 번째 주사위 롤!
        firstDice = WELL512.Next(1, 10001);
        // 5성 확률에 당첨되었다.
        if ((firstDice <= 10000 && firstDice > 9500) || rarityFactor == "5")
        {
            if (rarityList.Count == 0)
                rarityList.Add(5);

            // 두 번째 주사위 롤!
            secondDice = WELL512.Next(1, 10001);

            // 기존 5성에 4성이 한 장 추가(5, 4)
            if (secondDice > 0 && secondDice <= 4000)
                rarityList.Add(4);
            // 기존 5성에 4성이 두 장 추가(5, 4, 4)
            else if (secondDice > 4000 && secondDice <= 6000)
            {
                rarityList.Add(4); rarityList.Add(4);
            }
            // 기존 5성에 5성이 한 장 더 추가(5, 5)
            else if (secondDice > 6000 && secondDice <= 8000)
                rarityList.Add(5);
        }
        // 4성 확률에 당첨되었다.
        else if ((firstDice <= 9500 && firstDice > 8500) || rarityFactor == "4")
        {
            if (rarityList.Count == 0)
                rarityList.Add(4);

            // 두 번째 주사위 롤!
            secondDice = WELL512.Next(1, 10001);

            // 기존 4성에 4성이 한 장 추가(4, 4)
            if (secondDice > 0 && secondDice < 6000)
                rarityList.Add(4);
        }

        // 그 외 카드들의 레어도.
        for (int repeat = 0; rarityList.Count < 6; repeat++)
        {
            firstDice = 0;
            firstDice = WELL512.Next(1, 8501);

            if (firstDice > 0 && firstDice <= 3000)
                rarityList.Add(1);
            else if (firstDice > 3000 && firstDice <= 6500)
                rarityList.Add(2);
            else
                rarityList.Add(3);
        }
        return rarityList;
    }
}