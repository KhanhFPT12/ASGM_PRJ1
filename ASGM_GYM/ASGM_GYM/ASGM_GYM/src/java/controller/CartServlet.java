package controller;

import model.Cart;
import model.Courses;
import CourseDAO.CourseDao;
import service.CartService;
import service.ICartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CourseDao courseDao;
    private ICartService cartService;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        if (action != null) {
            try {
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                Courses course = courseDao.selectCourse(courseId);

                if (course != null) {
                    if ("add".equals(action) || "update".equals(action)) {
                        int quantity = Integer.parseInt(request.getParameter("quantity"));
                        if (quantity <= 0) {
                            quantity = 1; // Mặc định là 1 nếu quantity không hợp lệ
                        }
                        if ("add".equals(action)) {
                            cartService.addToCart(cart, course, quantity);
                        } else if ("update".equals(action)) {
                            cartService.updateCartItem(cart, courseId, quantity);
                        }
                    } else if ("remove".equals(action)) {
                        cartService.removeCartItem(cart, courseId);
                    }
                } else {
                    System.out.println("Course not found for courseId: " + courseId);
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid courseId or quantity: " + e.getMessage());
                // Xử lý lỗi, có thể đặt thông báo lỗi vào request nếu cần
                request.setAttribute("error", "Dữ liệu không hợp lệ. Vui lòng thử lại.");
            }
        }

        session.setAttribute("cart", cart);
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    @Override
    public String getServletInfo() {
        return "Servlet to manage shopping cart";
    }
}