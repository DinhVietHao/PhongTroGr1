
function openImage(img) {
    let popup = document.getElementById("imagePopup");
    let popupImg = document.getElementById("popupImg");
    popupImg.src = img.src;
    popup.classList.add("show");
}

function closeImage() {
    document.getElementById("imagePopup").classList.remove("show");
}