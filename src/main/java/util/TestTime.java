/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.text.SimpleDateFormat;
import java.util.*;

public class TestTime {
    public static void main(String[] args) {
        // Lấy thời gian hiện tại
        Date todaysDate = new Date(new java.util.Date().getTime());
        
        // Cài đặt múi giờ cho Calendar
        TimeZone tz = TimeZone.getTimeZone("Asia/Ho_Chi_Minh");
        Calendar c = Calendar.getInstance(tz);
        
        // Thiết lập thời gian cho Calendar
        c.setTime(todaysDate);
        
        // Thêm 300 giây (5 phút)
        c.add(Calendar.SECOND, 300);
        
        // Lấy thời gian expirationTime
        Date expirationTime = new Date(c.getTimeInMillis());
        
        // In kết quả
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
        System.out.println("Today's Date: " + sdf.format(todaysDate));
        System.out.println("Expiration Time: " + sdf.format(expirationTime));
    }
}
