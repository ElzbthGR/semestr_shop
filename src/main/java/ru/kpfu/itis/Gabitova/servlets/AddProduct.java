package ru.kpfu.itis.Gabitova.servlets;

import ru.kpfu.itis.Gabitova.database.DataBase;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddProduct extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
//        String title = request.getParameter("title");
//        String description = request.getParameter("description");
//        String photo_url = request.getParameter("photo_url");
//        String price = request.getParameter("price");

        try{
            if(DataBase.isAdmin((String) getServletContext().getAttribute("token"))){
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String photo_url = request.getParameter("photo_url");
                String price = request.getParameter("price");
                DataBase.addProduct(title, description, photo_url, price);
                response.sendRedirect("/products");
            } else
                response.sendRedirect("/login");
        } catch (Exception e){
            response.sendRedirect("/products");
        }
    }

}
