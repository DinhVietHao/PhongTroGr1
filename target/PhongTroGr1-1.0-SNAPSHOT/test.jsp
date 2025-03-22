<%-- 
    Document   : test
    Created on : Mar 22, 2025, 2:44:26 PM
    Author     : DVHao
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <style>
            .star-rating {
                font-size: 24px;
                cursor: pointer;
            }

            .star-rating span {
                color: #ccc;
                /* Màu mặc định của ngôi sao */
                transition: color 0.2s;
            }

            .star-rating span.hover {
                color: #ffcc00;
                /* Màu khi di chuột qua */
            }

            .star-rating span.selected {
                color: #ffcc00;
                /* Màu khi được chọn */
            }
        </style>
    </head>

    <body>
        <!-- Hiển thị ngôi sao -->
        <div class="star-rating">
            <span data-value="1">&#9733;</span>
            <span data-value="2">&#9733;</span>
            <span data-value="3">&#9733;</span>
            <span data-value="4">&#9733;</span>
            <span data-value="5">&#9733;</span>
        </div>

        <!-- Phần tử ẩn để lưu giá trị đánh giá -->
        <input type="hidden" id="ratingValue" name="ratingValue" value="0">

        <!-- Hiển thị giá trị đánh giá -->
        <p>Đánh giá: <span id="displayRating">0</span>/5</p>
    </body>
    <script>
        const stars = document.querySelectorAll('.star-rating span');
        const ratingValue = document.getElementById('ratingValue');
        const displayRating = document.getElementById('displayRating');

        // Hàm cập nhật giá trị đánh giá
        function updateRating(value) {
            ratingValue.value = value; // Cập nhật giá trị ẩn
            displayRating.textContent = value; // Hiển thị giá trị đánh giá

            // Cập nhật màu sắc của các ngôi sao
            stars.forEach((star, index) => {
                if (index < value) {
                    star.classList.add('selected');
                } else {
                    star.classList.remove('selected');
                }
            });
        }

        // Xử lý sự kiện khi di chuột qua ngôi sao
        stars.forEach((star) => {
            star.addEventListener('mouseover', () => {
                const value = parseFloat(star.getAttribute('data-value'));
                stars.forEach((s, index) => {
                    if (index < value) {
                        s.classList.add('hover');
                    } else {
                        s.classList.remove('hover');
                    }
                });
            });

            star.addEventListener('mouseout', () => {
                stars.forEach((s) => s.classList.remove('hover'));
            });

            star.addEventListener('click', () => {
                const value = parseFloat(star.getAttribute('data-value'));
                updateRating(value);
            });
        });

        function submitRating() {
            const rating = parseFloat(ratingValue.value);

            if (rating === 0) {
                alert("Vui lòng chọn số sao để đánh giá!");
                return;
            }

            // Gửi dữ liệu bằng AJAX
            $.ajax({
                url: "/PhongTroGr1/RatingServlet", // URL của Servlet
                type: "POST",
                data: {
                    rating: rating,
                    postId: 123 // ID của bài đăng được đánh giá
                },
                success: function (response) {
                    alert("Đánh giá thành công!");
                    console.log("Phản hồi từ server:", response);
                },
                error: function (xhr, status, error) {
                    console.error("Lỗi khi gửi đánh giá:", error);
                    alert("Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại!");
                }
            });
        }

        function displayAverageRating(averageRating) {
            stars.forEach((star, index) => {
                if (index < averageRating) {
                    star.classList.add('selected');
                } else {
                    star.classList.remove('selected');
                }
            });
            displayRating.textContent = averageRating.toFixed(1); // Hiển thị giá trị trung bình
        }

        // Giả sử giá trị đánh giá trung bình là 3.7
        displayAverageRating(3.7);
    </script>
</html>
