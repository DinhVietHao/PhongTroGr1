/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;
import database.DBContext;

/**
 *
 * @author ASUS
 */
public class UserDAO extends DBContext{
    public User verifyMD5(String user, String pass){
        User acc = new User();
        //acc.getId() = -1;
        String sql = "SELECT * FROM Users WHERE Username = ? AND Password=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, hashMD5(pass));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
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
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return acc;
    }
    
    public String hashMD5(String pass){
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
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "";
    }
}
