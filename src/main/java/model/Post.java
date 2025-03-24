/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author DVHao
 */
public class Post {

    private int postId;
    private int userId;
    private int catId;
    private String title;
    private String description;
    private double price;
    private String address;
    private String city;
    private String district;
    private double area;
    private int roomCount;
    private String utilities;
    private Category postType;
    private String status;
    private User user;
    private List<Image> images;
    private Timestamp created_at;
    private Timestamp updaited_at;
    private boolean savedStatus;

    public Post() {
        this.savedStatus = false;
    }

    public Post(int postId, int userId, int catId, String title, String description, double price, String address, String city, String district, double area, int roomCount, String utilities, Category postType, String status, User user, List<Image> images, Timestamp created_at, Timestamp updaited_at) {
        this.postId = postId;
        this.userId = userId;
        this.catId = catId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.address = address;
        this.city = city;
        this.district = district;
        this.area = area;
        this.roomCount = roomCount;
        this.utilities = utilities;
        this.postType = postType;
        this.status = status;
        this.user = user;
        this.images = images;
        this.created_at = created_at;
        this.updaited_at = updaited_at;
    }

    public Post(int postId, int userId, int catId, String title, String description, double price, String address, String city, String district, double area, int roomCount, Category postType, String status, User user, List<Image> images, Timestamp created_at, Timestamp updated_at) {
        this.postId = postId;
        this.userId = userId;
        this.catId = catId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.address = address;
        this.city = city;
        this.district = district;
        this.area = area;
        this.roomCount = roomCount;
        this.postType = postType;
        this.status = status;
        this.user = user;
        this.images = images;
        this.created_at = created_at;
        this.updaited_at = updated_at;
    }

    public Post(int postId, int catId, String title, String description, double price, String address, String city, String district, double area, int roomCount, Category postType, String status, Timestamp updaited_at) {
        this.postId = postId;
        this.catId = catId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.address = address;
        this.city = city;
        this.district = district;
        this.area = area;
        this.roomCount = roomCount;
        this.postType = postType;
        this.status = status;
        this.updaited_at = updaited_at;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUtilities() {
        return utilities;
    }

    public void setUtilities(String utilities) {
        this.utilities = utilities;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public int getRoomCount() {
        return roomCount;
    }

    public void setRoomCount(int roomCount) {
        this.roomCount = roomCount;
    }

    public Category getPostType() {
        return postType;
    }

    public void setPostType(Category postType) {
        this.postType = postType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Image> getImages() {
        return images;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdaited_at() {
        return updaited_at;
    }

    public void setUpdaited_at(Timestamp updaited_at) {
        this.updaited_at = updaited_at;
    }

    public boolean isSavedStatus() {
        return savedStatus;
    }

    public void setSavedStatus(boolean savedStatus) {
        this.savedStatus = savedStatus;
    }

    @Override
    public String toString() {
        return "Post{" + "title=" + title + ", description=" + description + ", price=" + price + ", address=" + address + ", city=" + city + ", district=" + district + ", area=" + area + ", postType=" + postType + '}';
    }

}
