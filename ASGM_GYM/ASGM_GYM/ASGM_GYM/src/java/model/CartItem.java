/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class CartItem {
    private Courses course;
    private int quantity;

    public CartItem(Courses course, int quantity) { 
        this.course = course; 
        this.quantity = quantity;
    } 
    
    public Courses getCourses() {
        return course;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getTotalPrice() {
        return course.getPrice() * quantity;
    }

    public double getDiscountedPrice() {
    return course.getPrice() * (1 - 0.10); 
}

    public double getTotalDiscountedPrice() {
        return getDiscountedPrice() * quantity;
    }

    public double getTotalDiscountAmount() {
        return (course.getPrice() * quantity) - getTotalDiscountedPrice();
    }
}
