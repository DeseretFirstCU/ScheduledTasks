using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.Collections;
using ScheduledTasks.Models;

namespace ScheduledTasks
{
    public partial class calendar : System.Web.UI.Page
    {
        Hashtable scheduledTasks = new Hashtable();
        private DataTable taskEvents;

        protected void Page_Load(object sender, EventArgs e)
        {
            BuildTasksTable();
        }

        private void BuildTasksTable()
        {
            Tasks task = new Tasks();
            taskEvents = new DataTable();
            taskEvents = task.GetScheduledTasks();
        }

        private void calTasks_DayRender(object sender, DayRenderEventArgs e)
        {
            DataRow[] rows = taskEvents.Select(
                String.Format(
                        "StartDate >= #{0}# AND StartDate < #{1}#",
                        e.Day.Date.ToShortDateString(),
                        e.Day.Date.AddDays(1).ToShortDateString()
                    )
                );


            foreach (DataRow row in rows)
            {
                Literal lit = new Literal();
                lit.Visible = true;
                lit.Text = "<br />";
                e.Cell.Controls.Add(lit);

                if(row != null)
                {
                    Label lbl = new Label();
                    lbl.Visible = true;
                    lbl.Text = row["Summary"].ToString();
                    e.Cell.Controls.Add(lbl);
                }
            }
        }

        private void calTasks_SelectionChanged(object sender, EventArgs e)
        {
            lblSummary.Text = " <h4>Selected Date: " + calTasks.SelectedDate.ToShortDateString() + "</h4>";

            DataView view = taskEvents.DefaultView;
            view.RowFilter = String.Format(
                              "StartDate >= #{0}# AND StartDate < #{1}#",
                              calTasks.SelectedDate.ToShortDateString(),
                              calTasks.SelectedDate.AddDays(1).ToShortDateString()
                           );

            if (view.Count > 0)
            {
                GridView1.Visible = true;
                GridView1.DataSource = view;
                GridView1.DataBind();
            }
            else
            {
                GridView1.Visible = false;
            }

            //BuildTasksTable();
        }

        protected void calTasks_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
        {

        }

        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            this.calTasks.DayRender += new System.Web.UI.WebControls.DayRenderEventHandler(this.calTasks_DayRender);
            this.calTasks.SelectionChanged += new System.EventHandler(this.calTasks_SelectionChanged);
            this.Load += new System.EventHandler(this.Page_Load);
        }
    }
}