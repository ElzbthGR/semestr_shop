<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WomanStore - стильная бижутерия из Испании</title>
    <link href="../css/registration.css" rel="stylesheet">
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<header>
    <div class="wrapper">
        <img class="head" src="../img/head.png">
    </div>
</header>

<div class="content">
    <div id="select" class="content_select">
        <p class="registration">Registration</p>
        <hr>
        <form method="post" action="/addUser">
                <table class="form" id="title">
                    <tr>
                        <td>Name</td>
                        <td><input class="input" name="name" type="text" required autofocus></td>
                    </tr>
                    <tr id="email">
                        <td>E-mail</td>
                        <td><input class="input" name="email" type="email" required></td>
                    </tr>

                    <tr id="password">
                        <td>Password</td>
                        <td><input class="input" name="password" type="password" required></td>
                    </tr>
                    <tr id="password_2">
                        <td>Repeat password</td>
                        <td><input class="input" name="password_2" type="password" required></td>
                    </tr>

                </table>
                <%
                Cookie[] cookies = request.getCookies();
                for(int i = 0; i < cookies.length; i++){
                    if(cookies[i].getName().equals("isError")){
                        if(cookies[i].getValue().equals("1")){
                            %>
                            <script>
                                alert('PASSWORD DO NOT MATCH!');
                            </script>
                            <%
                        } else if(cookies[i].getValue().equals("2")){
                            %>
                            <script>
                                alert('E-MAIL ALREADY TAKEN!');
                            </script>
                            <%
                        }
                        cookies[i].setMaxAge(0);
                        response.addCookie(cookies[i]);
                    }
                }
                %>
            <input class="sign_up" id="registration" type="submit" value="Sign up">
        </form>
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
