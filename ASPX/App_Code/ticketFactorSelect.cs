using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using WELLalgorithm;
using DatabaseConnection;
using System.IO;
using System.Text;

/// <summary>
/// 뽑기에 관한 알고리즘을 담고 있습니다.
/// </summary>

namespace ticketFactorSelect
{
    public class ticketFactor
    {
        /// <summary>
        /// 생성자요
        /// </summary>
        public ticketFactor()
        {
            //
            // TODO: 여기에 생성자 논리를 추가합니다.
            //
        }

        /// <sumery>
        /// 카드 타입을 결정합니다. 직업이 결정된 쿠폰이라면 유닛카드만,
        /// 그렇지 않으면 카드 타입 변수를 따라 결정됩니다. 두 가지의 변수를
        /// 비교해야합니다. 첫 번째 행은 카드 타입, 두 번째 행은 직업이 들어갑니다.
        /// 만약 직업이 없을 경우는 언더바(_)로 들어갑니다.
        /// </sumery>
        public static string[,] cardTypeAndJobSelect(string cardTypeFactor, string jobTypeFactor, List<double> cardTypeEyeList)
        {
            string[,] cardTypeAndJobArray = new string[2, 6];
            uint firstDice = 0, secondDice = 0;

            if (jobTypeFactor == "_")
            {
                // 유닛 카드가 아니고 카드 타입이 정해져 있을 때 
                if (cardTypeFactor != "_")
                {
                    for (int i = 0; i < 6; i++)
                    {
                        cardTypeAndJobArray[0, i] = cardTypeFactor;
                        cardTypeAndJobArray[1, i] = "_";
                    }
                }
                else
                {
                    // 카드 타입 중 유닛 카드가 더 많이 나오게. 확률 반영좀
                    for (int i = 0; i < 6; i++)
                    {
                        firstDice = WELL512.Next(1, 101);
                        secondDice = WELL512.Next(1, 101);
                        uint diceSum = firstDice + secondDice;

                        if (diceSum <= cardTypeEyeList[0])
                        {
                            cardTypeAndJobArray[0, i] = "0";
                        }
                        else if (diceSum > cardTypeEyeList[0] && diceSum <= cardTypeEyeList[1])
                        {
                            cardTypeAndJobArray[0, i] = "1";
                        }
                        else if (diceSum > cardTypeEyeList[1] && diceSum <= cardTypeEyeList[2])
                        {
                            cardTypeAndJobArray[0, i] = "2";
                        }
                        else
                        {
                            cardTypeAndJobArray[0, i] = "3";
                        }
                        cardTypeAndJobArray[1, i] = "_";
                    }
                }
            }
            // 유닛 카드일 때, 카드타입을 1로 맞추고 직업을 배열에 넣는다.
            else
            {
                for(int i = 0; i < 6; i++)
                {
                    cardTypeAndJobArray[0, i] = "1";
                    cardTypeAndJobArray[1, i] = jobTypeFactor;
                }
            }    

            return cardTypeAndJobArray;
        }

