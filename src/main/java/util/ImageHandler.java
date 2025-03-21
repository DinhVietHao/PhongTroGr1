/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import controller.ImageHandlerServlet;
import dao.ImageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Avatar;
import model.Image;

/**
 *
 * @author DVHao
 */
public class ImageHandler {
    
    public static void uploadImage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int postId = Integer.parseInt(request.getParameter("postId"));

            Part filePart = request.getPart("photo");

            // Kiểm tra nếu không có file hoặc file rỗng
            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("errorMessage", "Vui lòng chọn một hình ảnh.");
                request.getRequestDispatcher("uploadImages.jsp").forward(request, response);
                return;
            }

            // Kiểm tra kích thước file (nếu vượt quá 16MB thì báo lỗi)
            if (filePart.getSize() > 10 * 1024 * 1024) {
                request.setAttribute("errorMessage", "File quá lớn! Vui lòng chọn ảnh nhỏ hơn 10MB.");
                request.getRequestDispatcher("uploadImages.jsp").forward(request, response);
                return;
            }

            try ( InputStream inputStream = filePart.getInputStream()) {  // Đảm bảo đóng InputStream
                ImageDAO uploadDAO = new ImageDAO();
                boolean isUploaded = uploadDAO.uploadImage(postId, inputStream);

                if (isUploaded) {
                    response.sendRedirect("ImageHandler");
                } else {
                    request.setAttribute("errorMessage", "Tải ảnh thất bại. Hãy thử lại!");
                    request.getRequestDispatcher("uploadImages.jsp").forward(request, response);
                }
            }
        } catch (ServletException | IOException | NumberFormatException e) {
            request.setAttribute("errorMessage", "Lỗi trong quá trình upload!");
            request.getRequestDispatcher("uploadImages.jsp").forward(request, response);
        }
    }
    
    

    public static void displayImage(HttpServletRequest request, HttpServletResponse response) {
        try {
            int imageId = Integer.parseInt(request.getParameter("imgId")); // Lấy ID ảnh

            ImageDAO upload = new ImageDAO();
            Image img = upload.getImagesById(imageId); // Lấy ảnh từ DB

            if (img != null && img.getImageData() != null) {
                byte[] imageData = img.getImageData();
                response.setContentType("image/jpeg"); // Hoặc "image/png" nếu là PNG
                response.setContentLength(imageData.length);
                response.getOutputStream().write(imageData);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (IOException | NumberFormatException e) {
            Logger.getLogger(ImageHandlerServlet.class.getName()).log(Level.SEVERE, "Error displaying image", e);
        }
    }
    
     public static void displayAvatar(HttpServletRequest request, HttpServletResponse response) {
        try {
            int userID = Integer.parseInt(request.getParameter("userId"));

            ImageDAO upload = new ImageDAO();
            Avatar avt = upload.getAvatarByUserId(userID);

            if (avt != null && avt.getImageData() != null) {
                byte[] imageData = avt.getImageData();
                response.setContentType("image/jpeg");
                response.setContentLength(imageData.length);
                response.getOutputStream().write(imageData);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (IOException | NumberFormatException e) {
            Logger.getLogger(ImageHandlerServlet.class.getName()).log(Level.SEVERE, "Error displaying image", e);
        }
    }

}
