package ru.kpfu.itis.Gabitova.servlets;

import ru.kpfu.itis.Gabitova.database.DataBase;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Logout extends HttpServlet{

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            DataBase.removeToken((String) getServletContext().getAttribute("token"));
            getServletContext().removeAttribute("token");
            response.addCookie(new Cookie("isRemember", "false"));
            response.sendRedirect("/login");
        } catch (Exception e) {

        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    }

}
