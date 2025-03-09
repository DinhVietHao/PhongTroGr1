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