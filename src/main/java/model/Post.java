/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
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
    private String ward;
    private double area;
    private int roomCount;
    private String postType;
    private String status;
    private Date created_at;
    private Date updaited_at;
    private User user;
    private List<Image> images;

    public Post() {
    }

    public Post(int postId, int userId, int catId, String title, String description, double price, String address, String city, String district, String ward, double area, int roomCount, String postType, String status, Date created_at, Date updaited_at, User user, List<Image> images) {
        this.postId = postId;
        this.userId = userId;
        this.catId = catId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.address = address;
        this.city = city;
        this.district = district;
        this.ward = ward;
        this.area = area;
        this.roomCount = roomCount;
        this.postType = postType;
        this.status = status;
        this.created_at = created_at;
        this.updaited_at = updaited_at;
        this.user = user;
        this.images = images;
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

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
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

    public String getPostType() {
        return postType;
    }

    public void setPostType(String postType) {
        this.postType = postType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdaited_at() {
        return updaited_at;
    }

    public void setUpdaited_at(Date updaited_at) {
        this.updaited_at = updaited_at;
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

    @Override
    public String toString() {
        return "Post{" + "postId=" + postId + ", userId=" + userId + ", catId=" + catId + ", title=" + title + ", description=" + description + ", price=" + price + ", address=" + address + ", city=" + city + ", district=" + district + ", ward=" + ward + ", area=" + area + ", roomCount=" + roomCount + ", postType=" + postType + ", status=" + status + ", created_at=" + created_at + ", updaited_at=" + updaited_at + ", user=" + user + ", images=" + images + '}';
    }

}
