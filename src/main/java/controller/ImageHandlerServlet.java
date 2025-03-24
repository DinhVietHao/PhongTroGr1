/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ImageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Image;
import util.ImageHandler;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ImageHandlerServlet", urlPatterns = {"/ImageHandler"})
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class ImageHandlerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("Home");
            return;
        }
        
        if (action.equalsIgnoreCase("display")) {
            ImageHandler.displayImage(request, response);
        } else if(action.equalsIgnoreCase("displayAvatar")){
            ImageHandler.displayAvatar(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("upload")) {
            ImageHandler.uploadImage(request, response);
        }
    }

}
