<%@ page import="java.sql.*" %>
<%@ page import="ru.kpfu.itis.Gabitova.database.DataBase" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.User" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.Product" %>
<%@ page import="ru.kpfu.itis.Gabitova.models.Comment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WomanStore - stylish jewelry from Spain</title>
    <link href="../../css/product_detail.css" rel="stylesheet">
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
            boolean isAuth = false;
            try{
                String token = (String) getServletConfig().getServletContext().getAttribute("token");
                User user = DataBase.getUserData(token);
                Cookie[] cookies = request.getCookies();
                isAuth = false;
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
        <p>About product</p>
        <hr>
        <%
            try{
                Product product = DataBase.getProductByIdData(request.getPathInfo().substring(1));
                %>
                <div class="goods_all">
                    <div class="goods_info">
                        <img class="goods_img" src="goods/<%=product.getPhotoUrl()%>">
                    </div>

                    <div class="goods_info" id="description">

                        <table>
                            <tr><h1>Name of product: <%=product.getTitle()%></h1><br></tr>
                            <tr>
                                <td>Description:</td>
                                <td class="info"><%=product.getDescription()%></td>
                            </tr>
                            <tr>
                                <td>Price:</td>
                                <td class="info"><%=product.getPrice()%></td>
                            </tr>
                            <tr>
                                <td>Added:</td>
                                <td class="info"><%=product.getDateCreate()%></td>
                            </tr>
                        </table>
                        <%if(isAuth){%>
                        <input class="btn" type="submit" title="add" value=" + Add to bucket"><br>
                        <%}%>
                    </div>
                </div>
                <%
            } catch (Exception e){

            }
        %>
        <div class="comment">
            <form method="post" action="/addComment/<%=request.getPathInfo().substring(1)%>">
                <div id="comment">
                    <input name="comment" type="text" class="comment_field" required/>
                </div>
                <input type="submit" class="write_btn" value="To write">
            </form>
            <hr>
            <%
                try{
                    ArrayList<Comment> comments = DataBase.getCommentsToProduct(request.getPathInfo().substring(1));
                    for (int i = 0; i < comments.size(); i++) {
            %>
            <div class="comments">
                <a class="user"><%=comments.get(i).getNameUser()%></a><br><br>
                <a class="comment_text"><%=comments.get(i).getText()%></a>
                <hr>
            </div>
            <%
                    }
                } catch (Exception ex) {

                }
            %>
        </div>
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