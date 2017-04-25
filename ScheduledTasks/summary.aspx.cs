using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ScheduledTasks.Models;

namespace ScheduledTasks
{
    public partial class summary : System.Web.UI.Page
    {
        Tasks task;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if(Request.QueryString["TaskID"] != null)
                {
                    task = new Tasks(Convert.ToInt32(Request.QueryString["TaskID"].ToString()));
                    if(task.TaskID > 0)
                    {
                        lblAssignee.Text = task.AssigneeName;
                        lblDescription.Text = task.Description;
                        lblSummary.Text = task.Summary;
                        lblStartDate.Text = task.StartDate.ToShortDateString();
                        lblEndDate.Text = task.EndDate.ToShortDateString();
                    }
                }
            }
        }
    }
}