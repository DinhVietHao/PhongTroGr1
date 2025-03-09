/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author ASUS
 */
public class MyLib {

    public static boolean checkPasswordStrong(String password) {
        // Regex kiểm tra mật khẩu mạnh, KHÔNG chứa khoảng trắng
        String regex = "^(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=!])[A-Za-z\\d@#$%^&+=!]{8,}$";

        // Kiểm tra mật khẩu bằng regex
        return password.matches(regex);
    }

    public static boolean isValidPhone(String phone) {
        return phone.matches("^(086|096|097|098|032|033|034|035|036|037|038|039|"
                + "088|091|094|083|084|085|081|082|"
                + "089|090|093|070|079|077|076|078|"
                + "092|056|058|055|099|059|087)\\d{7}$");
    }

}
