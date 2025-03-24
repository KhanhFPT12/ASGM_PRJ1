/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
    private String discountCode;
    private double discountPercentage = 0.0;

    private Map<Integer, CartItem> items = new LinkedHashMap<>();

    public void addItem(Courses course, int quantity) {
        int courseId = course.getCourseId();

        if (items.containsKey(courseId)) {
            CartItem item = items.get(courseId);
            item.setQuantity(item.getQuantity() + quantity);
        } else {  
            items.put(courseId, new CartItem(course, quantity));
        }
    }

    public void updateItem(int courseId, int quantity) {
        if (items.containsKey(courseId)) {
            if (quantity <= 0) {
                items.remove(courseId);
            } else {
                items.get(courseId).setQuantity(quantity);
            }
        }
    }

    public void removeItem(int courseId) {
        items.remove(courseId);
        discountCode = null;
        discountPercentage = 0.0;
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

    public int getTotalQuantity() {
        return items.values().stream().mapToInt(CartItem::getQuantity).sum();
    }

    public double getTotalAmount() {
        return items.values().stream()
            .mapToDouble(CartItem::getTotalPrice)
            .sum();
    }

    public double getTotalDiscount() {
        return getTotalAmount() * (discountPercentage / 100);
    }

    public double getTotalAmountWithDiscount() {
        return getTotalAmount() - getTotalDiscount();
    }

    public void applyDiscount(String code) {
        double discount = checkValidDiscount(code);
        this.discountPercentage = discount;
        this.discountCode = discount > 0 ? code : null;
    }

    private double checkValidDiscount(String code) {
        if (code == null || code.isEmpty()) {
            return 0.0;
        }
        switch (code.toUpperCase()) {
            case "SALE10": return 10;
            case "SALE20": return 20; 
            case "SALE30": return 30;
            default: return 0.0; 
        }
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public double getDiscountPercentage() {
        return discountPercentage;
    }

    public void clear() {
        items.clear();
        discountCode = null;
        discountPercentage = 0.0;
    }
}
