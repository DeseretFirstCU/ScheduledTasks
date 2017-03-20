<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="ScheduledTasks._default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/custom.css" rel="stylesheet" />

    <script>
        function fillEndDate() {
            var text2 = $get("txtEndDate");
            var text1 = $get("txtStartDate");
            text2.value = text1.value;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <!-- navogation header -->
        <nav class="navbar navbar-custom navbar-fixed-top">
            <div class="container">
                <div class="pull-left"> 
                    <img src="images/DFCUTeamNet.png" class="img-responsive" />
                </div>
                <div class="navbar-collapse collapse">
                    
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
                        <div class="col-md-2">
                            &nbsp;
                        </div>
                        <div class="col-md-8">
                            <h3>Schedule a Task</h3>
                            
                        </div>
                        <div class="col-md-2">
                            &nbsp;
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                        <div class="col-md-6">
                            <p>
                                <label>Assignee</label>
                                <asp:TextBox ID="txtAsignee" runat="server" class="form-control" placeholder="Asignee"></asp:TextBox>
                            </p>

                            <p>
                                <label>Assignee Email</label>
                                <asp:TextBox ID="txtAssigneeEmail" runat="server" class="form-control" placeholder="Asignee Email"></asp:TextBox>
                            </p>

                            <p>
                                <label>Description/Task</label>
                                <asp:TextBox ID="txtDesciption" runat="server" class="form-control" placeholder="Description"></asp:TextBox>
                            </p>

                            <p>
                                <label>Summary</label>
                                <asp:TextBox ID="txtSummary" runat="server" class="form-control" placeholder="Summary" TextMode="MultiLine" Height="75"></asp:TextBox>
                            </p> 
                            
                            <p>
                                <label>Start Date</label>
                                <asp:TextBox ID="txtStartDate" runat="server" name="txtStartDate" class="form-control" placeholder="mm/dd/yyyy" TargetControlID="txtStartDate"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" BehaviorID="txtStartDate_CalendarExtender" OnClientDateSelectionChanged="fillEndDate" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="txtStartDate" />
                            </p> 
                            <p>
                                <label>End Date</label>
                                <asp:TextBox ID="txtEndDate" runat="server" class="form-control" placeholder="mm/dd/yyyy"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender ID="txtEndDate_CalendarExtender" runat="server" BehaviorID="txtEndDate_CalendarExtender" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="txtEndDate" />
                            </p>  
                            
                            <p style="text-align:right;">
                                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="btnClear_Click" />&nbsp;&nbsp;
                                <asp:Button ID="btnSchedule" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnSchedule_Click" />
                            </p>
                            
                            <p>
                                <asp:Label CssClass="label label-success" ID="lblResponseSuccess" runat="server" Text="Ticket created successfully" Visible="false"></asp:Label>
                                <asp:Label CssClass="label label-danger" ID="lblResponeFail" runat="server" Text="Ticket not created" Visible="false"></asp:Label>
                            </p> 
                        </div>
                        <div class="col-md-3">
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
                
            </div>
        </footer>
        <!-- Footer -->

    </form>

    <script src="scripts/jquery-1.9.1.min.js"></script>
    <script src="scripts/bootstrap.min.js"></script>    

</body>
</html>
