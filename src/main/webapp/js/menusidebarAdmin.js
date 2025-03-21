
//     JavaScript để thay đổi nội dung khi click vào các mục menu
document.getElementById("quanli-baidang").onclick = function () {
    document.getElementById("quanli-baidang-table").style.display = "block";
    document.getElementById("danh-sach-bai-chua-duyet-table").style.display = "none";
    document.getElementById("quan-ly-tai-khoan-table").style.display = "none";
};

document.getElementById("danh-sach-bai-chua-duyet").onclick = function () {
    document.getElementById("quanli-baidang-table").style.display = "none";
    document.getElementById("danh-sach-bai-chua-duyet-table").style.display = "block";
    document.getElementById("quan-ly-tai-khoan-table").style.display = "none";
};

document.getElementById("quan-ly-tai-khoan").onclick = function () {
    document.getElementById("quanli-baidang-table").style.display = "none";
    document.getElementById("danh-sach-bai-chua-duyet-table").style.display = "none";
    document.getElementById("quan-ly-tai-khoan-table").style.display = "block";
};