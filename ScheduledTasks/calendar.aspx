<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="calendar.aspx.cs" Inherits="ScheduledTasks.calendar" %>

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
                                <h3>Schedule Calendar</h3>
                            
                            </div>
                            <div class="col-md-1">
                                &nbsp;
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-1">
                                &nbsp;
                            </div>
                            <div class="col-md-10">
                                <asp:Panel runat="server" ID="pnl">
                                    <asp:Calendar ID="calTasks" runat="server" BackColor="White" BorderColor="#023761" DayNameFormat="Shortest" 
                                        ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" TitleFormat="MonthYear" Width="100%" 
                                        FirstDayOfWeek="Sunday" DayStyle-HorizontalAlign="Left" DayStyle-VerticalAlign="Top" 
                                        ShowGridLines="True" WeekendDayStyle-Height="100" WeekendDayStyle-Width="100">
                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="10pt" ForeColor="#333333" Height="12pt" />
                                        <DayStyle CssClass="calTodayDay" />
                                        <NextPrevStyle ForeColor="white" Font-Size="12px" CssClass="calNextPrevHeader" />
                                        <OtherMonthDayStyle ForeColor="#999999" />
                                        <SelectedDayStyle BackColor="#023761" ForeColor="White" />
                                        <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
                                        <TitleStyle BackColor="#023761" Font-Bold="True" Font-Size="16pt" ForeColor="White" Height="18pt" />
                                        <TodayDayStyle BackColor="#69a5d5" />
                                    </asp:Calendar>
                                </asp:Panel>
                            </div>
                            <div class="col-md-1">
                                &nbsp;
                            </div>
                        </div>                     
                        <div class="row">
                            <div class="col-md-1">
                                &nbsp;
                            </div>
                            <div class="col-md-10">
                                <asp:Label ID="lblSummary" runat="server"></asp:Label>
                                <asp:GridView ID="GridView1" runat="server" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" 
                                        BorderWidth="1px" CellPadding="4" CellSpacing="2" ForeColor="Black" AutoGenerateColumns="False" 
                                        Width="100%" CssClass="table table-striped table-bordered table-hover">
                                    <Columns> 
                                        <asp:HyperLinkField Text="<i class='fa fa-binoculars fa-lg' aria-hidden='true'></i>" DataNavigateUrlFields="TaskID" DataNavigateUrlFormatString="~/summary.aspx?TaskID={0}" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="center" />                                                                               
                                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" ItemStyle-Width="11%" DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="EndDate" HeaderText="End Date" ItemStyle-Width="11%" DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="AssigneeName" HeaderText="Name" ItemStyle-Width="15%"  />                                             
                                        <asp:BoundField DataField="Description" HeaderText="Description" ItemStyle-Width="56%"  />                                        
                                    </Columns>
                                              
                                    <FooterStyle BackColor="#CCCCCC" />
                                    <HeaderStyle BackColor="#023761" Font-Bold="True" ForeColor="White" Height="20px" />
                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                    <RowStyle BackColor="White" CssClass="gridCell" />
                                              
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                    <SortedDescendingHeaderStyle BackColor="#383838" />
                                           
                                </asp:GridView>
                            </div>
                            <div class="col-md-1">
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
