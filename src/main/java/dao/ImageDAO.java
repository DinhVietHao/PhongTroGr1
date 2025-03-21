/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.DBContext;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Avatar;
import model.Image;

/**
 *
 * @author ASUS
 */
public class ImageDAO extends DBContext {

    public boolean uploadImage(int postId, InputStream imageStream) throws IOException {
        String sql = "INSERT INTO Images (Post_id, Photo) VALUES (?, ?)";

        if (imageStream == null || imageStream.available() == 0) {
            System.out.println("Lỗi: Dữ liệu ảnh rỗng hoặc null.");
            return false;
        }

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);
            if (imageStream != null) {
                ps.setBinaryStream(2, imageStream);
            } else {
                ps.setNull(2, java.sql.Types.BLOB);
            }

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("Upload ảnh thành công!");
                return true;
            } else {
                System.out.println("Upload ảnh thất bại! Không có dòng nào được chèn.");
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi upload ảnh: " + e.getMessage());
        }
        return false;
    }
    
    public boolean deleteAllImageByPostId(int postId) throws IOException {
        String sql = "DELETE FROM Images WHERE Post_id = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, postId);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("Delete thành công");
                return true;
            } else {
                System.out.println("error");
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi delete ảnh: " + e.getMessage());
            return false;
        }
        return false;
    }

    public boolean updateAvatar(int userId, InputStream avatarStream) {
        String sql = "UPDATE Users SET Avatar = ? WHERE User_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBlob(1, avatarStream);
            stmt.setInt(2, userId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public ArrayList<Image> getAllImage() {
        String sql = "SELECT Image_id, Post_id, Photo FROM Images";
        ArrayList<Image> imageList = new ArrayList<>();

        try ( PreparedStatement ps = conn.prepareStatement(sql);) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int imageId = rs.getInt("Image_id");
                int postId = rs.getInt("Post_id");
                byte[] imageData = rs.getBytes("Photo");

                Image img = new Image(imageId, postId, imageData);
                imageList.add(img);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return imageList;
    }

    public ArrayList<Image> getImagesByPostId(int post_id) {
        String sql = "SELECT Image_id, Post_id, Photo FROM Images Where Post_id = ?";
        ArrayList<Image> imageList = new ArrayList<>();

        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, post_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int imageId = rs.getInt("Image_id");
                int postId = rs.getInt("Post_id");
                byte[] imageData = rs.getBytes("Photo");

                Image img = new Image(imageId, postId, imageData);
                imageList.add(img);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return imageList;
    }

    public Image getImagesById(int image_id) {
        String sql = "SELECT Image_id, Post_id, Photo FROM Images Where Image_id = ?";

        Image img = null;
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, image_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int imageId = rs.getInt("Image_id");
                int postId = rs.getInt("Post_id");
                byte[] imageData = rs.getBytes("Photo");

                img = new Image(imageId, postId, imageData);
                return img;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return img;
    }
    
    public Avatar getAvatarByUserId(int User_id) {
        String sql = "SELECT User_id, Avatar FROM Users Where User_id = ?";

        Avatar avt = null;
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, User_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("User_id");
                byte[] imageData = rs.getBytes("Avatar");
                avt = new Avatar(userId, imageData);
                return avt;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return avt;
    }
}
