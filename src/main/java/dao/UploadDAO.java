/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.DBContext;
import jakarta.servlet.http.Part;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Image;

/**
 *
 * @author ASUS
 */
public class UploadDAO extends DBContext {

     public boolean uploadImage(int postId, InputStream imageStream) {
        String sql = "INSERT INTO Images (Post_id, photo) VALUES (?, ?)";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, postId);
            if (imageStream != null) {
                ps.setBinaryStream(2, imageStream);
            } else {
                ps.setNull(2, java.sql.Types.BLOB);
            }
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
