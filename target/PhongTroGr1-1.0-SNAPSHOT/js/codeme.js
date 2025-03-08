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

