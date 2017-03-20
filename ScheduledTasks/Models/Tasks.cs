using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data;

namespace ScheduledTasks.Models
{
    public class Tasks
    {    
        private int _taskid;
        private int _responderid;
        private string _assigneename;
        private string _assigneeemail;
        private string _description; 
        private string _summary;
        private DateTime _startdate;
        private DateTime _enddate;

        public DateTime EndDate
        {
            get { return _enddate; }
            set { _enddate = value; }
        }

        public int TaskID
        {
            get { return _taskid; }
            set { _taskid = value; }
        }

        public int ResponderID
        {
            get { return _responderid; }
            set { _responderid = value; }
        }

        public string AssigneeName
        {
            get { return _assigneename; }
            set { _assigneename = value; }
        }

        public string AssigneeEmail
        {
            get { return _assigneeemail; }
            set { _assigneeemail = value; }
        }
        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        public string Summary
        {
            get { return _summary; }
            set { _summary = value; }
        }

        public DateTime StartDate
        {
            get { return _startdate; }
            set { _startdate = value; }
        }

        public static void InsertScheduleTask(string responderid, string assignname, string assigneeemail, string description, string summary, DateTime startDate, DateTime endDate)
        {
            string sqlconnect = System.Configuration.ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;

            string sqlInsert = "INSERT INTO Tasks(ResponderID, AssigneeName, AssigneeEmail, Description, Summary, StartDate, EndDate)" +
                               "VALUES(@ResponderID, @AssigneeName, @AssigneeEmail, @Description, @Summary, @StartDate, @EndDate)";

            SqlConnection sqlConnection = new SqlConnection(sqlconnect);

            try
            {
                sqlConnection.Open();
                SqlCommand cmd = new SqlCommand(sqlInsert, sqlConnection);
                cmd.Parameters.AddWithValue("@ResponderID", responderid);
                cmd.Parameters.AddWithValue("@AssigneeName", assignname);
                cmd.Parameters.AddWithValue("@AssigneeEmail", assigneeemail);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@Summary", summary);
                cmd.Parameters.AddWithValue("@StartDate", startDate);
                cmd.Parameters.AddWithValue("@EndDate", endDate);
                cmd.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                string exMess = ex.Message;
                sqlConnection.Close();
            }
            finally
            {
                sqlConnection.Close();
            }
        }
    }
}