/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.Image;
import java.sql.*;
import model.Post;
import model.User;

/**
 *
 * @author DVHao
 */
public class PostDao extends DBContext {

    public PostDao() {
        super();
    }

    public List<Image> selectImageByPostId(int id) {
        List<Image> data = new ArrayList<>();
        String sql = "SELECT * FROM Images WHERE Post_id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Image img = new Image(rs.getInt("Image_id"),
                        rs.getInt("Post_id"),
                        rs.getBytes("Image_url"));
                data.add(img);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return data;
    }

    public User selectLandlordById(int id) {
        User landlord = null;
        String sql = "SELECT Fullname, Email, Phone FROM Users WHERE User_id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                landlord = new User(rs.getString("Fullname"), rs.getString("Email"), rs.getString("Phone"));
                return landlord;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return landlord;
    }

    public List<Post> selectPostAll() {
        List<Post> data = new ArrayList<>();
        String sql = "SELECT * FROM Posts";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post post = new Post(rs.getInt("Post_id"),
                        rs.getInt("User_id"),
                        rs.getInt("Category_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("District"),
                        rs.getString("Ward"),
                        rs.getDouble("Area"),
                        rs.getInt("Room_count"),
                        rs.getString("Post_type"),
                        rs.getString("Status"),
                        rs.getDate("Created_at"),
                        rs.getDate("Updated_at"),
                        selectLandlordById(rs.getInt("User_id")),
                        selectImageByPostId(rs.getInt("Post_id")));
                data.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return data;
    }

    public static void main(String[] args) {
        PostDao pd = new PostDao();
        List<Post> data = pd.selectPostAll();
        for (Post p : data) {
            System.out.println(p);
        }
    }
}
