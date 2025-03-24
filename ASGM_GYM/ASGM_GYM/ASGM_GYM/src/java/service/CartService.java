package service;

import model.Cart;
import model.CartItem;
import model.Courses;

public class CartService implements ICartService {

    @Override
    public void addToCart(Cart cart, Courses course, int quantity) {
        cart.addItem(course, quantity);
    }

    @Override
    public void updateCartItem(Cart cart, int courseId, int quantity) {
        cart.updateItem(courseId, quantity);
    }

    @Override
    public void removeCartItem(Cart cart, int courseId) {
        cart.removeItem(courseId);
    }

    @Override
    public double getTotalPrice(Cart cart) {
        return cart.getTotalAmount();
    }

    @Override
    public double calculateTotalWithDiscount(Cart cart) {
        return cart.getTotalAmountWithDiscount();
    }

    @Override
    public double calculateTotalDiscount(Cart cart) {
        return cart.getTotalDiscount();
    }
    @Override
    public void applyDiscount(Cart cart, String discountCode) {
        cart.applyDiscount(discountCode);
    }

}
