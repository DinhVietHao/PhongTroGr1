
// Toggle the region modal visibility
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

// Handle checkbox change to ensure only one is selected at a time
function handleCheckboxChange(checkbox) {
    // Uncheck all other checkboxes
    var checkboxes = document.querySelectorAll(".region-checkbox");
    checkboxes.forEach(function (cb) {
        if (cb !== checkbox) {
            cb.checked = false;
        }
    });

    // Update search button visibility
    updateSearchButton();
}

// Show/hide search button based on checkbox selection
function updateSearchButton() {
    var checkboxes = document.querySelectorAll(".region-checkbox");
    var searchButton = document.getElementById("searchButton");

    // Check if any checkbox is selected
    let isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);

    if (isChecked) {
        searchButton.style.display = "block"; // Show search button
        setTimeout(() => searchButton.classList.add("show"), 10); // Trigger fade-in animation
    } else {
        searchButton.classList.remove("show"); // Start fade-out animation
        setTimeout(() => {
            if (!Array.from(checkboxes).some(checkbox => checkbox.checked)) {
                searchButton.style.display = "none"; // Hide completely after animation
            }
        }, 300);
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const filterButton = document.querySelector(".btn-filter");
    const filterContainer = document.querySelector(".filter");
    const closeButton = document.querySelector(".close-filter");
    const overlay = document.querySelector(".overlay");
    filterButton.addEventListener("click", function (event) {
        event.stopPropagation();
        filterContainer.classList.add("show");
        overlay.classList.add("show");
    });
    closeButton.addEventListener("click", function (event) {
        event.stopPropagation();
        filterContainer.classList.remove("show");
        overlay.classList.remove("show");
    });
    overlay.addEventListener("click", function () {
        filterContainer.classList.remove("show");
        overlay.classList.remove("show");
    });
    filterContainer.addEventListener("click", function (event) {
        event.stopPropagation();
    });
});

document.addEventListener("DOMContentLoaded", function () {

    document.querySelectorAll(".filter-options input[type='radio']").forEach(input => {
        input.addEventListener("change", function () {

            this.closest(".filter-options").querySelectorAll("label").forEach(label => {
                label.classList.remove("selected");
            });

            this.closest("label").classList.add("selected");
        });
    });

    document.querySelectorAll(".filter-options select").forEach(select => {
        select.addEventListener("change", function () {
            this.classList.add("selected");
        });
    });
});