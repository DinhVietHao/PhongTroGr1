/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DVHao
 */
public class Image {
    
    private int imageId;
    private int postId;
    private byte[] imageData; // Lưu ảnh dạng byte[]

    public Image() {
    }

    public Image(int imageId, int postId, byte[] imageData) {
        this.imageId = imageId;
        this.postId = postId;
        this.imageData = imageData;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    @Override
    public String toString() {
        return "Image{" + "imageId=" + imageId + ", postId=" + postId + ", imageData=[BLOB DATA] }";
    }
    
}
