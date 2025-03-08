/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import until.DBContext;

/**
 *
 * @author ADMIN
 */
public class SearchDAO extends DBContext {

    public SearchDAO() {
        super();
    }

    public List<Post> filterByPrice() {
        List<Post> List = new ArrayList();
        String sql = "SELECT *FROM Posts WHERE Price BETWEEN 1000000 AND 5000000 ORDER BY Price ASC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int post_id = rs.getInt("Post_id");
                int user_id = rs.getInt("User_id");
                int catgory_id = rs.getInt("Category_id");
                String title = rs.getString("Title");
                String description = rs.getString("Description");
                Double price = rs.getDouble("Price");
                String address = rs.getString("Address");
                String city = rs.getString("City");
                String district = rs.getString("District");
                String ward = rs.getString("Ward");
                String are = rs.getString("Are");
                int room_count = rs.getInt("Room_Count");
                String post_type = rs.getString("Post_type");
                String status = rs.getString("Status");
                Date created_at = rs.getDate("Created_at");
                Date updated_at = rs.getDate("Updated_at");
                
                List.add(new Post(post_id, user_id, post_id, title, description, 0, address, city, district, ward, 0, room_count, post_type, status, created_at, updated_at));
            }
            return List;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return List;

    }
}
