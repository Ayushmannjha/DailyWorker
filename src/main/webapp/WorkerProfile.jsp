<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%!
String workerId = "";
String workerName ="";
String workerSpecialty = "";
String workerAddress = "";
String WorkerPhone = "";
int workDone = 0;
%>
<% String phone = (String) request.getAttribute("phone"); %>
<% 
            try {
            	Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system","manager");
               // String query = "SELECT * FROM labourinfo WHERE PHONE = ?";
                PreparedStatement pst = con.prepareStatement("SELECT * FROM labourinfo WHERE PHONE = ?");
                pst.setString(1, phone); // Set the email parameter
                ResultSet rs  = pst.executeQuery();
                while (rs.next()) {
                    workerId = rs.getString(2);
                    workerName = rs.getString(1);
                    WorkerPhone = rs.getString(3);
                    workerSpecialty = rs.getString(4);
                    workerAddress = rs.getString(5);
                    workDone = rs.getInt(6); // Get the workDone value
                }
                rs.close();
                pst.close();
                con.close();
            } catch (Exception e) {
               System.out.println(e+" "+phone);
            }
            %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;300;400;500&family=Varela+Round&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="profile.css" />
    <link rel="stylesheet"
href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
  </head>

  <style>
    h1{
        margin-top: 20px;
    }
    .container{
        width: 90%;
        max-width: 400px;
        margin: auto;
        position: absolute;
        top: 50%;
        left: 50%;
        height: auto;
        min-height: 500px;
        background-color: #222222;
        transform: translate(-50% ,-50%);
        border-radius: 8px;
        border-top: 30px solid #F97F51;
        border-bottom: 30px solid #F97F51;
        box-shadow: rgba(0, 0, 0, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px;
    }
    .box{
       padding: 5%;
       margin: auto;
       /* border: 2px solid ; */
    }

    .box img{
        width: 90px;
        max-height: 90px;
        margin: auto;
        display: flex;
        align-items: center;
        /* border: 1px solid #ff4400; */
        border-radius: 50%;
        margin-bottom: 12px;
    }

    
    span{
        margin-right: 50px;
        color: #ff9900;
        width: auto;
        min-width: 100px;
        display: inline-block;
    }

    p{
        margin-bottom: 10px;
        font-size: 18px ;
    }
    h1{
        text-align: center;
        font-size: 30px;
        margin-bottom: 3%;
    }

    h4{
        color: #F97F51;
    }
  </style>
  <body>
    <h1>Labour Profile</h1>
    <div class="container">
        
        <div class="box">
           <div class="img">
            <img src="./johny.jpeg" alt="">
           </div>
           <p><span>Name</span><%=workerName %></p>
           <p><span>Proffesion</span><%=workerSpecialty %></p>
           <p><span>Profile Visits</span><%=workDone %></p>
           <p><span>Contact</span><%=WorkerPhone %></p>
           
           <p><span>Area</span><%=workerAddress %></p>
          
           
        </div>
    </div>
    </body>
    </html>