package ru.kpfu.itis.Gabitova.servlets;

import ru.kpfu.itis.Gabitova.database.DataBase;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Auth extends HttpServlet{
    private String email;
    private String password;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        email = request.getParameter("email");
        password = request.getParameter("password");

        try{
            String name;
            if((name = DataBase.isUserExist(email, password)).equals("")){
                Cookie cookie = new Cookie("isInvalid", "true");
                cookie.setMaxAge(20);
                response.addCookie(cookie);
                response.sendRedirect("/login");
            } else {
                String isRemember = request.getParameter("isRemember");
                String token = DataBase.getToken(email);
                getServletContext().setAttribute("token", token);
                Cookie nameCookie = new Cookie("name", name);
                if(isRemember != null && isRemember.equals("on"))
                    nameCookie.setMaxAge(60*60*24*365*10);
                response.addCookie(nameCookie);
                response.sendRedirect("/products");
            }
        } catch (Exception e) {
            System.out.println("DataBase is dead");
        }
    }

}
