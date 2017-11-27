<%@ page import="java.util.UUID" %>
<%@ page import="java.sql.*" %>
<%@ page import="ru.kpfu.itis.Gabitova.database.DataBase" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WomanStore - stylish jewelry from Spain</title>
    <link href="../css/products.css" rel="stylesheet">
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
                String emailUser = "";
                try{
                    String token = (String) getServletConfig().getServletContext().getAttribute("token");
                    User user = DataBase.getUserData(token);
                    emailUser = user.getEmail();
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
        <div class="content_boxes">
            <%
            int generalPrice = 0;
            try {
                ArrayList<Product> products = DataBase.getUserProductsData(emailUser);
                for (int i = 0; i < products.size(); i++) {
                    %>
                    <form method="get">
                        <div class="box_info">
                            <input type="image" src="img/buck.png" class="delete img_size" id="<%=products.get(i).getId()%>" value="Удалить">
                            <br>
                            <a href="/products/<%=products.get(i).getId()%>">
                                <img class="img_min" src="goods/<%=products.get(i).getPhotoUrl()%>">
                                <h1 class="describe"><%=products.get(i).getTitle()%></h1>
                                <p class="describe"><%=products.get(i).getPrice()%></p>
                                <p class="describe"><%=products.get(i).getDateCreate()%></p>
                            </a>
                        </div>
                    </form>
                    <%
                    generalPrice += products.get(i).getPrice();
                }
            } catch (Exception e){

            }%>
        </div><br>
        <span class="final">
            <label>Итого: <input type="text" disabled id="general_price" value="<%=generalPrice%>"></label>
            <input type="button" id="buy" value="BUY">
            <br>
        </span>

        <script src="../js/bucket.js"></script>
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
