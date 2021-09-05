using System;
using System.Data;
using System.IO;
using DatabaseConnection;
using System.Text;
using System.Net.Mail;

public partial class findUserPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //string mailAddress = Request.Form["mailAddress"]; // 받는 사람
            string mailAddress = "kongjy007@naver.com";

            MailMessage message = new MailMessage();
            message.From = new MailAddress("menistream@gmail.com");

            message.To.Add(new MailAddress(mailAddress)); // 받는 사람

            message.Subject = "Mysterious Galler 비밀번호 인증 메일입니다.";
            message.SubjectEncoding = System.Text.Encoding.UTF8;

            message.Body = "하단의 인증번호를 게임 내 인증번호 입력란에 입력해주세요."
                + "";
            message.BodyEncoding = System.Text.Encoding.UTF8;

            SmtpClient client = new SmtpClient();
            client.Host = "smtp.gmail.com";
            client.Credentials = new System.Net.NetworkCredential("menistream@gmail.com", "kong2460");
            client.EnableSsl = true;

            client.Send(message);
        }
        catch(Exception ex)
        {
            Response.Write("메일 발송 실패. 원인 : " + ex.Message);
        }
    }
}