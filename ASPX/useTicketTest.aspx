<%@ Page Language="C#" AutoEventWireup="true" CodeFile="useTicketTest.aspx.cs" Inherits="useTicketTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>뽑기 실험 페이지</title>
</head>
<body style="height: 161px">
    <form id="form1" runat="server">
        <p style="width: 309px">
            <asp:Button OnClick="commonGachaTest_Click" text="일반 뽑기 실험" runat="server" />
            1성 확률 : 
                <asp:TextBox ID="star1P" runat="server" />
            2성 확률 : 
                <asp:TextBox ID="star2P" runat="server" />
            3성 확률 : 
                <asp:TextBox ID="star3P" runat="server" />
            4성 확률 : 
                <asp:TextBox ID="star4P" runat="server" />
            5성 확률 : 
                <asp:TextBox ID="star5P" runat="server" />

            5성 + 5성 확률 :
                <asp:TextBox ID="star55P" runat="server" />
            5성 + 5성 + 4성 확률 :
                <asp:TextBox ID="star554P" runat="server" />
            5성 + 4성 확률 :
                <asp:TextBox ID="star54P" runat="server" />
            4성 + 4성 확률 :
                <asp:TextBox ID="star44P" runat="server" />

        </p>
    </form>
</body>
</html>
