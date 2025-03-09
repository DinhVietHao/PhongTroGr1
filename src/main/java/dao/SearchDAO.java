/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;
import model.Post;

/**
 *
 * @author ADMIN
 */
public class SearchDAO extends DBContext {

    public SearchDAO() {
        super();
    }

    public List<Post> selectivePost(String description, String city, String district, String ward, double price) {
        List<Post> postList = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE Description = ? AND City = ? AND District = ? AND Ward = ? AND Price = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, description);
            st.setString(2, city);
            st.setString(3, district);
            st.setString(4, ward);
            st.setDouble(5, price);
            ResultSet rs = st.executeQuery();

            // Đọc dữ liệu từ ResultSet
            while (rs.next()) {
                Post post = new Post();
                post.setPostId(rs.getInt("id"));
                post.setDescription(rs.getString("Description"));
                post.setCity(rs.getString("City"));
                post.setDistrict(rs.getString("District"));
                post.setWard(rs.getString("Ward"));
                post.setPrice(rs.getDouble("Price"));

                postList.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi
        }
        return postList;
    }

}
