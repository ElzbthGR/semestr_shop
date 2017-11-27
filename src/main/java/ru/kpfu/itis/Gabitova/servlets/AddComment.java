package ru.kpfu.itis.Gabitova.servlets;

import ru.kpfu.itis.Gabitova.database.DataBase;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class AddComment extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        try{
            String emailUser;
            if(!(emailUser = DataBase.getEmailUser((String) getServletContext().getAttribute("token"))).equals("")) {
                DataBase.addComment(emailUser, request.getPathInfo().substring(1), request.getParameter("comment"));
                response.sendRedirect("/products/" + request.getPathInfo().substring(1));
            } else
                response.sendRedirect("/login");
        } catch (Exception e){
            response.sendRedirect("/login");
        }
    }
}
