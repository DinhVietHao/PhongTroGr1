/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;
import database.DBContext;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class UserDAO extends DBContext {

    public User verifyMD5(String user, String pass) {
        User acc = new User();
        //acc.getId() = -1;
        String sql = "SELECT * FROM Users WHERE Username = ? AND Password=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, hashMD5(pass));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                acc.setUserId(rs.getInt("User_id"));
                acc.setFullname(rs.getString("Fullname"));
                acc.setUsername(rs.getString("Username"));
                acc.setPassword(rs.getString("Password"));
                acc.setEmail(rs.getString("Email"));
                acc.setPhone(rs.getString("Phone"));
                acc.setRole(rs.getInt("Role"));
                acc.setAuthCode(rs.getString("AuthenticationCode"));
                acc.setExpirationTime(rs.getTimestamp("ExpirationTime"));
                acc.setVerifStatus(rs.getBoolean("VerificationStatus"));
                acc.setRegisStatus(rs.getBoolean("RegisterStatus"));
                acc.setImageData(rs.getBytes("Avatar"));
                return acc;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return acc;
    }

    public String hashMD5(String pass) {
        try {
            MessageDigest mes = MessageDigest.getInstance("MD5");
            byte[] mesMD5 = mes.digest(pass.getBytes());
            //[0x0a, 0x7a, 0x12, 0x09,...]
            StringBuilder str = new StringBuilder();
            for (byte b : mesMD5) {
                //0x0a
                String ch = String.format("%02x", b);
                //0a
                str.append(ch);
            }
            //str = 0a7a1209
            return str.toString();
        } catch (NoSuchAlgorithmException e) {
            System.out.println(e.getMessage());
        }
        return "";
    }

    public boolean insertUser(User t) {
        String sqlInsertUser = "INSERT INTO Users (Fullname, Username, Password, Email, Phone, Role) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sqlInsertUser);
            ps.setString(1, t.getFullname());
            ps.setString(2, t.getUsername());
            ps.setString(3, hashMD5(t.getPassword()));
            ps.setString(4, t.getEmail());
            ps.setString(5, t.getPhone());
            ps.setInt(6, t.getRole());
            int res = ps.executeUpdate();
            return res == 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean checkPass(int userId, String password) {
        String sql = "SELECT * FROM Users WHERE User_id = ? AND Password = ?";
        int isOk = 0;
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setInt(1, userId);
            pt.setString(2, hashMD5(password));
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                isOk = 1;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return isOk > 0;
    }

    public boolean updatePass(int id, String password) {
        String sql = "UPDATE Users SET Password = ? WHERE User_id = ?";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setString(1, hashMD5(password));
            pt.setInt(2, id);
            if (pt.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public int getUserIdByPostId(int postId) {
        String sql = "SELECT User_id FROM Posts WHERE Post_id = ?";
        int userId = -1;
        try ( PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("User_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userId;
    }

    public User selectUserById(int id) {
        User user = new User();
        String sql = "SELECT * FROM Users WHERE User_id = ?";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setInt(1, id);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                user = new User(rs.getInt("User_id"),
                        rs.getString("Fullname"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getInt("Role"),
                        rs.getString("AuthenticationCode"),
                        rs.getTimestamp("ExpirationTime"),
                        rs.getBoolean("VerificationStatus"));
                user.setImageData(rs.getBytes("Avatar"));
                user.setRegisStatus(rs.getBoolean("RegisterStatus"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return user;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT User_id, Fullname, RegisterStatus FROM Users WHERE Email = ?";
        User user = new User();
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setString(1, email);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                user.setUserId(rs.getInt("User_id"));
                user.setFullname(rs.getString("Fullname"));
                user.setRegisStatus(rs.getBoolean("RegisterStatus"));
                user.setEmail(email);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return user;
    }

    public int updateVerifyInformation(User t) {
        int result = 0;
        String sql = "UPDATE Users SET AuthenticationCode = ?, ExpirationTime = ?, VerificationStatus = ?, RegisterStatus = ? WHERE User_id = ?";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setString(1, t.getAuthCode());
            pt.setTimestamp(2, t.getExpirationTime());
            pt.setBoolean(3, t.getVerifStatus());
            pt.setBoolean(4, t.isRegisStatus());
            pt.setInt(5, t.getUserId());
            result = pt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setString(1, email);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean updateMailById(int id, String email) {
        String sql = "UPDATE Users SET Email = ? WHERE User_id = ?";
        int res = 0;
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setString(1, email);
            pt.setInt(2, id);
            res = pt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return res > 0;
    }

    public boolean updateUserInfo(int userId, String fullname, String phone) {
        String sql = "UPDATE Users SET Fullname = ?, Phone = ? WHERE User_id = ?";

        try ( PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, fullname);
            stmt.setString(2, phone);
            stmt.setInt(3, userId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public List<User> getAllUserViewer() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE Role = 1";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("User_id"));
                user.setFullname(rs.getString("Fullname"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setRole(rs.getInt("Role"));
                user.setExpirationTime(rs.getTimestamp("ExpirationTime"));
                user.setImageData(rs.getBytes("Avatar"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<User> getAllUserOwner() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE Role = 2";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("User_id"));
                user.setFullname(rs.getString("Fullname"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setRole(rs.getInt("Role"));
                user.setExpirationTime(rs.getTimestamp("ExpirationTime"));
                user.setImageData(rs.getBytes("Avatar"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteUnverifiedAccounts() {
        String sql = "DELETE Users WHERE VerificationStatus = 0 AND RegisterStatus = 0";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public boolean deleteUser(int userId) {
        String deleteImagesSQL = "DELETE FROM Images WHERE Post_id IN (SELECT Post_id FROM Posts WHERE User_id = ?)";
        String deleteReviewsSQL = "DELETE FROM Reviews WHERE User_id = ?";
        String deletePostsSQL = "DELETE FROM Posts WHERE User_id = ?";
        String deleteUserSQL = "DELETE FROM Users WHERE User_id = ?";

        try (PreparedStatement stmtDeleteImages = conn.prepareStatement(deleteImagesSQL);
             PreparedStatement stmtDeleteReviews = conn.prepareStatement(deleteReviewsSQL);  
             PreparedStatement stmtDeletePosts = conn.prepareStatement(deletePostsSQL);  
             PreparedStatement stmtDeleteUser = conn.prepareStatement(deleteUserSQL)) {
            
            stmtDeleteImages.setInt(1, userId);
            stmtDeleteImages.executeUpdate();
            stmtDeleteReviews.setInt(1, userId);
            stmtDeleteReviews.executeUpdate();
            stmtDeletePosts.setInt(1, userId);
            stmtDeletePosts.executeUpdate();
            stmtDeleteUser.setInt(1, userId);
            int rowsAffected = stmtDeleteUser.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public static void main(String[] args) {
        UserDAO userDao = new UserDAO();
        User user = new User();
        user.setFullname("Đinh Việt Hào");
        user.setUsername("Admin");
        user.setPassword("Admin123@");
        user.setEmail("haodvce180526@fpt.edu.vn");
        user.setPhone("0878833277");
        user.setRole(3);
        userDao.insertUser(user);
    }
}
