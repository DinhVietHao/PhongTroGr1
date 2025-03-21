document.addEventListener("DOMContentLoaded", function () {

    let savedId = localStorage.getItem("activeClick");

    if (savedId) {
        let savedElement = document.getElementById(savedId);
        if (savedElement) {
            savedElement.classList.add("click-effect");
        }
    }
    document.querySelectorAll(".add-click").forEach(item => {
        item.addEventListener("click", function (event) {
            let allClick = document.querySelectorAll(".add-click");
            allClick.forEach(function (el) {
                el.classList.remove("click-effect");
            });
            this.classList.add("click-effect");
            localStorage.setItem("activeClick", this.id);
        });
    });
    document.querySelectorAll(".add-nav").forEach(item => {
        item.addEventListener("click", function (event) {
            let allClick = document.querySelectorAll(".add-nav");
            allClick.forEach(function (el) {
                el.classList.remove("click-effect");
            });
            this.classList.add("click-effect");
            localStorage.setItem("activeClick", this.id);
        });
    });
});