<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="summary.aspx.cs" Inherits="ScheduledTasks.summary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
     <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"/>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/custom.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <link href="Content/font-awesome.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <!-- navogation header -->
            <nav class="navbar navbar-custom navbar-fixed-top">
                <div class="container">
                    <div class="pull-left"> 
                        <img src="images/DFCUTeamNet.png" class="img-responsive" />
                    </div>
                    <div class="nav navbar-nav navbar-collapse collapse navbar-right" style="padding-top:50px; padding-right:100px;">
                        <li><a runat="server" href="Default.aspx">Home</a></li>
                        <li><a runat="server" href="calendar.aspx">View Calendar</a></li>                        
                    </div>
                </div>
            </nav>
            <!-- navogation header -->

            <hr />
            <br />

            <div class="container">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-md-1">
                                &nbsp;
                            </div>
                            <div class="col-md-10">
                                <h3>Task Summary</h3>
                            
                            </div>
                            <div class="col-md-1">
                                &nbsp;
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-2">
                                &nbsp;
                            </div>
                            <div class="col-md-8">
                                <asp:Panel runat="server" ID="pnl">
                                    <p>
                                        <label>Assignee</label>
                                        <br />
                                        <asp:Label ID="lblAssignee" runat="server" CssClass="control-label"></asp:Label>
                                    </p>
                                    <p>
                                        <label>Description/Task</label>
                                        <br />
                                        <asp:Label ID="lblDescription" runat="server" CssClass="control-label"></asp:Label>
                                    </p>

                                    <p>
                                        <label>Summary</label>
                                        <br />
                                        <asp:Label ID="lblSummary" runat="server" CssClass="control-label"></asp:Label>
                                    </p>

                                    <p>
                                        <label>Start Date</label>
                                        <br />
                                        <asp:Label ID="lblStartDate" runat="server" CssClass="control-label"></asp:Label>
                                    </p>
                                    <p>
                                        <label>End Date</label>
                                        <br />
                                        <asp:Label ID="lblEndDate" runat="server" CssClass="control-label"></asp:Label>
                                    </p>
                                </asp:Panel>
                            </div>
                            <div class="col-md-2">
                                &nbsp;
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <br />
            <hr />

            <!-- Footer -->
            <footer>
                <div class="container">
                    <div class="pull-left"> 
                        <img src="images/DFCU_White_Small.jpg" />
                    </div>
                    <div class="pull-right">
                        <%: DateTime.Now.Year %> - Deseret First Credit Union
                    </div>
                </div>
            </footer>
            <!-- Footer -->

        </div>
    </form>
</body>
</html>
