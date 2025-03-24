/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author DVHao
 */
public class User {

    private int userId;
    private String fullname;
    private String username;
    private String password;
    private String email;
    private String phone;
    private int role;
    private String authCode;
    private Timestamp expirationTime;
    private boolean verifStatus;
    private boolean regisStatus;
    private byte[] imageData;

    public User() {
        this.userId = -1;
        this.regisStatus = false;
        this.fullname = "";
        this.phone = "";
    }

    public User(String fullname, String email, String phone) {
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
    }

    public User(String fullname, String username, String password, String email, String phone, int role) {
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
    }

    public User(String fullname, String email, String phone, byte[] imageData) {
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.imageData = imageData;
    }
    

    public User(int userId, String fullname, String username, String password, String email, String phone, int role) {
        this.userId = userId;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
    }

    public User(int userId, String fullname, String username, String password, String email, String phone, int role, String authCode, Timestamp expirationTime, boolean verifStatus, byte[] imageData) {
        this.userId = userId;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.authCode = authCode;
        this.expirationTime = expirationTime;
        this.verifStatus = verifStatus;
        this.imageData = imageData;
    }
    
    public User(int userId, String fullname, String username, String password, String email, String phone, int role, String authCode, Timestamp expirationTime, boolean verifStatus) {
        this.userId = userId;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.authCode = authCode;
        this.expirationTime = expirationTime;
        this.verifStatus = verifStatus;
    }

    public User(int userId, String fullname, String phone, byte[] imageData) {
        this.userId = userId;
        this.fullname = fullname;
        this.phone = phone;
        this.imageData = imageData;
    }

    
    
    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }
    
    

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getAuthCode() {
        return authCode;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    public Timestamp getExpirationTime() {
        return expirationTime;
    }

    public void setExpirationTime(Timestamp expirationTime) {
        this.expirationTime = expirationTime;
    }

    public boolean getVerifStatus() {
        return verifStatus;
    }

    public void setVerifStatus(boolean verifStatus) {
        this.verifStatus = verifStatus;
    }

    public boolean isRegisStatus() {
        return regisStatus;
    }

    public void setRegisStatus(boolean regisStatus) {
        this.regisStatus = regisStatus;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", fullname=" + fullname + ", username=" + username + ", password=" + password + ", email=" + email + ", phone=" + phone + ", role=" + role + ", authCode=" + authCode + ", expirationTime=" + expirationTime + ", verifStatus=" + verifStatus + '}';
    }

}
