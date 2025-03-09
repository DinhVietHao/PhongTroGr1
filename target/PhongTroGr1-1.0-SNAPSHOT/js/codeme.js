document.addEventListener("DOMContentLoaded", () => {
    const dropdownBtn = document.querySelector(".dropdown-btn");
    const dropdownMenu = document.querySelector(".dropdown-menu");

    dropdownBtn.addEventListener("click", () => {
        dropdownMenu.style.display =
                dropdownMenu.style.display === "block" ? "none" : "block";
    });

    // Đóng menu khi nhấp ra ngoài
    document.addEventListener("click", (event) => {
        if (!dropdownBtn.contains(event.target) && !dropdownMenu.contains(event.target)) {
            dropdownMenu.style.display = "none";
        }
    });
});

document.addEventListener("DOMContentLoaded", () => {
    const filterBtn = document.querySelector(".btn-filter");
    const filterModal = document.getElementById("filterModal");
    const closeModalBtn = filterModal.querySelector(".btn-close");

    // Toggle the visibility of the filter modal when the button is clicked
    filterBtn.addEventListener("click", (event) => {
        // Prevent the event from propagating so it doesn't trigger closing when clicking the button itself
        event.stopPropagation();

        // Toggle the modal's visibility
        filterModal.classList.toggle("show");
    });

    // Close the modal when clicking the close button
    closeModalBtn.addEventListener("click", (event) => {
        event.stopPropagation();
        filterModal.classList.remove("show");
    });

    // Close the modal if clicked outside of the modal
    document.addEventListener("click", (event) => {
        if (!filterBtn.contains(event.target) && !filterModal.contains(event.target)) {
            filterModal.classList.remove("show");
        }
    });
});









//Seach Table (Khang)

function toggleRegionModal() {
    var modal = document.getElementById("regionModal");
    var overlay = document.getElementById("overlay");

    if (modal.classList.contains("active")) {
        modal.classList.remove("active");
        overlay.style.display = "none";
    } else {
        modal.classList.add("active");
        overlay.style.display = "block";
    }
}

// Hiển thị nút tìm kiếm với hiệu ứng từ từ khi có checkbox được chọn
function updateSearchButton() {
    var checkboxes = document.querySelectorAll(".region-checkbox");
    var footer = document.querySelector(".modal-footer");

    let isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);

    if (isChecked) {
        footer.style.display = "block"; // Hiện nút tìm kiếm ngay lập tức nhưng vẫn ẩn (opacity = 0)
        setTimeout(() => footer.classList.add("show"), 10); // Kích hoạt hiệu ứng xuất hiện từ từ
    } else {
        footer.classList.remove("show"); // Ẩn dần nút tìm kiếm
        setTimeout(() => {
            if (!Array.from(checkboxes).some(checkbox => checkbox.checked)) {
                footer.style.display = "none"; // Ẩn hoàn toàn sau khi hiệu ứng kết thúc
            }
        }, 500);
    }
}


