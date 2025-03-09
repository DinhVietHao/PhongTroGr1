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

// Hiển thị nút tìm kiếm khi có ít nhất một checkbox được chọn
function updateSearchButton() {
    var checkboxes = document.querySelectorAll(".region-checkbox");
    var searchButton = document.getElementById("searchButton");
    var footer = document.querySelector(".modal-footer");

    let isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);

    if (isChecked) {
        searchButton.style.display = "block";
        footer.style.display = "block";
    } else {
        searchButton.style.display = "none";
        footer.style.display = "none";
    }
}
