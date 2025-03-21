
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
    checkboxes.forEach(function(cb) {
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