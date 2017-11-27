package ru.kpfu.itis.Gabitova.database;

import ru.kpfu.itis.Gabitova.models.Comment;
import ru.kpfu.itis.Gabitova.models.Product;
import ru.kpfu.itis.Gabitova.models.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.UUID;

public class DataBase {

    public static void addUser(String email, String password, String name) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        statement.executeUpdate("INSERT INTO users(email, password, name, is_admin) " +
                "VALUES ('" + email + "','" + password + "','" + name + "', 0" + ")");
        statement.close();
        c.close();
    }

    public static void addProductToBucket(String email_user, int idProduct) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        statement.executeUpdate("INSERT INTO bucket(email_user, id_product) " +
                "VALUES('" + email_user + "', " + idProduct + ")");
        statement.close();
        c.close();
    }

    public static void deleteProductFromBucket(String email_user, int idProduct) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        statement.executeUpdate("DELETE FROM bucket " +
                "WHERE email_user = '" + email_user + "' AND id_product = " + idProduct);
        statement.close();
        c.close();
    }

    public static void addProduct(String title, String description, String photo_url, String price) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        statement.executeUpdate("INSERT INTO products(title, description, photo_url, price)" +
                "VALUES('" + title + "', '" + description + "', '" + photo_url + "', '" + price + "')");
        statement.close();
        c.close();
    }

    public static void deleteProduct(int idProduct) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        statement.executeUpdate("DELETE FROM products WHERE id = " + idProduct);
        statement.close();
        c.close();
    }

    public static void addComment(String emailUser, String id_product, String comment) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        statement.executeUpdate("insert into comments(email_user, id_product, comment) " +
                "values('" + emailUser + "', " + id_product + ", '" + comment + "')");
        statement.close();
        c.close();
    }

    public static void editProduct(String title, String description, String photo_url, String price, String id) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        statement.executeUpdate("UPDATE products SET title = '" + title + "', description = '" + description +
                "', photo_url = '" + photo_url + "', price = " + price + " WHERE id = " + id);
        statement.close();
        c.close();
    }

    public static String getToken(String email) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        String token = UUID.randomUUID().toString();
        statement.executeUpdate("DELETE FROM tokens WHERE email = '" + email + "'");
        statement.executeUpdate("INSERT INTO tokens (email, token) VALUES('" + email + "','" + token + "')");
        statement.close();
        c.close();
        return token;
    }

    public static void removeToken(String token) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        statement.executeUpdate("DELETE FROM tokens WHERE token = '" + token + "'");
        statement.close();
        c.close();
    }

    public static String getEmailUser(String token) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        ResultSet email = statement.executeQuery("SELECT email FROM tokens WHERE token = '" + token + "'");
        email.next();
        String emailUser = email.getString("email");
        email.close();
        statement.close();
        c.close();
        return emailUser;
    }

    public static User getUserData(String token) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        ResultSet email = statement.executeQuery("SELECT email FROM tokens WHERE token = '" + token + "'");
        email.next();
        ResultSet user = statement.executeQuery("SELECT * FROM users WHERE email = '" + email.getString("email") + "'");
        user.next();
        return new User(user.getString("name"), user.getString("email"), user.getInt("is_admin"));
    }

    public static ArrayList<Product> getUserProductsData(String emailUser) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        ResultSet bucket = statement.executeQuery("SELECT * FROM bucket WHERE email_user = '" + emailUser + "'");
        bucket.next();
        String sqlRequest = "SELECT * FROM products WHERE id = '" + bucket.getInt("id_product") + "'";
        bucket.next();
        while (!bucket.isAfterLast()){
            sqlRequest += " OR id = '" + bucket.getInt("id_product") + "'";
            bucket.next();
        }
        ResultSet products = statement.executeQuery(sqlRequest);
        products.next();
        ArrayList<Product> productsList = new ArrayList<>();
        while (!products.isAfterLast()){
            productsList.add(new Product(products.getInt("id"), products.getString("title"), products.getString("description"),
                    products.getString("date_create"), products.getString("photo_url"), products.getInt("price")));
            products.next();
        }
        bucket.close();
        products.close();
        statement.close();
        c.close();
        return productsList;
    }

    public static ArrayList<Product> getAllProductsData() throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        ResultSet products = statement.executeQuery("SELECT * FROM products ORDER BY date_create DESC");
        products.next();
        ArrayList<Product> productsList = new ArrayList<>();
        while (!products.isAfterLast()){
            productsList.add(new Product(products.getInt("id"), products.getString("title"), products.getString("description"),
                    products.getString("date_create"), products.getString("photo_url"), products.getInt("price")));
            products.next();
        }
        products.close();
        statement.close();
        c.close();
        return productsList;
    }

    public static ArrayList<Comment> getCommentsToProduct(String id) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        ResultSet comments = statement.executeQuery("SELECT * FROM comments WHERE id_product = " + id);
        comments.next();
        ArrayList<Comment> commentsList = new ArrayList<>();
        while (!comments.isAfterLast()){
            commentsList.add(new Comment(comments.getString("email_user"), comments.getString("comment")));
            comments.next();
        }
        comments.close();
        statement.close();
        c.close();
        return commentsList;
    }

    public static Product getProductByIdData(String id) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        ResultSet product = statement.executeQuery("SELECT * FROM products WHERE id = " + id);
        product.next();
        Product productItem = new Product(product.getInt("id"), product.getString("title"), product.getString("description"),
                product.getString("date_create"), product.getString("photo_url"), product.getInt("price"));
        product.close();
        statement.close();
        c.close();
        return productItem;
    }

    public static boolean isAdmin(String token) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        ResultSet email = statement.executeQuery("SELECT email FROM tokens WHERE token = '" + token + "'");
        email.next();
        ResultSet user = statement.executeQuery("SELECT * FROM users WHERE email = '" + email.getString("email") + "'");
        user.next();
        if(user.getInt("is_admin") == 0)
            return false;
        user.close();
        statement.close();
        c.close();
        return true;
    }

    public static String isUserExist(String email, String password) throws Exception {
        Class.forName("org.postgresql.Driver");
        Connection c = DriverManager.getConnection("jdbc:postgresql://localhost/Shop", "postgres", "mors1k13");
        Statement statement = c.createStatement();
        ResultSet users = statement.executeQuery("SELECT * FROM users");
        while(users.next())
            if(users.getString("email").equals(email) && users.getString("password").equals(password))
                return users.getString("name");
        users.close();
        statement.close();
        c.close();
        return "";
    }
}
