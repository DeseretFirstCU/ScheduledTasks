using ScheduledTasks.Models;
using System;
using System.Web;
using System.Net;
using System.IO;
using System.Text;
using Newtonsoft.Json.Linq;
using System.Configuration;
using System.Web.Configuration;
using System.Net.Configuration;
using System.Net.Mail;
using System.Net.Mime;
using System.Web.Services;
using System.Collections.Generic;
using ScheduledTasks.Properties;
using Newtonsoft.Json;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Script.Services;
using System.Linq;

namespace ScheduledTasks
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object GetEmployeeName(string name)
        {
            Dictionary<long,string> employees= new Dictionary<long, string>();
            string jsonString = null;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
            var query = Settings.Default.SearchFreshDeskAgents+name;
            HttpWebRequest agentRequest = (HttpWebRequest)WebRequest.Create(query);
            agentRequest.ContentType = "application/json;charset=utf-8";
            agentRequest.Method = "GET";


            string createAuthInfo = "qnAp7P6hGpSTtFYYmvX:X";
            createAuthInfo = Convert.ToBase64String(Encoding.Default.GetBytes(createAuthInfo));
            agentRequest.Headers["Authorization"] = "Basic " + createAuthInfo;

            using (HttpWebResponse agentResponse = (HttpWebResponse)agentRequest.GetResponse())
            {
                Stream agentDataStream = agentResponse.GetResponseStream();
                StreamReader agentReader = new StreamReader(agentDataStream);
                jsonString = agentReader.ReadToEnd();
                agentReader.Close();
                agentDataStream.Close();
            }
            var searchEmployees = JsonConvert.DeserializeObject<List<RootObject>>(jsonString);
           foreach(var employee in searchEmployees)
            {
                employees.Add(employee.agent.id, employee.agent.user.name);
            }
            var results = employees.Select(c => new { label = c.Value, ID = c.Key });
            return results;
        }
        protected void btnSchedule_Click(object sender, EventArgs e)
        {
            Tasks task = new Tasks();
            task.AssigneeName = txtAsignee.Text;
            task.Description = txtDesciption.Text;
            task.Summary = txtSummary.Text;
            task.StartDate = Convert.ToDateTime(txtStartDate.Text);
            task.EndDate = Convert.ToDateTime(txtEndDate.Text);
            task.GroupId = 5000094725;
            var id = Convert.ToInt64(userId.Value);
            var email = HttpContext.Current.User.Identity.Name.Replace("DFCU\\","")+"@dfcu.com";
            //Get agent
            string jsonString = String.Empty;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
            var url = "https://dfcu.freshdesk.com/agents/" + id + ".json";
            HttpWebRequest agentRequest = (HttpWebRequest)WebRequest.Create(url);
            agentRequest.ContentType = "application/json";
            agentRequest.Method = "GET";

            string authInfo = "qnAp7P6hGpSTtFYYmvX:X";
            authInfo = Convert.ToBase64String(Encoding.Default.GetBytes(authInfo));
            agentRequest.Headers["Authorization"] = "Basic " + authInfo;

            using (HttpWebResponse agentResponse = (HttpWebResponse)agentRequest.GetResponse())
            {
                Stream agentDataStream = agentResponse.GetResponseStream();
                StreamReader agentReader = new StreamReader(agentDataStream);
                jsonString = agentReader.ReadToEnd();
                agentReader.Close();
                agentDataStream.Close();
            }
            var results = JsonConvert.DeserializeObject<RootObject>(jsonString);
            task.AssigneeEmail = results.agent.user.email;
            var responderId = results.agent.user.id;
            //Create the ticket
            try
            {                
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
                string createJson = "{\"helpdesk_ticket\": {\"email\":\"" + email + "\",\"subject\":\"" + task.Description + "\",\"description\":\"" + task.Summary + "\",\"responder_id\":\"" + responderId + "\", \"group_id\":\"" + task.GroupId + "\"}}";
                HttpWebRequest createRequest = (HttpWebRequest)WebRequest.Create("https://dfcu.freshdesk.com/helpdesk/tickets.json");
                //HttpWebRequest class is used to Make a request to a Uniform Resource Identifier (URI).  
                createRequest.ContentType = "application/json";
                // Set the ContentType property of the WebRequest. 
                createRequest.Method = "POST";
                byte[] createByteArray = Encoding.UTF8.GetBytes(createJson);
                // Set the ContentLength property of the WebRequest. 
                createRequest.ContentLength = createByteArray.Length;

                string createAuthInfo = "qnAp7P6hGpSTtFYYmvX:X";
                createAuthInfo = Convert.ToBase64String(Encoding.Default.GetBytes(createAuthInfo));
                createRequest.Headers["Authorization"] = "Basic " + createAuthInfo;

                //Get the stream that holds request data by calling the GetRequestStream method. 
                Stream createDataStream = createRequest.GetRequestStream();
                // Write the data to the request stream. 
                createDataStream.Write(createByteArray, 0, createByteArray.Length);
                // Close the Stream object. 
                createDataStream.Close();
                WebResponse createResponse = createRequest.GetResponse();
                // Get the stream containing content returned by the server.
                //Send the request to the server by calling GetResponse. 
                createDataStream = createResponse.GetResponseStream();
                // Open the stream using a StreamReader for easy access. 
                StreamReader createReader = new StreamReader(createDataStream);
                // Read the content. 
                string createResult = createReader.ReadToEnd();

                Tasks.InsertScheduleTask(id.ToString(), task.AssigneeName, task.AssigneeEmail, task.Description, task.Summary, task.StartDate, task.EndDate);
                AddToCalendar(task);

                lblResponseSuccess.Visible = true;
                lblResponeFail.Visible = false;

                txtAsignee.Text = "";
                txtDesciption.Text = "";
                txtSummary.Text = "";
                txtStartDate.Text = "";
                txtEndDate.Text = "";
            }
            catch(System.Exception ex)
            {
                lblResponeFail.Visible = true;
                lblResponseSuccess.Visible = false;
            }            
        }

        private void AddToCalendar(Tasks task)
        {  
            Configuration config = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
            MailSettingsSectionGroup settings = (MailSettingsSectionGroup)config.GetSectionGroup("system.net/mailSettings");
            SmtpClient sc = new SmtpClient("192.168.19.196");
            sc.Port = settings.Smtp.Network.Port;
            MailMessage msg = new MailMessage();

            msg.From = new MailAddress("events@dfcu.com");
            msg.To.Add(new MailAddress(task.AssigneeEmail, task.AssigneeName));
            msg.Subject = "Schedule Task: " + task.Description;
            msg.Body = task.Summary;

            StringBuilder str = new StringBuilder();
            str.AppendLine("BEGIN:VCALENDAR");
            str.AppendLine("VERSION:2.0");
            str.AppendLine("METHOD:PUBLISH");
            str.AppendLine("BEGIN:VEVENT");

            str.AppendLine(string.Format("DTSTART:{0:yyyyMMddTHHmmssZ}", task.StartDate.ToUniversalTime()));
            str.AppendLine(string.Format("DTSTAMP:{0:yyyyMMddTHHmmssZ}", (task.EndDate - task.StartDate).Minutes));
            str.AppendLine(string.Format("DTEND:{0:yyyyMMddTHHmmssZ}", task.EndDate.ToUniversalTime()));
            str.AppendLine("LOCATION:Salt Lake City, UT");
            str.AppendLine(string.Format("DESCRIPTION:{0}", task.Summary));
            str.AppendLine(string.Format("X-ALT-DESC;FMTTYPE=text/html:{0}", task.Summary));
            str.AppendLine(string.Format("SUMMARY:{0}", task.Description));
            str.AppendLine(string.Format("ORGANIZER:MAILTO:{0}", "events@dfcu.com"));

            str.AppendLine(string.Format("ATTENDEE;CN=\"{0}\";RSVP=TRUE:mailto:{1}", msg.To[0].DisplayName, msg.To[0].Address));
            str.AppendLine("BEGIN:VALARM");
            str.AppendLine("TRIGGER:-PT15M");
            str.AppendLine("ACTION:DISPLAY");
            str.AppendLine("DESCRIPTION:Reminder");
            str.AppendLine("END:VALARM");
            str.AppendLine("END:VEVENT");
            str.AppendLine("END:VCALENDAR");

            System.Net.Mail.Attachment attach = System.Net.Mail.Attachment.CreateAttachmentFromString(str.ToString(), "Event.ics");
            System.Net.Mime.ContentType ct = new System.Net.Mime.ContentType("text/calendar");
            attach.TransferEncoding = TransferEncoding.Base64;
            msg.Attachments.Add(attach);

            try
            {
                sc.Send(msg);
            }
            catch(System.Exception ex)
            {
                string exMes = ex.Message;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtAsignee.Text = "";
            txtDesciption.Text = "";
            txtSummary.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
        }
    }
}