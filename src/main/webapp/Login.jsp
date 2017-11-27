<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<html>
<head>
    <title>Login</title>
    <link href="css/login.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
    <div class="all">
        <div class="wrapper">
            <p>Authorization</p>
            <hr>
            <%
            Cookie[] cookies = request.getCookies();
            if(cookies != null)
                for(int i = 0; i < cookies.length; i++){
                    if(cookies[i].getName().equals("isInvalid") && cookies[i].getValue().equals("true")){
                        cookies[i].setMaxAge(0);
                        response.addCookie(cookies[i]);
                        %>
                        <script>
                            alert('INCORRECT E-MAIL/PASSWORD!');
                        </script>
                        <%
                    } else if(cookies[i].getName().equals("name")
                            && getServletConfig().getServletContext().getAttribute("token") != null){
                        response.sendRedirect("/products");
                    }
                }
            %>
            <form class="worksheet" method="post" action="/auth">
                <div class="data" id="email">
                    <span class="label">enter e-mail</span>
                    <p class="description">E-mail</p>
                    <input class="input" type="text" name="email" placeholder="Enter e-mail" required>
                </div>

                <div class="data" id="password">
                    <span class="label">enter password</span>
                    <p class="description" id="mar_pass">Password</p>
                    <input class="input" type="password" name="password" placeholder="Enter password" required>
                </div>
                <input class="checkbox" name="isRemember" type="checkbox"><a>remember me</a><br>
                <input class="sign_in" type="submit" value="Sign in">
            </form>
            <a id="registration" href="/registration">Are not registered?</a><br>
            <script src="js/login.js"></script>
        </div>
        <script src="js/trans.js"></script>
    </div>
</body>
</html>
