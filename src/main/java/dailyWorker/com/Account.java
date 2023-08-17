package dailyWorker.com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Account")
public class Account extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        try {
            String workerId = request.getParameter("phone");
            if (workerId != null && !workerId.isEmpty()) {
            	Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system",
						"manager");
               Statement pst = con.createStatement();
              
                int status = pst.executeUpdate("UPDATE labourinfo SET views = views + 1 WHERE phone = '"+workerId+"'");
                System.out.println(status);
                System.out.println(workerId);
                pst.close();
                con.close();

                if (status > 0) {
                    // WorkDone value updated successfully, you can redirect back to the worker profile page.
                    response.sendRedirect("CoustmerLogin.jsp");
                } else {
                    out.println("<p>Something went wrong. Please try again.</p>");
                }
            } else {
                out.println("<p>Invalid request. Worker ID is missing.</p>");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p>Something went wrong. Please try again.</p>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Database error. Please try again later.</p>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Unexpected error occurred. Please contact support.</p>");
        }
    }
}
