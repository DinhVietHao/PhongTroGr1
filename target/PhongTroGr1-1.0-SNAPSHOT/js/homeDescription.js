document.addEventListener("DOMContentLoaded", function () {
    let carousel = document.querySelector("#carousel_Photos");
    let items = carousel.querySelectorAll(".carousel-item");
    let indicators = document.querySelectorAll(".carousel-indicators button");
    let prevButton = document.querySelector(".carousel-control-prev");
    let nextButton = document.querySelector(".carousel-control-next");

    let currentIndex = 0;

    function updateCarousel(index) {
        items.forEach((item, i) => {
            item.classList.toggle("active", i === index);
        });
        indicators.forEach((indicator, i) => {
            indicator.classList.toggle("active", i === index);
        });
    }

    prevButton.addEventListener("click", function () {
        currentIndex = (currentIndex - 1 + items.length) % items.length;
        updateCarousel(currentIndex);
    });

    nextButton.addEventListener("click", function () {
        currentIndex = (currentIndex + 1) % items.length;
        updateCarousel(currentIndex);
    });

    indicators.forEach((indicator, i) => {
        indicator.addEventListener("click", function () {
            currentIndex = i;
            updateCarousel(currentIndex);
        });
    });

    updateCarousel(currentIndex);
});
