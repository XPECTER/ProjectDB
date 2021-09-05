using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;
using System.Collections.Generic;

public partial class allCardCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userKey = "E3F55920C8";

        DataTable dataTable = new DataTable();

        string query = "SELECT cardDefineKey FROM cardDefineTbl_Kr ORDER BY cardDefineKey";
        dataTable = SetDatabase.SetDatabaseReader(query);

        List<string> cardDefineKeyList = new List<string>();

        //string result = null;

        //for (int i = 0; i < dataTable.Rows.Count; i++)
        //    result += dataTable.Rows[i][0].ToString() + "$";

        for (int i = 0; i < dataTable.Rows.Count; i++)
            cardDefineKeyList.Add(dataTable.Rows[i][0].ToString());

        //result = result.Remove(result.Length - 1);
        
        foreach(String a in cardDefineKeyList)
        {
            query = "EXEC createCard @userKey = '" + userKey + "', @cardDefineKey = '" + a + "'";
            dataTable = SetDatabase.SetDatabaseReader(query);

            //Response.Write(a + "<br />");
        }

    }
}