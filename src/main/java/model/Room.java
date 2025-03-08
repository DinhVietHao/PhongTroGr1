/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author Admin
 */
public class Room {

    private int id;
    private String title;
    private String description;
    private double price;
    private int area;
    private String address;
    private String contactName;
    private String contactPhone;
    private List<String> images;

    public Room() {
    }

    public Room(int id, String title, String description, double price, int area, String address, String contactName, String contactPhone, List<String> images) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.price = price;
        this.area = area;
        this.address = address;
        this.contactName = contactName;
        this.contactPhone = contactPhone;
        this.images = images;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getArea() {
        return area;
    }

    public void setArea(int area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    @Override
    public String toString() {
        return "Room{" + "id=" + id + ", title=" + title + ", description=" + description + ", price=" + price + ", area=" + area + ", address=" + address + ", contactName=" + contactName + ", contactPhone=" + contactPhone + ", images=" + images + '}';
    }
    
    
    
    
}