        /// <summary>
        /// 사용한 쿠폰에 따라 카드의 레어도를 결정합니다. 5성이 적어도 한 장 포함되어있다면
        /// 총 다섯 가지 경우(5성한 장, 5성 두 장, 5성 한 장과 4성 두 장, 5성 한 장과 4성 한 장)
        /// 중 한 가지가 선택되게 됩니다. 확률은 기획자가 테스트하며 조정됩니다.
        /// </summary>
        public static List<uint> raritySelect(string rarity1Factor, string rarity2Factor, List<double> diceEyeList, List<double> rarityBonusEyeList)
        {
            List<uint> rarityList = new List<uint>();
            uint firstDice = 0;
            uint secondDice = 0;
            uint eyeSum = 0;
            uint bonusCondition = 0;

            if (rarity1Factor != "_")
            {
                // If rarity1Factor is five
                if (rarity1Factor == "5")
                {
                    rarityList.Add(5);
                    bonusCondition += 1;

                    // When two cards of the rating is five star
                    if (rarity2Factor == "5")
                    {
                        rarityList.Add(5);
                        bonusCondition += 1;
                    }

                    // When one card is five star, the other card is four star
                    if (rarity2Factor == "4")
                    {
                        rarityList.Add(4);
                        bonusCondition += 1;
                    }
                }
                // If rarity1Factor is four,
                else if (rarity1Factor == "4")
                {
                    rarityList.Add(4);
                    bonusCondition += 1;

                    // When two cards of the rating is four star
                    if (rarity2Factor == "4")
                    {
                        rarityList.Add(4);
                        bonusCondition += 1;
                    }
                }
                else
                {
                    rarityList.Add(3);
                }
            }
            
            // 카드들의 레어도 결정 개선
            while(rarityList.Count < 6)
            {
                if (rarityList.Count == 5 && bonusCondition == 1)
                {
                        uint bonusDice = WELL512.Next(1, 101);
                        uint bonusDice2 = WELL512.Next(1, 101);
                        uint bonusSum = bonusDice + bonusDice2;

                        if (bonusSum > 0 && bonusSum <= rarityBonusEyeList[0])
                        {
                            // 0 < x <= 45
                            rarityList.Add(5); break;
                        }
                        else if (bonusSum > rarityBonusEyeList[0] && bonusSum <=rarityBonusEyeList[1])
                        {
                            // 45 < x <= 123
                            rarityList.Add(4); break;
                        }
                }

                // Roll two dice a scale between 1 and 100, then Sum
                firstDice = WELL512.Next(1, 101);
                secondDice = WELL512.Next(1, 101);
                eyeSum = firstDice + secondDice;

                if(eyeSum < diceEyeList[0])
                {
                    rarityList.Add(5); bonusCondition += 1;
                }
                else if(eyeSum >= diceEyeList[0] && eyeSum < diceEyeList[1])
                {
                    rarityList.Add(4); bonusCondition += 1;
                }
                else if (eyeSum >= diceEyeList[1] && eyeSum < diceEyeList[2])
                {
                    rarityList.Add(3);
                }
                else if (eyeSum >= diceEyeList[2] && eyeSum < diceEyeList[3])
                {
                    rarityList.Add(2);
                }
                else
                {
                    rarityList.Add(1);
                }
            } // end while

            return rarityList;
        }

         /// <summary>
         ///사용한 쿠폰에 따라 카드의 원소를 결정합니다. 원소가 정해진 쿠폰이라면 
         ///3장만 해당 원소로 바꾸고 원소가 정해져 있지 않다면 
         ///네 가지 원소(불, 물, 바람, 땅) 중 무작위로 선택됩니다.
         /// </summary>
        public static List<uint> elementSelect(string elementFactor)
        {
            List<uint> elementList = new List<uint>();

            // If element parameter is exist
            if (elementFactor != "_")
            {
                // select 3 of 6 card
                while (elementList.Count < 3)
                {
                    elementList.Add(uint.Parse(elementFactor));
                }
            }
            
            // If element parameter is not exist or select remain cards 
            while (elementList.Count < 6)
                {
                    elementList.Add(WELL512.Next(4));
                }

            return elementList;
        }

        public static List<double> diceEyeSelect(double fiveStarP, double fourStarP, double threeStarP, double twoStarP)
        {
            bool fiveEyeFlag = false;
            bool fourEyeFlag = false;
            bool threeEyeFlag = false;
            bool twoEyeFlag = false;

            double fiveStandard = fiveStarP * 100;
            double fourStandard = fiveStandard + (fourStarP * 100);
            double threeStandard = fourStandard + (threeStarP * 100);
            double twoStandard = threeStandard + (twoStarP * 100);

            int repeat = 1;
            int converse = 2;
            double sum = 0;
            //List<int> intList = new List<int>();
            List<double> eyeStandard = new List<double>();

            for(int i = 1; i<= 200; i++)
            {
                // 1+2+3+...+99+100+99+98+...+3+2+1
                if (i > 100)
                    repeat = repeat - converse;

                //intList.Add(repeat);
                sum += repeat;

                if (sum >= fiveStandard && !fiveEyeFlag)
                {
                    fiveEyeFlag = true; eyeStandard.Add(i);
                }

                if (sum >= fourStandard && !fourEyeFlag)
                {
                    fourEyeFlag = true; eyeStandard.Add(i);
                }

                if (sum >= threeStandard && !threeEyeFlag)
                {
                    threeEyeFlag = true; eyeStandard.Add(i);
                }

                if (sum >= twoStandard && !twoEyeFlag)
                {
                    twoEyeFlag = true; eyeStandard.Add(i); break;
                }

                repeat += 1;
            }

            return eyeStandard;
        }

