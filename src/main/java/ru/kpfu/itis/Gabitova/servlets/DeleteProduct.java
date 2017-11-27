package ru.kpfu.itis.Gabitova.servlets;

import ru.kpfu.itis.Gabitova.database.DataBase;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteProduct extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int idProduct = Integer.parseInt(request.getPathInfo().substring(1));
        try{
            if(DataBase.isAdmin((String) getServletContext().getAttribute("token"))){
                DataBase.deleteProduct(idProduct);
            } else
                response.sendRedirect("/login");
        } catch (Exception e){
            response.sendRedirect("/login");
        }
    }

}
