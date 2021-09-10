package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {

    private static Connection con;

    public static Connection getConnection() {

        try {
            
            // create a new connection only if it not preesent in database otherwise return the old conncetion
            if (con == null) {
                // Load Driver Class
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Create a Connection
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "tiger");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