        // 10, 60 input
        public static List<double> bonusDiceEyeList(double bonusFiveStarP, double bonusFourStarP)
        {
            bool fiveFlag = false;
            bool fourFlag = false;

            double bonusFiveStandard = bonusFiveStarP * 100; // 1000
            double bonusFourStandard = bonusFiveStandard + bonusFourStarP * 100; // 7000

            int repeat = 1;
            int converse = 2;
            double sum = 0;
            List<double> bonusDiceEyeStandard = new List<double>();

            for (int i = 1; i <= 200; i++)
            {
                // 1+2+3+...+99+100+99+98+...+3+2+1
                if (i > 100)
                    repeat = repeat - converse;

                //intList.Add(repeat);
                sum += repeat;

                if (!fiveFlag && sum >= bonusFiveStandard )
                {
                    fiveFlag = true; bonusDiceEyeStandard.Add(i);
                }

                if (sum >= bonusFourStandard && !fourFlag)
                {
                    fourFlag = true; bonusDiceEyeStandard.Add(i); break;
                }

                repeat += 1;
            }

            return bonusDiceEyeStandard;
        }

        public static List<double> cardTypeEyeSelect(double leaderCardP, double unitCardP, double spellCardP, double landCardP)
        {
            bool leaderFlag = false;
            bool unitFlag = false;
            bool spellFlag = false;

            double leaderStandard = leaderCardP * 100;
            double unitStandard = leaderStandard + unitCardP * 100;
            double spellStandard = unitStandard + spellCardP * 100;

            int repeat = 1;
            int converse = 2;
            double sum = 0;
            List<double> cardTypeEyeStandard = new List<double>();

            for(int i = 1; i<= 200; i++)
            {
                // 1+2+3+...+99+100+99+98+...+3+2+1
                if (i > 100)
                    repeat = repeat - converse;

                //intList.Add(repeat);
                sum += repeat;

                if (sum >= leaderStandard && !leaderFlag)
                {
                    leaderFlag = true; cardTypeEyeStandard.Add(i);
                }

                if (sum >= unitStandard && !unitFlag)
                {
                    unitFlag = true; cardTypeEyeStandard.Add(i);
                }

                if (sum >= spellStandard && !spellFlag)
                {
                    spellFlag = true; cardTypeEyeStandard.Add(i); break;
                }

                repeat += 1;
            }

            return cardTypeEyeStandard;
        }


        /// <summary>
        /// 모든 요소를 가지고 카드를 결정합니다.
        /// 필요한 요소는 레어도, 카드타입과 직업 배열, 속성, 시작 시즌과 끝 시즌
        /// </summary>
        public static List<string> cardDefineKeySelect(List<uint> rarityList, string[,] cardTypeAndJobArray, List<uint> elementList, string startSeason, string endSeason)
        {
            List<string> cardDefineKeyList = new List<string>();
            DataTable dataTable = new DataTable();
            StringBuilder tempQuery = new StringBuilder();
            string query = null;

            if(cardTypeAndJobArray[1, 0] == "_") // 직업이 없는 쿠폰
            {
                for(int i = 0; i < 6; i++)
                {
                    // 쿼리문 띄어쓰기를 조심합시다
                    query = "SELECT TOP 1 cardDefineKey FROM cardDefineTbl_Kr WHERE rarity = " + rarityList[i] +
                        "AND cardType = " + cardTypeAndJobArray[0, i] + "AND element = " + elementList[i] +
                        "AND season >= " + startSeason + " AND season <=" + endSeason + " ORDER BY NEWID()";

                    dataTable = SetDatabase.SetDatabaseReader(query);
                    cardDefineKeyList.Add(dataTable.Rows[0]["cardDefineKey"].ToString());
                }
            }
            else // 직업이 있는 쿠폰
            {
                for (int i = 0; i < 6; i++)
                {
                    query = "SELECT TOP 1 cardDefineKey FROM cardDefineTbl_Kr WHERE rarity = " + rarityList[i] +
                        "AND jobType = " + cardTypeAndJobArray[1, i] + "AND element = " + elementList[i] +
                        "AND season >= " + startSeason + " AND season <=" + endSeason + " ORDER BY NEWID()";

                    dataTable = SetDatabase.SetDatabaseReader(query);
                    cardDefineKeyList.Add(dataTable.Rows[0]["cardDefineKey"].ToString());
                }
            }

            return cardDefineKeyList;
        }
    }
}
