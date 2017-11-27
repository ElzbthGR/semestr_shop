<%@ page import="java.util.UUID" %>
<%@ page import="java.sql.*" %>
<%@ page import="ru.kpfu.itis.Gabitova.database.DataBase" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.User" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WomanStore - stylish jewelry from Spain</title>
    <link href="img/236.ico" rel="shortcut icon" type="image/x-icon">
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
                int numberPage = 1;
                boolean isAdmin = false;
                boolean isAuth = false;
                try{
                    String token = (String) getServletConfig().getServletContext().getAttribute("token");
                    User user = DataBase.getUserData(token);
                    Cookie[] cookies = request.getCookies();
                    isAdmin = user.isAdmin();
                    numberPage = 1;
                    numberPage = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
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
                    if(!isAuth){%>
                        <td><a href="/login">Sign in</a></td>
                        <td>|</td>
                        <td><a href="/registration">Registration</a></td>
                    <%}
                } catch (Exception e){%>
                    <td><a href="/login">Sign in</a></td>
                    <td>|</td>
                    <td><a href="/registration">Registration</a></td>
                <%}%>
            </tr>
        </table>
    </div>
</header>

<div class="content">
    <div id="select" class="content_select">
        <div class="content_boxes">
            <%
            boolean hasNextPage = false;
                try {
                    ArrayList<Product> products = DataBase.getAllProductsData();
                    int j = 0, k = (numberPage-1)*9;
                    while (k < products.size() && j < 3){
                        j++;
                        for (int i = 0; i < 3 && k < products.size(); i++) {
                            %>
                            <form method="get">
                                <div class="box_info">
                                    <%if(isAuth){%>
                                        <input type="image" src="img/plus.jpg" class="add img_size" id="<%=products.get(k).getId()%>" value="В корзину">
                                    <%}%>
                                    <%if(isAuth && isAdmin){%>
                                        <input type="image" src="img/buck.png" class="delete img_size" id="<%=products.get(k).getId()%>" value="Удалить">
                                    <%}%><br>
                                    <a href="/products/<%=products.get(k).getId()%>">
                                    <img class="img_min" src="goods/<%=products.get(k).getPhotoUrl()%>">
                                    <h1 class="describe"><%=products.get(k).getTitle()%></h1>
                                    <p class="describe"><%=products.get(k).getPrice()%></p>
                                    <p class="describe"><%=products.get(k).getDateCreate()%></p>
                                    <%if(isAdmin){%>
                                        <a href="/edit_product/<%=products.get(k).getId()%>">edit</a>
                                    <%}%>
                                </a></div>
                            </form>
                            <%
                            k++;
                        }
                    }
                    if(k < products.size())
                        hasNextPage = true;
            } catch (Exception e){

            }%>
        </div><br>
        <div class="pages">
            <%if(numberPage > 1){%>
            <span><a id="page1" href="/products?page=<%=numberPage-1%>"><%=numberPage-1%></a></span>
            <%}%>
            <span><a id="page2" href="/products?page=<%=numberPage%>"><%=numberPage%></a></span>
            <%if(hasNextPage){%>
            <span><a id="page3" href="/products?page=<%=numberPage+1%>"><%=numberPage+1%></a></span>
            <%}%>
        </div><br>
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
    <script src="../js/products.js"></script>
</div>
</body>
</html>
