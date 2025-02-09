<%@ Page Language="c#" Debug="true" Async="true" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Sitecore.Publishing" %>
<%@ Import Namespace="Microsoft.AspNet.Identity" %>
<%@ Import Namespace="Microsoft.AspNet.Identity.Owin" %>
<%@ Import Namespace="Sitecore.Owin.Authentication.Services" %>
<%@ Import Namespace="Sitecore.Security.Accounts" %>
<%@ Import Namespace="System.Security.Claims" %>
<%@ Import Namespace="Sitecore.Security.Domains" %>
<%@ Import Namespace="Sitecore.SecurityModel.Cryptography" %>
<%@ Import Namespace="Sitecore.Owin.Authentication.Configuration" %>
<%@ Import Namespace="Sitecore.Owin.Authentication.Identity" %>
<%@ Import Namespace="Sitecore.Security.Authentication" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Threading.Tasks" %>
<%@ Import Namespace="Sitecore.Diagnostics" %>


<script runat="server">

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
      
	    string filter = ""; // use this variable if you want to filter out the roles by a certain string e.g., author, client etc. 
        var roles = Roles.GetAllRoles();
       
        int count = roles.Count(role => role.IndexOf(filter, StringComparison.OrdinalIgnoreCase) >= 0); 
        Response.Write("<br/> <strong> Total number of " + filter + " roles: </strong> " + count +  " <p/>");

        foreach (var role in roles)
        {
           
           
            if (role.ToUpper().Contains(filter))
            {
                Response.Write("<strong> Role name " + role + ".</strong> <br/>");
                IEnumerable<User> _roleUsers = Sitecore.Security.Accounts.RolesInRolesManager.GetUsersInRole(Role.FromName(role), true);
                int userCount = _roleUsers.Count();
               
                Response.Write("<strong> Role name " + role + " has  " +  userCount +  " users. </strong> <p/> <strong> Users in the role: </strong> <br/>");
                int num = 1;
                foreach (var roleuser in _roleUsers)
                {
                    Response.Write(num + "." + roleuser.DisplayName + " ; " + roleuser.Profile.Email +   "<br/>");
                    num++;
                }
                Response.Write("<p/><p/>");


            }
        }

    }




</script>
<!DOCTYPE html>
<html>
<head>
    <title>www.sitecore.net</title>
    <meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="/default.css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Click on the submit button to get all users  and their roles. </h2>
            <asp:Button ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" Text="Submit" />
        </div>
    </form>
</body>
</html>
