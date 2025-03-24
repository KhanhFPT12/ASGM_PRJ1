/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import model.Cart;
import model.Courses;

public interface ICartService {
    void addToCart(Cart cart, Courses course, int quantity);
    void updateCartItem(Cart cart, int courseId, int quantity);
    void removeCartItem(Cart cart, int courseId);
    double getTotalPrice(Cart cart);
    double calculateTotalWithDiscount(Cart cart);
    double calculateTotalDiscount(Cart cart);
    void applyDiscount(Cart cart, String discountCode);
}
