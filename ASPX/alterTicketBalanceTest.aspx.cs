using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using DatabaseConnection;
using System.Data;
using System.Text;
using ticketFactorSelect;
using System.IO;
using System.Data.SqlClient;
using alterDatabaseConnection;

public partial class alterTicketBalanceTest : System.Web.UI.Page
{
    private StringBuilder result;
    private string ticketDefineKey;
    private string query;
    private uint repeatCount;
    private DataTable dataTable;

    protected void Page_Load(object sender, EventArgs e)
    {
        // 반복변수는 숫자만 입력이 가능합니다.
        repeatCountTextBox.Attributes["onKeyPress"] = "if((event.keyCode<48) || (event.keyCode>57)) {return false;}"; 
    }

    protected void gachaTestStart_Click(object sender, EventArgs e)
    {
        if (SetDatabaseConnection.databaseOpen())
        {
            ticketDefineKey = this.ticketDefineKeyTextBox.Text;
            query = null;
            dataTable = new DataTable();

            // coupon parameters
            query = "SELECT [ticketDefineKey],[ticketName],[ticketDescription],[cardType],[rarity1],[rarity2],[element],[jobType],[startSeason],[endSeason],[oneStarProbability],[twoStarProbability],[threeStarProbability],[fourStarProbability],[fiveStarProbability],[ticketIcon] FROM [dbmenistream].[dbo].[ticketDefineTbl] WHERE ticketDefineKey = '" + ticketDefineKey + "'";
            dataTable = SetDatabaseConnection.databaseReader(query);
            string cardTypeFactor = dataTable.Rows[0]["cardType"].ToString();
            string rarity1Factor = dataTable.Rows[0]["rarity1"].ToString();
            string rarity2Factor = dataTable.Rows[0]["rarity2"].ToString();
            string elementFactor = dataTable.Rows[0]["element"].ToString();
            string jobTypeFactor = dataTable.Rows[0]["jobType"].ToString();
            string startSeason = dataTable.Rows[0]["startSeason"].ToString();
            string endSeason = dataTable.Rows[0]["endSeason"].ToString();
            double oneStarP = double.Parse(dataTable.Rows[0]["oneStarProbability"].ToString());
            double twoStarP = double.Parse(dataTable.Rows[0]["twoStarProbability"].ToString()); ;
            double threeStarP = double.Parse(dataTable.Rows[0]["threeStarProbability"].ToString()); ;
            double fourStarP = double.Parse(dataTable.Rows[0]["fourStarProbability"].ToString()); ;
            double fiveStarP = double.Parse(dataTable.Rows[0]["fiveStarProbability"].ToString());

            // static probability
            dataTable.Clear();
            query = "SELECT [bonusFourStarProbability],[bonusFiveStarProbability],[leaderCardProbability],[unitCardProbability],[spellCardProbability],[landCardProbability]  FROM [dbmenistream].[dbo].[gachaProbabilityDefineTbl]";
            dataTable = SetDatabaseConnection.databaseReader(query);
            double bonusFourStarP = double.Parse(dataTable.Rows[0]["bonusFourStarProbability"].ToString());
            double bonusFiveStarP = double.Parse(dataTable.Rows[0]["bonusFiveStarProbability"].ToString());
            double leaderCardP = double.Parse(dataTable.Rows[0]["leaderCardProbability"].ToString());
            double unitCardP = double.Parse(dataTable.Rows[0]["unitCardProbability"].ToString());
            double spellCardP = double.Parse(dataTable.Rows[0]["spellCardProbability"].ToString());
            double landCardP = double.Parse(dataTable.Rows[0]["landCardProbability"].ToString());

            result = new StringBuilder();

            // random parameters
            List<double> diceEyeList = new List<double>();
            List<uint> rarityList = new List<uint>();
            List<double> rarityBonusEyeList = new List<double>();
            List<uint> elementList = new List<uint>();
            List<string> cardDefineKeyList = new List<string>();
            string[,] cardTypeAndJobArray = new string[2, 6];
            List<double> cardTypeEyeList = new List<double>();

            // repeat parameters
            uint count = 0;
            repeatCount = uint.Parse(repeatCountTextBox.Text);
            diceEyeList = ticketFactor.diceEyeSelect(fiveStarP, fourStarP, threeStarP, twoStarP);
            rarityBonusEyeList = ticketFactor.bonusDiceEyeList(bonusFiveStarP, bonusFourStarP);
            cardTypeEyeList = ticketFactor.cardTypeEyeSelect(leaderCardP, unitCardP, spellCardP, landCardP);

            try
            {
                while(count < repeatCount)
                {
                    rarityList = ticketFactor.raritySelect(rarity1Factor, rarity2Factor, diceEyeList, rarityBonusEyeList);
                    rarityList.Sort(); rarityList.Reverse();
                    elementList = ticketFactor.elementSelect(elementFactor);
                    cardTypeAndJobArray = ticketFactor.cardTypeAndJobSelect(cardTypeFactor, jobTypeFactor, cardTypeEyeList);
                    cardDefineKeyList = ticketFactor.cardDefineKeySelect(rarityList, cardTypeAndJobArray, elementList, startSeason, endSeason);

                    foreach (string cardDefineKey in cardDefineKeyList)
                        result.Append(cardDefineKey + ",");
                    result.Remove(result.Length - 1, 1);

                    // label에 표시하는거니 태그를 써서 줄바꿈을 합니다.  stringBuilder.AppendLine은 안됩니다.
                    result.Append("<br />");
                    count += 1;
                } // end while
                this.resultLabel.Text = result.ToString();
            }
            /// If there is not data in dataTable or the index out of case
            catch (IndexOutOfRangeException indexOutofRangeException)
            {
                this.resultLabel.Text = "The ticketDefineKey is not registered.";
            } 
            catch (TimeoutException timeoutException)
            {
                this.resultLabel.Text = "Request Time Out!";
            }
            // end try

            SetDatabaseConnection.databaseClose();
        }
        else
        {
            this.resultLabel.Text = "실패했네요";
        }
    }

