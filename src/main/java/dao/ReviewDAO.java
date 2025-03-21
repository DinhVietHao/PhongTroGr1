/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.DBContext;
import java.util.List;
import model.Review;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author DVHao
 */
public class ReviewDAO extends DBContext{
    public ReviewDAO() {
        super();
    }
    
    public boolean insertReview(Review r) {
        String sql = "INSERT INTO Reviews(User_id, Post_id, Rating, Comment) VALUES(?, ?, ?, ?)";
        int num = 0;
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setInt(1, r.getUserId());
            pt.setInt(2, r.getPostId());
            pt.setInt(3, r.getRating());
            pt.setString(4, r.getComment());
            num = pt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return num > 0;
    }
    
    public List<Review> selectAllReviewsByPostId(int postId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM Reviews WHERE Post_id = ? ORDER BY Created_at DESC";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setInt(1, postId);
            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                Review r = new Review();
                r.setUserId(rs.getInt("User_id"));
                r.setPostId(rs.getInt("Post_id"));
                r.setRating(rs.getInt("Rating"));
                r.setComment(rs.getString("Comment"));
                r.setCreated_at(rs.getTimestamp("Created_at"));
                list.add(r);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public boolean checkCommentExists(int userId, int postId, String comment) {
        String query = "SELECT COUNT(*) FROM Reviews WHERE User_id = ? AND Post_id = ? AND Comment = ?";
        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, postId);
            preparedStatement.setString(3, comment);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}
