using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ScheduledTasks.Models
{

    public class User
    {
        public bool active { get; set; }
        public object address { get; set; }
        public string created_at { get; set; }
        public bool deleted { get; set; }
        public object description { get; set; }
        public string email { get; set; }
        public object external_id { get; set; }
        public object fb_profile_id { get; set; }
        public bool helpdesk_agent { get; set; }
        public long id { get; set; }
        public string job_title { get; set; }
        public string language { get; set; }
        public string mobile { get; set; }
        public string name { get; set; }
        public string phone { get; set; }
        public string time_zone { get; set; }
        public object twitter_id { get; set; }
        public object unique_external_id { get; set; }
        public string updated_at { get; set; }
    }

    public class Agent
    {
        public object active_since { get; set; }
        public bool available { get; set; }
        public string created_at { get; set; }
        public long id { get; set; }
        public string last_active_at { get; set; }
        public bool occasional { get; set; }
        public int points { get; set; }
        public long scoreboard_level_id { get; set; }
        public object signature { get; set; }
        public string signature_html { get; set; }
        public int ticket_permission { get; set; }
        public string updated_at { get; set; }
        public long user_id { get; set; }
        public User user { get; set; }
    }

    public class RootObject
    {
        public Agent agent { get; set; }
    }

}