        //    string ticketDefineKey = ticketDefineKeyTextBox.Text;
        //    string query = null;
        //    DataTable dataTable = new DataTable();

            //// coupon parameters
            //query = "SELECT * FROM ticketDefineTbl WHERE ticketDefineKey = '" + ticketDefineKey + "'";
            //dataTable = SetDatabase.SetDatabaseReader(query);
            //string cardTypeFactor = dataTable.Rows[0]["cardType"].ToString();
            //string rarity1Factor = dataTable.Rows[0]["rarity1"].ToString();
            //string rarity2Factor = dataTable.Rows[0]["rarity2"].ToString();
            //string elementFactor = dataTable.Rows[0]["element"].ToString();
            //string jobTypeFactor = dataTable.Rows[0]["jobType"].ToString();
            //string startSeason = dataTable.Rows[0]["startSeason"].ToString();
            //string endSeason = dataTable.Rows[0]["endSeason"].ToString();
            //double oneStarP = double.Parse(dataTable.Rows[0]["oneStarProbability"].ToString());
            //double twoStarP = double.Parse(dataTable.Rows[0]["twoStarProbability"].ToString()); ;
            //double threeStarP = double.Parse(dataTable.Rows[0]["threeStarProbability"].ToString()); ;
            //double fourStarP = double.Parse(dataTable.Rows[0]["fourStarProbability"].ToString()); ;
            //double fiveStarP = double.Parse(dataTable.Rows[0]["fiveStarProbability"].ToString());

            //// static probability
            //dataTable.Clear();
            //query = "SELECT * FROM gachaProbabilityDefineTbl";
            //dataTable = SetDatabase.SetDatabaseReader(query);
            //double bonusFourStarP = double.Parse(dataTable.Rows[0]["bonusFourStarProbability"].ToString());
            //double bonusFiveStarP = double.Parse(dataTable.Rows[0]["bonusFiveStarProbability"].ToString());
            //double leaderCardP = double.Parse(dataTable.Rows[0]["leaderCardProbability"].ToString());
            //double unitCardP = double.Parse(dataTable.Rows[0]["unitCardProbability"].ToString());
            //double spellCardP = double.Parse(dataTable.Rows[0]["spellCardProbability"].ToString());
            //double landCardP = double.Parse(dataTable.Rows[0]["landCardProbability"].ToString());

            //// random parameters
            //List<double> diceEyeList = new List<double>();
            //List<uint> rarityList = new List<uint>();
            //List<double> rarityBonusEyeList = new List<double>();
            //rarityBonusEyeList.Add(bonusFiveStarP); rarityBonusEyeList.Add(bonusFourStarP);
            //List<uint> elementList = new List<uint>();
            //List<string> cardDefineKeyList = new List<string>();
            //string[,] cardTypeAndJobArray = new string[2, 6];
            //List<double> cardTypeEyeList = new List<double>();

            //// repeat parameters
            //uint count = 0;
            //uint repeatCount = uint.Parse(repeatCountTextBox.Text);
            //result = new StringBuilder();

            //try
            //{
            //    while(count < repeatCount)
            //    {
            //        diceEyeList = ticketFactor.diceEyeSelect(fiveStarP, fourStarP, threeStarP, twoStarP);
            //        rarityList = ticketFactor.raritySelect(rarity1Factor, rarity2Factor, diceEyeList, rarityBonusEyeList);
            //        rarityList.Sort(); rarityList.Reverse();
            //        elementList = ticketFactor.elementSelect(elementFactor);
            //        cardTypeEyeList = ticketFactor.cardTypeEyeSelect(leaderCardP, unitCardP, spellCardP, landCardP);
            //        cardTypeAndJobArray = ticketFactor.cardTypeAndJobSelect(cardTypeFactor, jobTypeFactor, cardTypeEyeList);
            //        cardDefineKeyList = ticketFactor.cardDefineKeySelect(rarityList, cardTypeAndJobArray, elementList, startSeason, endSeason);

            //        foreach (string cardDefineKey in cardDefineKeyList)
            //            result.Append(cardDefineKey + ",");
            //        result.Remove(result.Length - 1, 1);

            //        //foreach (int rarity in rarityList)
            //        //    result.Append(rarity + ",");
            //        //result.Remove(result.Length - 1, 1);

            //        // label에 표시하는거니 태그를 써서 줄바꿈을 합니다.  stringBuilder.AppendLine은 안됩니다.
            //        result.Append("<br />");
            //        count += 1;
            //    }
            //    this.resultLabel.Text = result.ToString();
            //}
            ///// If there is not data in dataTable or the index out of case
            //catch (IndexOutOfRangeException indexOutofRangeException)
            //{
            //    this.resultLabel.Text = "The ticketDefineKey is not registered.";
            //} 
            //catch (TimeoutException timeoutException)
            //{
            //    this.resultLabel.Text = "Request Time Out!";
            //}
            //// end try
        //} // end buttonEvent
}