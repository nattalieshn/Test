package test.controller;

import javax.naming.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

// Extend HttpServlet class
public class ProductServlet extends HttpServlet {

    public void init() throws ServletException {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String email_address = request.getParameter("email_address");


        // Set response content type
        response.setContentType("text/html");

        // Actual logic goes here.
        PrintWriter out = response.getWriter();
        out.println(first_name+"<br/>");
        out.println(last_name+"<br/>");
        out.println(email_address+"<br/>");

        Context envContext = null;
        try {
            envContext = new InitialContext();
            out.println(envContext+"<br>");
//            NamingEnumeration<NameClassPair> list = envContext.list("java:comp/env");
//            while (list.hasMore()) {
//                NameClassPair nc = (NameClassPair)list.next();
//                out.println(nc);
//            }
//            Context initContext  = (Context)envContext.lookup("java:/comp/env");
            Context initContext = envContext;
//            DataSource ds = (DataSource)initContext.lookup("jdbc/affableBean");
            DataSource ds = (DataSource)envContext.lookup("java:/comp/env/jdbc/test");
            Connection con = ds.getConnection();

            String sql = "insert into customers (first_name,last_name,email_address)  values (?,?,?)";

            PreparedStatement stmt=con.prepareStatement(sql);
            stmt.setString(1,first_name);
            stmt.setString(2,last_name);
            stmt.setString(3,email_address);

//            int r = stmt.executeUpdate();
            if(stmt.execute()) {
                out.println("Successfully inserted");
            } else {
                out.println("Unable to insert");
            }
//            out.println("Row affect "+r+"<br>");

        }  catch (SQLException | NamingException e) {
            e.printStackTrace();
            out.print(e);
        }
    }

    public void destroy() {
        // do nothing.
    }
}