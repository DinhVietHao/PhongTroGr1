/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PostDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Category;
import model.Post;
import model.User;

/**
 *
 * @author DVHao
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/Home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        PostDAO postDao = new PostDAO();
        int countPost = postDao.selectCountPost();

        String pageRaw = request.getParameter("page");
        int page = 1;
        try {
            if (pageRaw != null) {
                page = Integer.parseInt(pageRaw);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        int count = postDao.getTotalPost();
        int endPage = 0;
        if (count > 0) {
            int PAGE_SIZE = 3;
            endPage = count / PAGE_SIZE;
            if (count % PAGE_SIZE != 0) {
                endPage++;
            }
        }
        List<Post> listPostPage = postDao.pagingPost(page);
        List<Category> listCategory = (List<Category>) session.getAttribute("listCate");
        if (listCategory == null || listCategory.isEmpty()) {
            listCategory = postDao.selectAllCategory();
            session.setAttribute("listCate", listCategory);
        }

        if (listPostPage != null && user != null) {
            for (Post post : listPostPage) {
                boolean isSaved = postDao.checkIfPostIsSaved(user.getUserId(), post.getPostId());
                post.setSavedStatus(isSaved);
            }
        }

        request.setAttribute("count", countPost);
        request.setAttribute("endPage", endPage);
        request.setAttribute("listPost", listPostPage);
        request.setAttribute("page", page);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
