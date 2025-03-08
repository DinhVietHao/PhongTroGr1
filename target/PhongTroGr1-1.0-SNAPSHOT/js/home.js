document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".js-btn-save").forEach(button => {
        button.addEventListener("click", function () {
            let postId = this.closest(".card").getAttribute("data-id");

            fetch("SavePostServlet", {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: "postId=" + postId
            })
                    .then(response => response.text())
                    .then(data => {
                        if (data === "saved") {
                            this.classList.add("saved");
                        } else {
                            this.classList.remove("saved");
                        }
                    })
                    .catch(error => console.error("Lỗi khi gửi request:", error));
        });
    });
});
function openImage(img) {
    let popup = document.getElementById("imagePopup");
    let popupImg = document.getElementById("popupImg");
    popupImg.src = img.src;
    popup.classList.add("show");
}

function closeImage() {
    document.getElementById("imagePopup").classList.remove("show");
}