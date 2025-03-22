/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import database.DBContext;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import model.Image;
import java.sql.*;
import model.Category;
import model.Post;
import model.User;

/**
 *
 * @author DVHao
 */
public class PostDAO extends DBContext {

    public PostDAO() {
        super();
    }

    public List<Image> selectImageByPostId(int post_id) {
        List<Image> data = new ArrayList<>();
        String sql = "SELECT * FROM Images WHERE Post_id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, post_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Image img = new Image(rs.getInt("Image_id"),
                        rs.getInt("Post_id"),
                        rs.getBytes("Photo"));
                data.add(img);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return data;
    }

    public boolean deletePostByPostId(int postId) {
        String deleteImagesSQL = "DELETE FROM Images WHERE Post_id = ?";
        String deleteReviewsSQL = "DELETE FROM Reviews WHERE Post_id = ?";
        String deleteSavedPostsSQL = "DELETE FROM Saved_posts WHERE Post_id = ?";
        String deletePostSQL = "DELETE FROM Posts WHERE Post_id = ?";

        try ( PreparedStatement ps1 = conn.prepareStatement(deleteImagesSQL);  PreparedStatement ps2 = conn.prepareStatement(deleteReviewsSQL);  PreparedStatement ps3 = conn.prepareStatement(deleteSavedPostsSQL);  PreparedStatement ps4 = conn.prepareStatement(deletePostSQL)) {

            ps1.setInt(1, postId);
            ps1.executeUpdate();

            ps2.setInt(1, postId);
            ps2.executeUpdate();

            ps3.setInt(1, postId);
            ps3.executeUpdate();

            ps4.setInt(1, postId);
            int rowsAffected = ps4.executeUpdate();

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public List<Category> selectAllCategory() {
        List<Category> data = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt("Category_id"), rs.getString("Category_name"));
                data.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return data;
    }

    public Category selectCategoryById(int id) {
        String sql = "SELECT * FROM Categories WHERE Category_id = ?"; // Sửa "id" thành "Category_id"
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(
                        rs.getInt("Category_id"),
                        rs.getString("Category_name")
                );
            }
        } catch (SQLException e) {
            System.out.println("Lỗi truy vấn selectCategoryById: " + e.getMessage());
        }
        return null;
    }

    public User selectLandlordById(int id) {
        User landlord = null;
        String sql = "SELECT User_id, Fullname, Email, Phone, Role, Avatar FROM Users WHERE User_id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                byte[] imageData = rs.getBytes("Avatar");
                landlord = new User(rs.getString("Fullname"), rs.getString("Email"), rs.getString("Phone"), imageData);
                landlord.setUserId(id);
                landlord.setRole(rs.getInt("Role"));
                return landlord;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return landlord;
    }

    public List<Post> selectPostAll() {
        List<Post> data = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE Status = N'Còn phòng' ORDER BY Created_at DESC";
        Post post = null;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                post = new Post(rs.getInt("Post_id"),
                        rs.getInt("User_id"),
                        rs.getInt("Category_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("District"),
                        rs.getString("Ward"),
                        rs.getDouble("Area"),
                        rs.getInt("Room_count"),
                        selectCategoryById(rs.getInt("Category_id")),
                        rs.getString("Status"),
                        selectLandlordById(rs.getInt("User_id")),
                        selectImageByPostId(rs.getInt("Post_id")),
                        rs.getTimestamp("Created_at"),
                        rs.getTimestamp("Updated_at"));
                data.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return data;
    }

    public List<Post> selectPostAllNotApproved() {
        List<Post> data = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE Status = N'Chưa duyệt' ORDER BY Post_id DESC";
        Post post = null;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                post = new Post(rs.getInt("Post_id"),
                        rs.getInt("User_id"),
                        rs.getInt("Category_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("District"),
                        rs.getString("Ward"),
                        rs.getDouble("Area"),
                        rs.getInt("Room_count"),
                        selectCategoryById(rs.getInt("Category_id")),
                        rs.getString("Status"),
                        selectLandlordById(rs.getInt("User_id")),
                        selectImageByPostId(rs.getInt("Post_id")),
                        rs.getTimestamp("Created_at"),
                        rs.getTimestamp("Updated_at"));
                data.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return data;
    }

    public boolean acceptPost(int postId) {
        String sql = "UPDATE Posts SET Status = N'Còn phòng', Created_at = ? WHERE Post_id = ?";
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        try ( PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setTimestamp(1, currentTime);
            pstmt.setInt(2, postId);
            int affectedRows = pstmt.executeUpdate();

            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    public int getMaxPostIDByUserId(int userid) {
        String sql = "SELECT MAX(Post_id) as maxPostId From Posts where User_id = ?";
        int maxPostId = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userid);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                maxPostId = rs.getInt("maxPostId");
                return maxPostId;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return maxPostId;
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE User_id = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("User_id"),
                            rs.getString("Fullname"),
                            rs.getString("Username"),
                            rs.getString("Password"),
                            rs.getString("Email"),
                            rs.getString("Phone"),
                            rs.getInt("Role"),
                            rs.getString("AuthenticationCode"),
                            rs.getTimestamp("ExpirationTime"),
                            rs.getBoolean("VerificationStatus")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<Post> getListPostByUserId(int userId) {
        List<Post> listPost = new ArrayList<>();
        String sql = "SELECT * FROM Posts WHERE User_id = ? AND Status = N'Còn Phòng' ORDER BY Post_id DESC";
        Post post = null;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                post = new Post(rs.getInt("Post_id"),
                        rs.getInt("User_id"),
                        rs.getInt("Category_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("District"),
                        rs.getString("Ward"),
                        rs.getDouble("Area"),
                        rs.getInt("Room_count"),
                        selectCategoryById(rs.getInt("Category_id")),
                        rs.getString("Status"),
                        selectLandlordById(rs.getInt("User_id")),
                        selectImageByPostId(rs.getInt("Post_id")),
                        rs.getTimestamp("Created_at"),
                        rs.getTimestamp("Updated_at"));
                listPost.add(post);
            }
            return listPost;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return listPost;
    }

    public Post getPostByPostId(int postId) {
        String sql = "SELECT * FROM Posts WHERE Post_id = ?";
        Post post = null;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                post = new Post(rs.getInt("Post_id"),
                        rs.getInt("User_id"),
                        rs.getInt("Category_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("District"),
                        rs.getString("Ward"),
                        rs.getDouble("Area"),
                        rs.getInt("Room_count"),
                        selectCategoryById(rs.getInt("Category_id")),
                        rs.getString("Status"),
                        selectLandlordById(rs.getInt("User_id")),
                        selectImageByPostId(rs.getInt("Post_id")),
                        rs.getTimestamp("Created_at"),
                        rs.getTimestamp("Updated_at"));
            }
            return post;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return post;
        }
    }

    public boolean createPost(Post post, List<InputStream> images) throws IOException {
        String sqlPost = "INSERT INTO Posts (User_id, Category_id, Title, Description, Price, Address, City, District, Ward, Area, Room_count, Post_type, Status, Created_at, Updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        if (conn == null) {
            System.out.println("Lỗi: Kết nối đến cơ sở dữ liệu bị mất!");
            return false;
        }

        try ( PreparedStatement ps = conn.prepareStatement(sqlPost, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, post.getUserId());
            ps.setInt(2, post.getCatId());
            ps.setString(3, post.getTitle());
            ps.setString(4, post.getDescription());
            ps.setDouble(5, post.getPrice());
            ps.setString(6, post.getAddress());
            ps.setString(7, post.getCity());
            ps.setString(8, post.getDistrict());
            ps.setString(9, post.getWard());
            ps.setDouble(10, post.getArea());
            ps.setInt(11, post.getRoomCount());
            ps.setString(12, post.getPostType().getCatName());
            ps.setString(13, post.getStatus());
            ps.setTimestamp(14, post.getCreated_at());
            ps.setTimestamp(15, post.getUpdaited_at());
            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                System.out.println("Lỗi: Không thể tạo bài đăng!");
                return false;
            }

            // Lấy postId mới tạo
            int postId = -1;
            try ( ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    postId = generatedKeys.getInt(1);
                    post.setPostId(postId);
                } else {
                    System.out.println("Lỗi: Không lấy được Post_id!");
                    return false;
                }
            }

            // Lưu ảnh vào CSDL
            ImageDAO imageDAO = new ImageDAO();
            for (InputStream imageStream : images) {
                boolean isUploaded = imageDAO.uploadImage(postId, imageStream);
                if (!isUploaded) {
                    System.out.println("Lỗi: Không thể tải lên ảnh cho bài đăng " + postId);
                    return false;
                }
            }

            return true;
        } catch (SQLException e) {
            System.out.println("Lỗi khi tạo bài đăng: " + e.getMessage());
            return false;
        }
    }

    public void savePostById(int userId, int postId) {
        String sql = "INSERT INTO Saved_posts(User_id, Post_id) VALUES(?, ?)";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setInt(1, userId);
            pt.setInt(2, postId);
            pt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void deletePostById(int userId, int postId) {
        String sql = "DELETE Saved_posts WHERE User_id = ? AND Post_id = ?";
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setInt(1, userId);
            pt.setInt(2, postId);
            pt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public boolean updatePost(Post post, List<InputStream> images) throws IOException {
        String sqlPost = "UPDATE Posts SET Category_id = ?, District = ?, Ward = ?, Address = ?, Title = ?, Description = ?, Price = ?, Area = ?, Room_count = ?, Updated_at = ? WHERE Post_id = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sqlPost)) {
            ps.setInt(1, post.getCatId());
            ps.setString(2, post.getDistrict());
            ps.setString(3, post.getWard());
            ps.setString(4, post.getAddress());
            ps.setString(5, post.getTitle());
            ps.setString(6, post.getDescription());
            ps.setDouble(7, post.getPrice());
            ps.setDouble(8, post.getArea());
            ps.setInt(9, post.getRoomCount());
            ps.setTimestamp(10, post.getUpdaited_at());
            ps.setInt(11, post.getPostId());

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                System.out.println("Lỗi: Không thể update bài đăng!");
                return false;
            }

            if (images != null && !images.isEmpty()) {
                ImageDAO imageDAO = new ImageDAO();

                if (!imageDAO.deleteAllImageByPostId(post.getPostId())) {
                    System.out.println("Lỗi: Không thể xóa ảnh cũ!");
                    return false;
                }

                for (InputStream imageStream : images) {
                    boolean isUploaded = imageDAO.uploadImage(post.getPostId(), imageStream);
                    if (!isUploaded) {
                        System.out.println("Lỗi: Không thể tải lên ảnh mới!");
                        return false;
                    }
                }
            }

            return true;
        } catch (SQLException e) {
            System.out.println("Lỗi khi update bài đăng: " + e.getMessage());
            return false;
        }
    }

    public List<Post> selectAllSavedPost(int userId) {
        String sql = "SELECT p.* FROM Posts p "
                + "JOIN Saved_posts sp ON p.Post_id = sp.Post_id "
                + "WHERE sp.User_id = ?";
        List<Post> list = new ArrayList<>();

        try ( PreparedStatement pt = conn.prepareStatement(sql)) {
            pt.setInt(1, userId);
            ResultSet rs = pt.executeQuery();

            while (rs.next()) {
                Post post = new Post(
                        rs.getInt("Post_id"),
                        rs.getInt("User_id"),
                        rs.getInt("Category_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("District"),
                        rs.getString("Ward"),
                        rs.getDouble("Area"),
                        rs.getInt("Room_count"),
                        selectCategoryById(rs.getInt("Category_id")),
                        rs.getString("Status"),
                        selectLandlordById(rs.getInt("User_id")),
                        selectImageByPostId(rs.getInt("Post_id")),
                        rs.getTimestamp("Created_at"),
                        rs.getTimestamp("Updated_at"));
                list.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public boolean checkIfPostIsSaved(int userId, int postId) {
        String sql = "SELECT * FROM Saved_posts WHERE User_id = ? AND Post_id = ?";
        boolean flag = false;
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            pt.setInt(1, userId);
            pt.setInt(2, postId);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                flag = true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return flag;
    }

    public int getTotalPost() {
        String sql = "SELECT COUNT(*) FROM Posts";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<Post> pagingPost(int index) {
        List<Post> listPost = new ArrayList<>();
        Post post = null;
        //String sql = "SELECT * FROM Posts ORDER BY Post_id OFFSET ? ROWS FETCH NEXT 3 ROW ONLY";
        String sql = "SELECT * FROM Posts WHERE Status = N'Còn phòng' ORDER BY Created_at DESC OFFSET ? ROWS FETCH NEXT 3 ROW ONLY";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, (index - 1) * 3);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                post = new Post(rs.getInt("Post_id"),
                        rs.getInt("User_id"),
                        rs.getInt("Category_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("District"),
                        rs.getString("Ward"),
                        rs.getDouble("Area"),
                        rs.getInt("Room_count"),
                        selectCategoryById(rs.getInt("Category_id")),
                        rs.getString("Status"),
                        selectLandlordById(rs.getInt("User_id")),
                        selectImageByPostId(rs.getInt("Post_id")),
                        rs.getTimestamp("Created_at"),
                        rs.getTimestamp("Updated_at"));
                listPost.add(post);
            }
            return listPost;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return listPost;
    }

    public int selectCountPost() {
        String sql = "SELECT COUNT(Post_id) AS No_Post FROM Posts WHERE Status = N'Còn phòng'";
        int cnt = 0;
        try {
            PreparedStatement pt = conn.prepareStatement(sql);
            ResultSet rs = pt.executeQuery();
            if (rs.next()) {
                cnt = rs.getInt("No_Post");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return cnt;
    }

    public List<Post> selectByFilter(String type, String district, String price, String area) {
        List<Post> data = new ArrayList<>();
        Post post = null;
        StringBuilder sql = new StringBuilder("SELECT * FROM Posts WHERE Post_type = ?");
        
        if (!district.equals("All")) {
            sql.append(" AND District = ?");
        }

        if (!price.equals("All")) {
            String[] parts = price.split("-");
            if (parts.length == 2) {
                if (parts[1].equals("0")) {
                    sql.append(" AND Price > ?");
                } else {
                    sql.append(" AND Price BETWEEN ? AND ?");
                }
            }
        }

        if (!area.equals("All")) {
            String[] parts = area.split("-");
            if (parts.length == 2) {
                if (parts[1].equals("0")) {
                    sql.append(" AND Area > ?");
                } else {
                    sql.append(" AND Area BETWEEN ? AND ?");
                }
            }
        }

        try ( PreparedStatement pt = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            pt.setString(paramIndex++, type);

            if (!district.equals("All")) {
                pt.setString(paramIndex++, district);
            }

            if (!price.equals("All")) {
                String[] parts = price.split("-");
                if (parts.length == 2) {
                    if (parts[1].equals("0")) {
                        pt.setDouble(paramIndex++, Double.parseDouble(parts[0]) * 1000000);
                    } else {
                        pt.setDouble(paramIndex++, Double.parseDouble(parts[0]) * 1000000);
                        pt.setDouble(paramIndex++, Double.parseDouble(parts[1]) * 1000000);
                    }
                }
            }

            if (!area.equals("All")) {
                String[] parts = area.split("-");
                if (parts.length == 2) {
                    if (parts[1].equals("0")) {
                        pt.setDouble(paramIndex++, Double.parseDouble(parts[0]));
                    } else {
                        pt.setDouble(paramIndex++, Double.parseDouble(parts[0]));
                        pt.setDouble(paramIndex++, Double.parseDouble(parts[1]));
                    }
                }
            }

            ResultSet rs = pt.executeQuery();
            while (rs.next()) {
                post = new Post(
                        rs.getInt("Post_id"),
                        rs.getInt("User_id"),
                        rs.getInt("Category_id"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("District"),
                        rs.getString("Ward"),
                        rs.getDouble("Area"),
                        rs.getInt("Room_count"),
                        selectCategoryById(rs.getInt("Category_id")),
                        rs.getString("Status"),
                        selectLandlordById(rs.getInt("User_id")),
                        selectImageByPostId(rs.getInt("Post_id")),
                        rs.getTimestamp("Created_at"),
                        rs.getTimestamp("Updated_at")
                );
                data.add(post);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return data;
    }
    
}
