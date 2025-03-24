package model;

import java.util.Date;

public class Enrollment {
      private int enrollmentID;
    private int learnerID;
    private int courseID;
    private Date enrollmentDate;
    private String paymentStatus;
    private User user; // Thêm để lưu thông tin khách hàng
    private Courses course; // Thêm để lưu thông tin khóa học

    public Enrollment(int enrollmentID, int learnerID, int courseID, Date enrollmentDate, String paymentStatus, User user, Courses course) {
        this.enrollmentID = enrollmentID;
        this.learnerID = learnerID;
        this.courseID = courseID;
        this.enrollmentDate = enrollmentDate;
        this.paymentStatus = paymentStatus;
        this.user = user;
        this.course = course;
    }

    public Enrollment() {
    }

    public int getEnrollmentID() {
        return enrollmentID;
    }

    public void setEnrollmentID(int enrollmentID) {
        this.enrollmentID = enrollmentID;
    }

    public int getLearnerID() {
        return learnerID;
    }

    public void setLearnerID(int learnerID) {
        this.learnerID = learnerID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public Date getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(Date enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    @Override
    public String toString() {
        return "Enrollment{" + "enrollmentID=" + enrollmentID + ", learnerID=" + learnerID + ", courseID=" + courseID + ", enrollmentDate=" + enrollmentDate + ", paymentStatus=" + paymentStatus + ", user=" + user + ", course=" + course + '}';
    }

    // Constructor, getters, setters như cũ
    // Thêm getter/setter cho user và course
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Courses getCourse() { return course; }
    public void setCourse(Courses course) { this.course = course; }
}