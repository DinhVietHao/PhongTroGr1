/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author DVHao
 */
public class SavedPost {

    private int savedId;
    private int userId;
    private int postId;
    private Date created_at;

    public SavedPost() {
    }

    public SavedPost(int savedId, int userId, int postId, Date created_at) {
        this.savedId = savedId;
        this.userId = userId;
        this.postId = postId;
        this.created_at = created_at;
    }

    public int getSavedId() {
        return savedId;
    }

    public void setSavedId(int savedId) {
        this.savedId = savedId;
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

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

}
