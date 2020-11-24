import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public class Administrator {

    public static void main(String[] agrs) {

        String dbname = "mehdic"; // Input your UiO-username
        String user = "mehdic_priv"; // Input your UiO-username + _priv
        String pwd = "Ohgiey6hae'"; // Input the password for the _priv-user you got in a mail
        // Connection details
        String connectionStr =
            "user=" + user + "&" +
            "port=5432&" +
            "password=" + pwd + "";

        String host = "jdbc:postgresql://dbpg-ifi-kurs01.uio.no";
        String connectionURL =
            host + "/" + dbname +
            "?sslmode=require&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory&" +
            connectionStr;

        try {
            // Load driver for PostgreSQL
            Class.forName("org.postgresql.Driver");
            // Create a connection to the database
            Connection connection = DriverManager.getConnection(connectionURL);

            int ch = 0;
            while (ch != 3) {
                System.out.println("-- ADMINISTRATOR --");
                System.out.println("Please choose an option:\n 1. Create bills\n 2. Insert new product\n 3. Exit");
                ch = getIntFromUser("Option: ", true);

                if (ch == 1) {
                    makeBills(connection);
                } else if (ch == 2) {
                    insertProduct(connection);
                }
            }
        } catch (SQLException|ClassNotFoundException ex) {
            System.err.println("Error encountered: " + ex.getMessage());
        }
    }

    private static void makeBills(Connection connection)  throws SQLException {
      String name = "";
      String address = "";
      float price = 0;
      String username = getStrFromUser("Username: ");
      String usrid = "SELECT b.name, b.address, SUM(p.price + o.num) as totalDue FROM ws.users b INNER JOIN ws.orders o on b.uid = o.uid INNER JOIN ws.products p ON o.pid = p.pid WHERE payed = 0 GROUP BY (b.name, b.address);";
      String usrpid = "SELECT b.name, b.address, SUM(p.price + o.num) as totalDue FROM ws.users b INNER JOIN ws.orders o on b.uid = o.uid INNER JOIN ws.products p ON o.pid = p.pid WHERE payed = 0 AND username = ? GROUP BY (b.name, b.address);";
      PreparedStatement statement = connection.prepareStatement(usrid);

      if (username.isEmpty()){
        statement = connection.prepareStatement(usrid);
      } else{
        statement = connection.prepareStatement(usrpid);
        statement.setString(1, username);
      }
      ResultSet results = statement.executeQuery();

      try{
        while (results.next()){
          name = results.getString("name");
          address = results.getString("address");
          price = results.getFloat("totalDue");
          System.out.print("---Bill--- \n");
          System.out.print("Name: " + name + "\n");
          System.out.print("Address: " + address + "\n");
          System.out.println("Total due: " + price + "\n");
        }
      } catch (SQLException e){
        e.printStackTrace();
      }
    }


    private static void insertProduct(Connection connection) throws SQLException {
      System.out.println("-- INSERT NEW PRODUCT --");
      String products = "INSERT INTO ws.products as p (name, price, cid, description) VALUES (?, ?, (SELECT cid FROM ws.categories as c WHERE c.cid = ?), ?);";
      PreparedStatement statement = connection.prepareStatement(products);
      String name = getStrFromUser("Product name: ");
      String stringName = new String(name);
      String price = getStrFromUser("Price: ");
      Float floatPrice = new Float(price);
      System.out.println("-- SELECT PRODUCT CATEGORY --");
      System.out.println(" 1: Food ");
      System.out.println(" 2: Electronics ");
      System.out.println(" 3: Clothing ");
      System.out.println(" 4: Games ");
      String category = getStrFromUser("Category type: ");
      Integer intCategory = new Integer (category);
      String description = getStrFromUser("Description: ");
      statement.setString(1, stringName);
      statement.setFloat(2, floatPrice);
      statement.setInt(3, intCategory);
      statement.setString(4, description);
      statement.executeUpdate();
      String products2 = "SELECT p.name, p.price, c.name, p.description from ws.products p INNER JOIN ws.categories c using (cid) WHERE p.name LIKE " + "'%" + stringName + "%'" + ";";
      statement = connection.prepareStatement(products2);
      ResultSet results2 =  statement.executeQuery();

      while (results2.next()){
        System.out.println("Product name: " + results2.getString(1));
        System.out.println("Price: " + results2.getFloat(2));
        System.out.println("Category: " + results2.getString(3));
        System.out.println("Description: " + results2.getString(4));
      };
    }

    /**
     * Utility method that gets an int as input from user
     * Prints the argument message before getting input
     * If second argument is true, the user does not need to give input and can leave
     * the field blank (resulting in a null)
     */
    private static Integer getIntFromUser(String message, boolean canBeBlank) {
        while (true) {
            String str = getStrFromUser(message);
            if (str.equals("") && canBeBlank) {
                return null;
            }
            try {
                return Integer.valueOf(str);
            } catch (NumberFormatException ex) {
                System.out.println("Please provide an integer or leave blank.");
            }
        }
    }

    /**
     * Utility method that gets a String as input from user
     * Prints the argument message before getting input
     */
    private static String getStrFromUser(String message) {
        Scanner s = new Scanner(System.in);
        System.out.print(message);
        return s.nextLine();
    }
}
