package dailyWorker.com;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//... (Your import statements)

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
     String phone = request.getParameter("phone");
     Long phoneNumber = Long.parseLong(phone);
     String password = request.getParameter("password"); // Change "Password" to "password"

     try {
         // Replace these with your database credentials
         String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
         String dbUsername = "system";
         String dbPassword = "manager";

         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
         PreparedStatement statement = connection.prepareStatement("SELECT * FROM users WHERE PHONE = ? AND PASSWORD = ?");
         statement.setLong(1, phoneNumber);
         statement.setString(2, password); // Change "Password" to "password"
         ResultSet resultSet = statement.executeQuery();

         if (resultSet.next()) {
             // Email and password match, forward to the profile page with attributes
             request.setAttribute("phone", phone);
             request.setAttribute("password", password);
             request.getRequestDispatcher("WorkerProfile.jsp").forward(request, response);
         } else {
             // Email or password is incorrect, redirect back to the login page with an error message
             response.sendRedirect("Login.html?error=1");
         }

         resultSet.close();
         statement.close();
         connection.close();
     } catch (ClassNotFoundException | SQLException e) {
         if(((SQLException) e).getErrorCode()>=900&&((SQLException) e).getErrorCode()<=999) {
        	 System.out.println("Invalid column name");
         }
         // Handle any exceptions here and redirect back to the login page with an error message if needed
         response.sendRedirect("Login.html?error=2");
     }
 }
}
