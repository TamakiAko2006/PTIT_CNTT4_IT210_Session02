package org.example.ss0022.Baitap.Bai3;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletContext;

import java.util.Date;
import java.util.List;
@Controller
public class AuthController {

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpServletRequest request) {

        if ((username.equals("admin") && password.equals("admin123")) ||
                (username.equals("staff") && password.equals("staff123"))) {

            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", username);
            session.setAttribute("role", username.equals("admin") ? "ADMIN" : "STAFF");

            return "redirect:/orders";
        }

        // ❗ request scope
        request.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}