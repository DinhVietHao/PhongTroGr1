document.addEventListener("DOMContentLoaded", function () {
    // Xử lý menu chính (.post-navbar)
    const navbarItems = document.querySelectorAll(".post-navbar .nav-link");

    function setNavbarActive(target) {
        navbarItems.forEach(link => link.classList.remove("click-effect"));
        target.classList.add("click-effect");
        localStorage.setItem("activeNavbarLink", target.getAttribute("href"));
    }

    navbarItems.forEach(link => {
        link.addEventListener("click", function () {
            setNavbarActive(this);
        });
    });

    const savedNavbarLink = localStorage.getItem("activeNavbarLink");
    if (savedNavbarLink) {
        const activeNavbarLink = document.querySelector(`.post-navbar .nav-link[href="${savedNavbarLink}"]`);
        if (activeNavbarLink) {
            setNavbarActive(activeNavbarLink);
        }
    }
});

// Xử lý sidebar (.sidebar-menu)
document.addEventListener("DOMContentLoaded", function () {
    const sidebarItems = document.querySelectorAll(".sidebar-menu .sidebar-item");

    function setSidebarActive(target) {
        sidebarItems.forEach(link => link.classList.remove("click-effect"));
        target.classList.add("click-effect");
        localStorage.setItem("activeSidebarLink", target.getAttribute("href"));
    }

    sidebarItems.forEach(link => {
        link.addEventListener("click", function () {
            setSidebarActive(this);
        });
    });

    const savedSidebarLink = localStorage.getItem("activeSidebarLink");
    if (savedSidebarLink) {
        const activeSidebarLink = document.querySelector(`.sidebar-menu .sidebar-item[href="${savedSidebarLink}"]`);
        if (activeSidebarLink) {
            setSidebarActive(activeSidebarLink);
        }
    }
});
