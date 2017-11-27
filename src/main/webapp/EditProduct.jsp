<%@ page import="java.sql.*" %>
<%@ page import="ru.kpfu.itis.Gabitova.database.DataBase" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.User" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WomanStore - stylish jewelry from Spain</title>
    <link href="../css/add_product.css" rel="stylesheet">
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<header>
    <div class="wrapper">
        <a href="/products"><img class="head" src="../img/head.png"></a>
    </div>
    <div class="menu">
        <table class="menu_table">
            <tr>
                <%
                try{
                    String token = (String) getServletConfig().getServletContext().getAttribute("token");
                    User user = DataBase.getUserData(token);
                    Cookie[] cookies = request.getCookies();
                    boolean isAuth = false;
                    if(token != null)
                        for(int i = 0; i < cookies.length; i++){
                            if(cookies[i].getName().equals("name") && cookies[i].getValue().equals(user.getName())){
                                isAuth = true;
                                %>
                                <td><p class="title">Hello, <%=cookies[i].getValue()%></p></td>
                                <td>|</td>
                                <td><a href="/logout">Sign out</a></td>
                                <td>|</td>
                                <td><a href="/bucket">Your bucket</a></td>
                                <%if(user.isAdmin()){%>
                                    <td>|</td>
                                    <td><a href="/add_product">Add product</a></td>
                                <%}
                            }
                        }
                    if(!isAuth){
                        response.sendRedirect("/login");
                    }
                } catch (Exception e){
                    response.sendRedirect("/login");
                }%>
            </tr>
        </table>
    </div>
</header>

<div class="content">
    <div id="select" class="content_select">
        <p>Edit product</p>
        <hr>
        <%
            try{
                Product product = DataBase.getProductByIdData(request.getPathInfo().substring(1));
                %>
                <form method="post" action="/editProduct/<%=request.getPathInfo().substring(1)%>">

                    <table class="form">
                        <tr id="title">
                            <td>Title</td>
                            <td><input class="input" name="title" type="text" value="<%=product.getTitle()%>" required autofocus></td>
                        </tr>
                        <tr id="price">
                            <td>Price</td>
                            <td><input class="input" name="price" type="number" value="<%=product.getPrice()%>" required></td>
                        </tr>

                        <tr id="description">
                            <td>Description</td>
                            <td><input class="input" name="description" type="text" value="<%=product.getDescription()%>" required></td>
                        </tr>

                        <tr id="photo_url">
                            <td>Photo</td>
                            <td><input class="input_photo" name="photo_url" type="file" value="<%=product.getPhotoUrl()%>" required></td>
                        </tr>
                    </table>
                    <input class="btn" type="submit" value="Edit">
                </form>
                <%
            } catch (Exception e){

            }
        %>
    </div>
</div>

<div class="footer">
    <table class="footer_social">
        <tr>
            <td class="contacts">Our general office:<br>
                Saint Petersburg, Shotman street, h. 20</td>
            <td class="contacts">Phone for information:<br>
                +7-(495)-543-25-25</td>
        </tr>
    </table>
    <table class="footer_social_buttons">
        <tr>
            <td class="button"><img src="../img/vk.png"></td>
            <td class="button"><img src="../img/fb.png"></td>
            <td class="button"><img src="../img/tw.png"></td>
        </tr>
    </table>
</div>
</body>
</html>