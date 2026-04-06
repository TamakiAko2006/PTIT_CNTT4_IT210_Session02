package org.example.ss0022.Baitap.Bai1;



import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

/**
 * Khởi tạo Spring MVC, cấu hình DispatcherServlet
 */
public class MyWebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    // Không có cấu hình root context
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return null;
    }

    // Cấu hình Servlet context: WebConfig chứa controller, view resolver, service
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{WebConfig.class};
    }

    // Bắt tất cả request
    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
}
