document.getElementById("danh-sach-bai-chua-duyet").onclick = function () {
    document.getElementById("danh-sach-bai-chua-duyet-table").style.display = "block";
    document.getElementById("quan-ly-tai-khoan-table").style.display = "none";
};
document.getElementById("quan-ly-tai-khoan").onclick = function () {
    document.getElementById("danh-sach-bai-chua-duyet-table").style.display = "none";
    document.getElementById("quan-ly-tai-khoan-table").style.display = "block";
};