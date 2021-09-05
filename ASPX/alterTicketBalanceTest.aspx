<%@ Page Language="C#" AutoEventWireup="true" CodeFile="alterTicketBalanceTest.aspx.cs" Inherits="alterTicketBalanceTest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>공사중 티켓 테스트 페이지</title>
</head>
<body>
    <form id="form1" runat="server">
        <center><asp:Label ID="Label0" runat="server" Text="바벨의 갤러리 뽑기 시뮬레이터" Font-Bold="true" Font-Size="20px" /></center>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <asp:Table ID="Table1" runat="server" CellPadding="10" GridLines="Both" Font-Size="10pt" HorizontalAlign="Center">
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Center">TicketDefineKey</asp:TableCell>
                                <asp:TableCell Width="300px">
                                    <asp:TextBox ID="ticketDefineKeyTextBox" runat="server" TabIndex="1" MaxLength="7" Width="100%"/> <br />
                                    <asp:RegularExpressionValidator ID="regexTicketDefineKey" runat="server" 
                                        ErrorMessage="This ticketDefineKey does not validate. Please check ticketDefineKey. (Ex. TK10000)"
                                        ControlToValidate="ticketDefineKeyTextBox" ValidationExpression="^[Tt][Kk][0-9]{5}$" ForeColor="Red"/>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell HorizontalAlign="Center">반복 횟수</asp:TableCell>
                                <asp:TableCell Width="300px">
                                    <asp:TextBox ID="repeatCountTextBox" runat="server" TabIndex="2" MaxLength="5" Text="1" Width="100%"/> <br />
                                    <asp:RequiredFieldValidator ID="repeatCountValidator" runat="server" ControlToValidate="repeatCountTextBox" 
                                        ErrorMessage="Please in context repeat count" ForeColor="Red"/>
                                </asp:TableCell>
                            </asp:TableRow>
            </asp:Table><br />
              <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <center><asp:Button ID="gachaTestStart" runat="server" Text="모의 뽑기 시작 버튼" OnClick="gachaTestStart_Click" /></center><br />
                    <asp:Label ID="resultLabel" runat="server" Width="100%" Height="500px" style="word-wrap:normal; word-break:break-all"/>
                </ContentTemplate>
            </asp:UpdatePanel>
    </form>
</body>
</html>