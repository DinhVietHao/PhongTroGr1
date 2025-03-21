/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// validation.js

// Function to validate the form data before submission
function validateForm() {
    var fullname = document.getElementById("inputFullName").value;              // Get full name
    var username = document.getElementById("inputUsername").value;          // Get username
    var phone = document.getElementById("inputPhone").value;                     // Get phone number
    var email = document.getElementById("inputEmail").value;                        // Get email
    var new_password = document.getElementById("new_password").value;  // Get password
    var password = document.getElementById("password").value;                  // Get password
    var rePassword = document.getElementById("re-password").value;          // Get password confirmation
    var errorMessage = "";                                                                               // Initialize error message

    // Check if the full name and username are long enough
    if (fullname.length < 3) {
        errorMessage += "Họ tên phải có ít nhất 3 ký tự!\n";
    }
    if (username.length < 3) {
        errorMessage += "Tên đăng nhập phải có ít nhất 3 ký tự!\n";
    }

    // Check if password and confirmation password match
    if (password !== rePassword) {
        errorMessage += "Mật khẩu và xác nhận mật khẩu không khớp!\n";
    }

    // Check if password is strong (must contain letters, numbers, and special characters)
    var passwordRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!])[A-Za-z\d@#$%^&+=!]{6,}$/;
    if (!password.match(passwordRegex)) {
        errorMessage += "Mật khẩu phải có chữ cái, số và kí tự đặt biệt!\n";
    }

    // Check if new password is strong (must contain letters, numbers, and special characters)
    var passwordRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!])[A-Za-z\d@#$%^&+=!]{6,}$/;
    if (!new_password.match(passwordRegex)) {
        errorMessage += "Mật khẩu phải có chữ cái, số và kí tự đặt biệt!\n";
    }

    // Check if the phone number is valid
    var phoneRegex = /^(086|096|097|098|032|033|034|035|036|037|038|039|088|091|094|083|084|085|081|082|089|090|093|070|079|077|076|078|092|056|058|055|099|059|087)\d{7}$/;
    if (!phone.match(phoneRegex)) {
        errorMessage += "Vui lòng nhập số điện thoại của Việt Nam!\n";
    }

    // Check if the email is valid
    var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    if (!email.match(emailRegex)) {
        errorMessage += "Email không hợp lệ!\n";
    }

    // If there are any errors, display them and prevent form submission
    if (errorMessage !== "") {
        alert(errorMessage);
        return false;
    }

    // If no errors, allow form submission
    return true;
}

