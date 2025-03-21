
document.addEventListener("DOMContentLoaded", function () {
    const menuItems = document.querySelectorAll(".sidebar-item");
    const posts = document.querySelectorAll(".post");

    menuItems.forEach((item, index) => {
        item.addEventListener("click", function () {
            posts.forEach(post => {
                post.style.display = "none";
                post.style.opacity = "0";
                post.style.transform = "translateY(-20px)";
            });

            const targetId = item.id + "-table";
            const targetPost = document.getElementById(targetId);

            if (targetPost) {
                targetPost.style.display = "block";
                setTimeout(() => {
                    targetPost.style.opacity = "1";
                    targetPost.style.transform = "translateY(0)";
                }, index * 150); // Hiệu ứng domino, tăng dần theo index
            }
        });
    });

    // Xử lý hiển thị modal mô tả sản phẩm
    const modalOverlay = document.getElementById("modalOverlay");
    const closeModal = document.getElementById("closeModal");
    const modalBody = document.getElementById("modalBody");
    const descriptions = document.querySelectorAll(".description");

    descriptions.forEach(desc => {
        desc.addEventListener("click", function () {
            modalBody.textContent = this.getAttribute("data-description");
            modalOverlay.style.display = "flex";
            document.body.style.overflow = "hidden";
        });
    });

    closeModal.addEventListener("click", function () {
        modalOverlay.style.display = "none";
        document.body.style.overflow = "auto";
    });

    modalOverlay.addEventListener("click", function (event) {
        if (event.target === modalOverlay) {
            modalOverlay.style.display = "none";
            document.body.style.overflow = "auto";
        }
    });

    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape" && modalOverlay.style.display === "flex") {
            modalOverlay.style.display = "none";
            document.body.style.overflow = "auto";
        }
    });
});

//cho hien tung dong domino
document.addEventListener("DOMContentLoaded", function () {
    const menuItems = document.querySelectorAll(".sidebar-item");
    const posts = document.querySelectorAll(".post");

    menuItems.forEach(item => {
        item.addEventListener("click", function () {
            posts.forEach(post => {
                post.classList.remove("show");
                post.querySelectorAll("tbody tr").forEach(row => {
                    row.style.opacity = "0";
                    row.style.transform = "scale(0.9)";
                });
            });

            const targetId = item.id + "-table";
            const targetPost = document.getElementById(targetId);

            if (targetPost) {
                targetPost.classList.add("show");

                setTimeout(() => {
                    const rows = targetPost.querySelectorAll("tbody tr");
                    rows.forEach((row, index) => {
                        setTimeout(() => {
                            row.style.opacity = "1";
                            row.style.transform = "scale(1)";
                        }, index * 100); // Tạo hiệu ứng lượn sóng với delay giữa từng dòng
                    });
                }, 100);
            }
        });
    });
});
