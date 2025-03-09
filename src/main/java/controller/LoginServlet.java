/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author DVHao
 */
@WebServlet(name="LoginServlet", urlPatterns={"/Login"})
public class LoginServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        UserDAO userDao = new UserDAO();
        userDao.deleteUnverifiedAccounts();
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("loginname");
        String password = request.getParameter("password");
        UserDAO userdao = new UserDAO();
        User user = userdao.verifyMD5(username, password);
        HttpSession session = request.getSession();
        if(user.getUserId() != -1){
            session.setAttribute("user", user);
            response.sendRedirect("Home?action=Role&role=" + user.getRole());
        }else{
            request.setAttribute("err", "<p style='color:red'>Tên đăng nhập hoặc mật khẩu không đúng!</p>");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
