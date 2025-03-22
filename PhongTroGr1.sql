CREATE DATABASE PhongTroGr1
USE PhongTroGr1

CREATE TABLE Users(
	User_id INT IDENTITY(1,1) PRIMARY KEY,
	Fullname NVARCHAR(50) NOT NULL,
	Username VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(255) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Role INT NOT NULL,
	AuthenticationCode VARCHAR(100),
    ExpirationTime DATETIME,
    VerificationStatus TINYINT DEFAULT 0,
	RegisterStatus TINYINT DEFAULT 0,
	Avatar VARBINARY(MAX)
);

CREATE TABLE Categories (
    Category_id INT IDENTITY(1,1) PRIMARY KEY,
    Category_name NVARCHAR(100) NOT NULL,
);

CREATE TABLE Posts (
    Post_id INT IDENTITY(1,1) PRIMARY KEY,
    User_id INT NOT NULL,
    Category_id INT NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10, 2),
    Address NVARCHAR(255),
    City NVARCHAR(100),
    District NVARCHAR(100),
    Ward NVARCHAR(100),
    Area DECIMAL(10, 2),
    Room_count INT,
    Post_type NVARCHAR(50) NOT NULL,
    Status NVARCHAR(50),
	Created_at DATETIME,
	Updated_at DATETIME,
    FOREIGN KEY (User_id) REFERENCES Users(User_id),
    FOREIGN KEY (Category_id) REFERENCES Categories(Category_id)
);

CREATE TABLE Images (
    Image_id INT IDENTITY(1,1) PRIMARY KEY,
    Post_id INT NOT NULL,
    Photo VARBINARY(MAX),
    FOREIGN KEY (Post_id) REFERENCES Posts(Post_id)
);

CREATE TABLE Reviews (
    Review_id INT IDENTITY(1,1) PRIMARY KEY,
    User_id INT NOT NULL,
    Post_id INT NOT NULL,
    Rating INT NOT NULL,
    Comment NVARCHAR(MAX),
    Created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (User_id) REFERENCES Users(User_id),
    FOREIGN KEY (Post_id) REFERENCES Posts(Post_id)
);

CREATE TABLE Saved_posts (
    Saved_id INT IDENTITY(1,1) PRIMARY KEY,
    User_id INT NOT NULL,
    Post_id INT NOT NULL,
    Created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (User_id) REFERENCES Users(User_id) ON DELETE CASCADE,
    FOREIGN KEY (Post_id) REFERENCES Posts(Post_id) ON DELETE CASCADE
)

INSERT INTO Categories VALUES
(N'Nhà trọ'),
(N'Mini house'),
(N'Nhà nguyên căn'),
(N'Căn hộ');