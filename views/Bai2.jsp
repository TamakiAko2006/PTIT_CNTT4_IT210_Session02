<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%--
====================================================================
Phân tích trang report.jsp (Khá 2 - JSP lộn xộn)
====================================================================

1. Vị trí và vấn đề

#  | Vị trí / Thành phần                 | Loại vấn đề                  | Hậu quả chi tiết
---|------------------------------------|-----------------------------|-----------------------------------------------
1  | <%! private int requestCounter = 0; %> | Race Condition / Declaration | Biến dùng chung trên tất cả request, không thread-safe, nhiều user cùng truy cập → dữ liệu bị ghi đè.
2  | <% for(int i=0; i<students.size(); i++){ %> | Scriptlet / Logic trong View | Vòng lặp Java trong JSP → vi phạm Thin View, khó bảo trì, logic nên để Controller.
3  | <%= student.getName() %>             | Expression                   | Không dùng <c:out> → nguy cơ XSS nếu dữ liệu chứa HTML/JS độc hại.
4  | <!-- HTML comment -->               | HTML Comment                  | HTML comment hiển thị ra client → lộ thông tin nhạy cảm, nên dùng JSP Comment <%-- --%>.
<%--5  | <% if(student.getScore() >= 5){ %>  | Scriptlet / Logic            | Điều kiện Java trong View → vi phạm Thin View, khó đọc, khó test.
6  | <%! private String helperMethod(...) %> | Declaration / Logic         | Method Java trong JSP → view chứa logic, vi phạm MVC.

2. Giải pháp refactor

- Không dùng Scriptlet (<% %>) hoặc Declaration (<%! %>)
- Sử dụng JSTL (<c:forEach>, <c:choose>) thay vòng lặp và điều kiện
    - Sử dụng EL (${student.name}) kết hợp <c:out> để chống XSS
        - Dùng JSP Comment <%-- --%> cho ghi chú nội bộ
        - Thin View: chỉ hiển thị dữ liệu, không chứa logic xử lý

        ====================================================================
        --%>

        <html>
        <head>
        <title>Báo cáo điểm sinh viên</title>
        <style>
        table { border-collapse: collapse; width: 80%; margin: auto; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f4f4f4; }
        </style>
        </head>
        <body>
        <h2 style="text-align:center;">Báo cáo điểm sinh viên</h2>

        <table>
        <thead>
        <tr>
        <th>STT</th>
        <th>Tên sinh viên</th>
        <th>Mã SV</th>
        <th>Điểm</th>
        <th>Trạng thái</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="student" items="${students}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td><c:out value="${student.name}" /></td>
                <td><c:out value="${student.id}" /></td>
                <td><c:out value="${student.score}" /></td>
                <td>
                    <c:choose>
                        <c:when test="${student.score >= 5}">
                            Đạt
                        </c:when>
                        <c:otherwise>
                            Không đạt
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        </table>

        </body>
        </html>