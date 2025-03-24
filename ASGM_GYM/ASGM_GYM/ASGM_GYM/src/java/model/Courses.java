/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Courses {
    private int courseId;
    private String courseName;
    private String description;
    private int trainerId;
    private double price;
    private Boolean status;

    public Courses() {
    }

    public Courses(int courseId, String courseName, String description, int trainerId, double price, Boolean status) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.description = description;
        this.trainerId = trainerId;
        this.price = price;
        this.status = status;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Courses{" + "courseId=" + courseId + ", courseName=" + courseName + ", description=" + description + ", trainerId=" + trainerId + ", price=" + price + ", status=" + status + '}';
    }
    
    

}
