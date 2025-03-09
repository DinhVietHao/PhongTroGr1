const districtsData = {
    1: {// Hồ Chí Minh
        "Quận 1": {
            wards: ["Phường Bến Nghé", "Phường Bến Thành", "Phường Nguyễn Thái Bình"],
            streets: ["Đường Nguyễn Huệ", "Đường Lê Lợi", "Đường Đồng Khởi"]
        },
        "Quận 2": {
            wards: ["Phường An Phú", "Phường Thảo Điền"],
            streets: ["Đường Nguyễn Thị Định", "Đường Xa Lộ Hà Nội"]
        },
        "Quận 3": {
            wards: ["Phường Võ Thị Sáu", "Phường Nguyễn Cư Trinh"],
            streets: ["Đường Cách Mạng Tháng 8", "Đường Trường Sa"]
        },
        "Thủ Đức": {
            wards: ["Phường Linh Trung", "Phường Tam Bình"],
            streets: ["Đường Đặng Văn Bi", "Đường Võ Văn Ngân"]
        }
    },
    2: {// Hà Nội
        "Ba Đình": {
            wards: ["Phường Ngọc Hà", "Phường Kim Mã", "Phường Đội Cấn"],
            streets: ["Đường Hoàng Diệu", "Đường Đội Cấn"]
        },
        "Hoàn Kiếm": {
            wards: ["Phường Hàng Bạc", "Phường Cửa Nam"],
            streets: ["Đường Hàng Đào", "Đường Phan Chu Trinh"]
        },
        "Cầu Giấy": {
            wards: ["Phường Dịch Vọng Hậu", "Phường Nghĩa Tân"],
            streets: ["Đường Xuân Thủy", "Đường Trần Duy Hưng"]
        },
        "Đống Đa": {
            wards: ["Phường Văn Miếu", "Phường Quán Thánh"],
            streets: ["Đường Tôn Đức Thắng", "Đường Đặng Tiến Đông"]
        }
    },
    3: {// Cần Thơ
        "Ninh Kiều": {
            wards: ["Phường Cái Khế", "Phường An Cư"],
            streets: ["Đường Lê Lợi", "Đường Nguyễn Trãi"]
        },
        "Bình Thủy": {
            wards: ["Phường Bình Thủy", "Phường Trà Nóc"],
            streets: ["Đường Nguyễn Văn Linh", "Đường 3 Tháng 2"]
        },
        "Cái Răng": {
            wards: ["Phường Hưng Phú", "Phường Thường Thạnh"],
            streets: ["Đường Võ Văn Kiệt", "Đường Trần Phú"]
        },
        "Ô Môn": {
            wards: ["Phường Phước Thới", "Phường Thới An"],
            streets: ["Đường Lê Hồng Phong", "Đường 30 Tháng 4"]
        }
    }
};

document.getElementById("province").addEventListener("change", function () {
    let provinceId = this.value;
    let districtSelect = document.getElementById("district");

    // Xóa danh sách Quận/Huyện hiện tại
    districtSelect.innerHTML = '<option value="0">-- Chọn Quận/Huyện --</option>';

    // Xóa danh sách Phường/Xã và Đường/Phố
    document.getElementById("ward").innerHTML = '<option value="0">-- Chọn Phường/Xã --</option>';
    document.getElementById("street").innerHTML = '<option value="0">-- Chọn Đường/Phố --</option>';

    // Nếu có dữ liệu cho tỉnh/thành phố đã chọn, cập nhật danh sách Quận/Huyện
    if (districtsData[provinceId]) {
        for (let district in districtsData[provinceId]) {
            let option = document.createElement("option");
            option.value = district;
            option.textContent = district;
            districtSelect.appendChild(option);
        }
    }
});

// Khi chọn Quận/Huyện, cập nhật danh sách Phường/Xã và Đường/Phố
document.getElementById("district").addEventListener("change", function () {
    let provinceId = document.getElementById("province").value;
    let district = this.value;
    let wardSelect = document.getElementById("ward");
    let streetSelect = document.getElementById("street");

    // Xóa danh sách Phường/Xã và Đường/Phố hiện tại
    wardSelect.innerHTML = '<option value="0">-- Chọn Phường/Xã --</option>';
    streetSelect.innerHTML = '<option value="0">-- Chọn Đường/Phố --</option>';

    // Nếu có dữ liệu cho Quận/Huyện đã chọn, cập nhật danh sách Phường/Xã và Đường/Phố
    if (districtsData[provinceId] && districtsData[provinceId][district]) {
        // Cập nhật danh sách Phường/Xã
        districtsData[provinceId][district].wards.forEach((ward) => {
            let option = document.createElement("option");
            option.value = ward;
            option.textContent = ward;
            wardSelect.appendChild(option);
        });

        // Cập nhật danh sách Đường/Phố
        districtsData[provinceId][district].streets.forEach((street) => {
            let option = document.createElement("option");
            option.value = street;
            option.textContent = street;
            streetSelect.appendChild(option);
        });
    }
});
