using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;
using WELLalgorithm;
using ticketFactorSelect;

// 티켓을 사용했을 때 불러오는 페이지 입니다.
public partial class useTicket : System.Web.UI.Page
{
    private StringBuilder stringBuilder;
    private string ticketDefineKey;
    private string query;
    private DataTable dataTable;

    protected void Page_Load(object sender, EventArgs e)
    {
        // 클라이언트가 보낸 변수를 추출
        //string userKey = Request.Form["userKey"];
		//ticketDefineKey = Request.Form["ticketDefineKey"];

		// 테스트용
        string userKey = "05D6CF81B6";
        string ticketDefineKey = "TK000";

        // 쿼리문 작성 - 클라가 보내준 티켓을 가지고 있는지 먼저 체크, 쿼리문 실행
        query = "EXEC [dbo].[itemAmountCheck] @userKey = '" + userKey
            + "', @itemDefineKey = '" + ticketDefineKey + "'";
        dataTable = new DataTable();
        dataTable = SetDatabase.SetDatabaseReader(query);

        if (dataTable.Rows[0]["RESULT"].ToString() == "false")
        {
            Response.Write(dataTable.Rows[0]["RESULT"].ToString());
        }
        else if (dataTable.Rows[0]["RESULT"].ToString() == "success")
        {
            // 쿼리문 작성 - 티켓 정의 키에 대한 정보, 쿼리문 실행
            query = "EXEC selectTicket @ticketDefineKey = '" + ticketDefineKey + "'";
            dataTable = SetDatabase.SetDatabaseReader(query);

            // coupon parameters
            query = "SELECT [ticketDefineKey],[ticketName],[ticketDescription],[cardType],[rarity1],[rarity2],[element],[jobType],[startSeason],[endSeason],[oneStarProbability],[twoStarProbability],[threeStarProbability],[fourStarProbability],[fiveStarProbability],[ticketIcon] FROM [dbo].[ticketDefineTbl_Kr] WHERE ticketDefineKey = '" + ticketDefineKey + "'";
            //query = "SELECT [ticketDefineKey],[ticketName],[ticketDescription],[jobType],[jobTypeParameter],[element],[elementParameter],[rarity],[rarityParameter],[season],[seasonParameter],[ticketIcon] FROM [dbo].[ticketDefineTbl] WHERE ticketDefineKey = '" + ticketDefineKey + "'";
			
			dataTable = SetDatabase.SetDatabaseReader(query);
			string jobTypeFactor = dataTable.Rows[0]["jobType"].ToString();
			string cardTypeFactor = dataTable.Rows[0]["cardType"].ToString();
            string rarity1Factor = dataTable.Rows[0]["rarity1"].ToString();
            string rarity2Factor = dataTable.Rows[0]["rarity2"].ToString();
            string elementFactor = dataTable.Rows[0]["element"].ToString();
            string jobtypeFactor = dataTable.Rows[0]["jobtype"].ToString();
            string startSeason = dataTable.Rows[0]["startseason"].ToString();
            string endSeason = dataTable.Rows[0]["endseason"].ToString();
            double oneStarP = double.Parse(dataTable.Rows[0]["oneStarProbability"].ToString());
            double twoStarP = double.Parse(dataTable.Rows[0]["twoStarProbability"].ToString()); ;
            double threeStarP = double.Parse(dataTable.Rows[0]["threeStarProbability"].ToString()); ;
            double fourStarP = double.Parse(dataTable.Rows[0]["fourStarProbability"].ToString()); ;
            double fiveStarP = double.Parse(dataTable.Rows[0]["fiveStarProbability"].ToString());

            // static probability
            dataTable.Clear();
            query = "select [bonusfourStarProbability],[bonusfiveStarProbability],[leadercardprobability],[unitcardprobability],[spellcardprobability],[landcardprobability]  from [dbo].[gachaprobabilitydefinetbl]";
            dataTable = SetDatabase.SetDatabaseReader(query);
            double bonusFourStarP = double.Parse(dataTable.Rows[0]["bonusfourStarProbability"].ToString());
            double bonusFiveStarP = double.Parse(dataTable.Rows[0]["bonusfiveStarProbability"].ToString());
            double leaderCardP = double.Parse(dataTable.Rows[0]["leadercardprobability"].ToString());
            double unitCardP = double.Parse(dataTable.Rows[0]["unitcardprobability"].ToString());
            double spellCardP = double.Parse(dataTable.Rows[0]["spellcardprobability"].ToString());
            double landCardP = double.Parse(dataTable.Rows[0]["landcardprobability"].ToString());

            // random parameters
            List<double> diceEyeList = new List<double>();
            List<uint> rarityList = new List<uint>();
            List<double> rarityBonusEyeList = new List<double>();
            List<uint> elementList = new List<uint>();
            List<string> cardDefineKeyList = new List<string>();
            string[,] cardTypeAndJobArray = new string[2, 6];
            List<double> cardTypeEyeList = new List<double>();

            diceEyeList = ticketFactor.diceEyeSelect(fiveStarP, fourStarP, threeStarP, twoStarP);
            rarityBonusEyeList = ticketFactor.bonusDiceEyeList(bonusFiveStarP, bonusFourStarP);
            cardTypeEyeList = ticketFactor.cardTypeEyeSelect(leaderCardP, unitCardP, spellCardP, landCardP);
			rarityList = ticketFactor.raritySelect(rarity1Factor, rarity2Factor, diceEyeList, rarityBonusEyeList);
            rarityList.Sort(); rarityList.Reverse();
            elementList = ticketFactor.elementSelect(elementFactor);
            cardTypeAndJobArray = ticketFactor.cardTypeAndJobSelect(cardTypeFactor, jobTypeFactor, cardTypeEyeList);
            
			stringBuilder = new StringBuilder();
            try
            {
                cardDefineKeyList = ticketFactor.cardDefineKeySelect(rarityList, cardTypeAndJobArray, elementList, startSeason, endSeason);

                dataTable.Clear();
                query = "EXEC [dbo].[insertShowWindow] @userKey = '" + userKey + "', @cardDefineKey_1 = '" + cardDefineKeyList[0] + 
                    "', @cardDefineKey_2 = '" + cardDefineKeyList[1] + "', @cardDefineKey_3 = '" + cardDefineKeyList[2] +
                    "', @cardDefineKey_4 = '" + cardDefineKeyList[3] + "', @cardDefineKey_5 = '" + cardDefineKeyList[4] +
                    "', @cardDefineKey_6 = '" + cardDefineKeyList[5] + "'";

                dataTable = SetDatabase.SetDatabaseReader(query);

                dataTable.Clear();
                query = "EXEC [dbo].[userTicketAmountReduce] @userKey = '" + userKey + "', @ticketDefineKey = '"+ ticketDefineKey +"'";
                dataTable = SetDatabase.SetDatabaseReader(query);

                dataTable.Clear();
                query = "EXEC [dbo].[selectUserShowWindow] @userKey = '"+ userKey +"'";
                dataTable = SetDatabase.SetDatabaseReader(query);

                foreach(DataRow dataRow in dataTable.Rows)
				{
					foreach(DataColumn dataColumn in dataTable.Columns)
					{
						stringBuilder.Append(dataRow[dataColumn]);
						stringBuilder.Append("$");
					}
				}
				
                stringBuilder.Remove(stringBuilder.Length - 1, 1);
                Response.Write(stringBuilder.ToString());
            }
            /// If there is not data in dataTable or the index out of case
            catch (IndexOutOfRangeException indexOutofRangeException)
            {
                Response.Write("The ticketDefineKey is not registered.");
            }
            catch (TimeoutException timeoutException)
            {
                Response.Write("Request Time Out!");
            }
        }
        else
        {
            Response.Write("실패했네요");
        }
    }
}

// cardDefineKeyList의 각 원소를 insertShowWindow로 넣음
// userTicketAmountReduce 로 감소
// selectUserShowWindow 로 진열장 가져옴