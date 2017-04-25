<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="ScheduledTasks._default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
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
    <script>
        function fillEndDate() {
            var text2 = $get("txtEndDate");
            var text1 = $get("txtStartDate");
            text2.value = text1.value;
        }

        $(function () {
            $("#txtAsignee").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Default.aspx/GetEmployeeName",
                        data: JSON.stringify({ "name": $("#txtAsignee").val()}),
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert("No Match");
                        }
                    });
                },
                select: function (event, ui) {
                    $('#userId').val(ui.item.ID);
                }
            });
        });
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
                        <asp:TextBox ID="txtAsignee" runat="server" class="form-control" placeholder="Asignee" AutoPostBack="true"></asp:TextBox>
                        <asp:HiddenField runat="server" ID="userId" />
                    </p>
                        </div>
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                        <div class="col-md-6">
                            <p>
                                <label>Description/Task</label>
                                <asp:TextBox ID="txtDesciption" runat="server" class="form-control" placeholder="Description"></asp:TextBox>
                            </p>
                        </div>
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                        <div class="col-md-6">
                            <p>
                                <label>Summary</label>
                                <asp:TextBox ID="txtSummary" runat="server" class="form-control" placeholder="Summary" TextMode="MultiLine" Height="75"></asp:TextBox>
                            </p> 
                        </div>
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                        <div class="col-md-3">
                            <p>
                                <label>Start Date</label>
                                <asp:TextBox ID="txtStartDate" runat="server" name="txtStartDate" class="form-control" placeholder="mm/dd/yyyy" TargetControlID="txtStartDate"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender ID="txtStartDate_CalendarExtender" runat="server" BehaviorID="txtStartDate_CalendarExtender" OnClientDateSelectionChanged="fillEndDate" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="txtStartDate" />
                            </p>
                        </div>
                        <div class="col-md-3">
                            <p>
                                <label>Time</label>
                                <asp:TextBox ID="txtStartTime" name="txtStartTime" CssClass="form-control"  runat="server" placeholder="hh:mm AM/PM"></asp:TextBox>
                            </p>
                        </div>
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                        <div class="col-md-3">
                            <p>
                                <label>End Date</label>
                                <asp:TextBox ID="txtEndDate" runat="server" class="form-control" placeholder="mm/dd/yyyy"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender ID="txtEndDate_CalendarExtender" runat="server" BehaviorID="txtEndDate_CalendarExtender" DefaultView="Days" PopupPosition="BottomLeft" TargetControlID="txtEndDate" />
                            </p> 
                        </div>
                        <div class="col-md-3">
                            <p>
                                <label>Time</label>
                                <asp:TextBox ID="txtEndTime" runat="server" CssClass="form-control" placeholder="hh:mm AM/PM"></asp:TextBox>
                            </p>                            
                        </div>
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                        <div class="col-md-6">
                            <p style="text-align:left;">
                                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="btnClear_Click" />&nbsp;&nbsp;
                                <asp:Button ID="btnSchedule" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnSchedule_Click" />
                            </p>
                        </div>
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            &nbsp;
                        </div>
                        <div class="col-md-6">
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
                <div class="pull-left"> 
                    <img src="images/DFCU_White_Small.jpg" />
                </div>
                <div class="pull-right">
                    <%: DateTime.Now.Year %> - Deseret First Credit Union
                </div>
            </div>
        </footer>
        <!-- Footer -->

    </form>
</body>
</html>
