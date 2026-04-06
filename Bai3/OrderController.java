package org.example.ss0022.Baitap.Bai3;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletContext;

import java.util.Date;
import java.util.List;

@Controller
public class OrderController {

    @GetMapping("/orders")
    public String orders(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        // ❗ chưa login
        if (session == null || session.getAttribute("loggedUser") == null) {
            return "redirect:/login";
        }

        // fake data
        List<Order> orders = List.of(
                new Order("OD01", "Laptop", 15000000, new Date()),
                new Order("OD02", "Mouse", 500000, new Date()),
                new Order("OD03", "Keyboard", 1200000, new Date())
        );

        // ❗ request scope
        request.setAttribute("orders", orders);

        // ❗ Application scope + tránh race condition
        ServletContext app = request.getServletContext();
        synchronized (app) {
            Integer count = (Integer) app.getAttribute("totalViewCount");
            if (count == null) count = 0;
            app.setAttribute("totalViewCount", count + 1);
        }

        return "orders";
    }
}
