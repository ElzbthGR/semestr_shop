package ru.kpfu.itis.Gabitova.servlets;

import ru.kpfu.itis.Gabitova.database.DataBase;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddUser extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
//        String name = request.getParameter("name");
//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//        String password2 = request.getParameter("password_2");

        if (!request.getParameter("password").equals(request.getParameter("password_2"))) {
            sendError("1", response);
        } else if(!request.getParameter("email").matches("^([a-z0-9_-]+\\.)*[a-z0-9_-]+@[a-z0-9_-]+(\\.[a-z0-9_-]+)*\\.[a-z]{2,6}$")){
            sendError("2", response);
        } else {
            try {
                DataBase.addUser(request.getParameter("email"), request.getParameter("password"), request.getParameter("name"));
                response.sendRedirect("/login");
            } catch (Exception e) {
                sendError("2", response);
            }
        }
    }

    private void sendError(String textError, HttpServletResponse response){
        Cookie cookie = new Cookie("isError", textError);
        cookie.setMaxAge(100);
        response.addCookie(cookie);
        try {
            response.sendRedirect("/registration");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
