/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author DVHao
 */
public class Review {

    private int reviewId;
    private int userId;
    private int postId;
    private int rating;
    private String comment;
    private Timestamp created_at;

    public Review() {
        this.rating = 5;
    }

    public Review(int reviewId, int userId, int postId, int rating, String comment, Timestamp created_at) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.postId = postId;
        this.rating = rating;
        this.comment = comment;
        this.created_at = created_at;
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

}
