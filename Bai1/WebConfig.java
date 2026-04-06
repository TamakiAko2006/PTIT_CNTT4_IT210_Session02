package org.example.ss0022.Baitap.Bai1;


import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Cấu hình Spring MVC
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "org.example.ss0022.Baitap") // Quét cả controller và service
public class WebConfig implements WebMvcConfigurer {

    // Cấu hình ViewResolver cho JSP
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/views/", ".jsp");
    }
}
