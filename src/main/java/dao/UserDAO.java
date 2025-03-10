/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import model.User;
import database.DBContext;
import java.security.NoSuchAlgorithmException;

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
                acc.setCreated_at(rs.getDate("Created_at"));
                acc.setUpdated_at(rs.getDate("Updated_at"));
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
        String sqlInsertUser = "INSERT INTO Users (Fullname, Username, Password, Email, Phone, Role, Created_at, Updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sqlInsertUser);
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());

            ps.setString(1, t.getFullname());
            ps.setString(2, t.getUsername());
            ps.setString(3, hashMD5(t.getPassword()));
            ps.setString(4, t.getEmail());
            ps.setString(5, t.getPhone());
            ps.setInt(6, t.getRole());
            ps.setTimestamp(7, currentTime);
            ps.setTimestamp(8, currentTime);
            int res = ps.executeUpdate();
            return res == 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
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
                        rs.getDate("Created_at"),
                        rs.getDate("Updated_at"),
                        rs.getString("AuthenticationCode"),
                        rs.getDate("ExpirationTime"),
                        rs.getBoolean("VerificationStatus"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return user;
    }

    public int updateVerifyInformation(User t) {
        int result = 0;
        String sql = "UPDATE Users SET AuthenticationCode = ?, ExpirationTime = ?, VerificationStatus = ? WHERE User_id = ?";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setString(1, t.getAuthCode());
            pt.setDate(2, t.getExpirationTime());
            pt.setBoolean(3, t.getVerifStatus());
            pt.setInt(4, t.getUserId());
            result = pt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }
}
