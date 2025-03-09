/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import database.DBContext;


import java.sql.Date;
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


    public List<Post> filterPosts(Double minPrice, Double maxPrice, String city, String district,
            String ward, String postType) {
        List<Post> List = new ArrayList<>();

        String sql = "SELECT * FROM Posts WHERE 1=1";
        if (minPrice != null && maxPrice != null) {
            sql += " AND Price BETWEEN ? AND ?";
        }
        if (city != null && !city.isEmpty()) {
            sql += " AND City = ?";
        }
        if (district != null && !district.isEmpty()) {
            sql += " AND District = ?";
        }
        if (ward != null && !ward.isEmpty()) {
            sql += " AND Ward = ?";
        }
        if (postType != null && !postType.isEmpty()) {
            sql += " AND Post_type = ?";
        }

        sql += " ORDER BY Price ASC";
        try {

            PreparedStatement ps = conn.prepareStatement(sql);
            int index = 1;
            if (minPrice != null && maxPrice != null) {
                ps.setDouble(index++, minPrice);
                ps.setDouble(index++, maxPrice);
            }
            if (city != null && !city.isEmpty()) {
                ps.setString(index++, city);
            }
            if (district != null && !district.isEmpty()) {
                ps.setString(index++, district);
            }
            if (ward != null && !ward.isEmpty()) {
                ps.setString(index++, ward);
            }
            if (postType != null && !postType.isEmpty()) {
                ps.setString(index++, postType);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int post_id = rs.getInt("Post_id");
                int user_id = rs.getInt("User_id");
                int category_id = rs.getInt("Category_id");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                Double price = rs.getDouble("Price");
                String address = rs.getString("Address");
                String cityResult = rs.getString("City");
                String districtResult = rs.getString("District");
                String wardResult = rs.getString("Ward");
                Double area = rs.getDouble("Are");
                int room_count = rs.getInt("Room_Count");
                String post_type = rs.getString("Post_type");
                String status = rs.getString("Status");
                Date created_at = rs.getDate("Created_at");
                Date updated_at = rs.getDate("Updated_at");

                List.add(new Post(post_id, user_id, category_id, title, description, price, address,
                        cityResult, districtResult, wardResult, area, room_count,
                        post_type, status, created_at, updated_at));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return List;
    }
}
