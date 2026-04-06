<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<h2>
    Kết quả tìm kiếm cho:
    <c:out value="${keyword}" />
</h2>

<p>Tìm thấy ${fn:length(events)} sự kiện</p>

<!-- Không có kết quả -->
<c:if test="${empty events}">
    <p>Không tìm thấy sự kiện nào phù hợp.</p>
</c:if>

<!-- Có dữ liệu -->
<c:if test="${not empty events}">
    <table border="1">
        <tr>
            <th>STT</th>
            <th>Tên</th>
            <th>Ngày</th>
            <th>Giá</th>
            <th>Vé</th>
            <th>Action</th>
        </tr>

        <c:forEach var="event" items="${events}" varStatus="s">
            <tr>
                <td>${s.count}</td>

                <!-- chống XSS -->
                <td><c:out value="${event.name}" /></td>

                <td>${event.date}</td>

                <!-- Giá -->
                <td>
                    <c:choose>
                        <c:when test="${event.price == 0}">
                            MIỄN PHÍ
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${event.price}" type="number"/>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- Vé -->
                <td>
                    <c:choose>
                        <c:when test="${event.remainingTickets == 0}">
                            <span style="color:red">HẾT VÉ</span>
                        </c:when>
                        <c:when test="${event.remainingTickets < 10}">
                            <span style="color:orange">
                                Sắp hết (còn ${event.remainingTickets} vé)
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="color:green">
                                    ${event.remainingTickets}
                            </span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- Link -->
                <td>
                    <c:choose>
                        <c:when test="${event.remainingTickets == 0}">
                            <span>Không thể đặt</span>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/events/${event.id}/book'/>">
                                Đặt vé
                            </a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<hr/>

<!-- Footer -->
<c:if test="${not empty events}">
    <p>
        Sự kiện đầu:
            ${fn:toUpperCase(events[0].name)}
    </p>
</c:if>

<p>
    Độ dài keyword: ${fn:length(keyword)} ký tự
</p>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- format số -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <!-- xử lý chuỗi -->

<!-- ================= HEADER ================= -->

<h2>
    Kết quả tìm kiếm cho:
    <!-- DÙNG c:out để chống XSS -->
    <!-- Nếu dùng ${keyword} thì script có thể chạy -->
    <!-- c:out sẽ escape thành text -->
    <c:out value="${keyword}" />
</h2>

<!-- fn:length để đếm số phần tử -->
<p>Tìm thấy ${fn:length(events)} sự kiện</p>

<!-- Nếu không có dữ liệu -->
<c:if test="${empty events}">
    <p>Không tìm thấy sự kiện nào phù hợp.</p>
</c:if>

<!-- ================= TABLE ================= -->

<!-- Chỉ hiển thị khi có dữ liệu -->
<c:if test="${not empty events}">
    <table border="1">
        <tr>
            <th>STT</th>
            <th>Tên</th>
            <th>Ngày</th>
            <th>Giá</th>
            <th>Vé</th>
            <th>Action</th>
        </tr>

        <!-- forEach + varStatus để lấy STT -->
        <c:forEach var="event" items="${events}" varStatus="s">
            <tr>
                <!-- STT -->
                <td>${s.count}</td>

                <!-- Tên sự kiện -->
                <!-- LUÔN dùng c:out để chống XSS -->
                <td><c:out value="${event.name}" /></td>

                <!-- Ngày (đã là String) -->
                <td>${event.date}</td>

                <!-- ================= GIÁ ================= -->
                <!-- dùng choose vì có nhiều điều kiện -->
                <td>
                    <c:choose>
                        <!-- miễn phí -->
                        <c:when test="${event.price == 0}">
                            MIỄN PHÍ
                        </c:when>

                        <!-- có giá -->
                        <c:otherwise>
                            <!-- format số có dấu phân cách -->
                            <fmt:formatNumber value="${event.price}" type="number"/>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- ================= VÉ ================= -->
                <td>
                    <c:choose>
                        <!-- hết vé -->
                        <c:when test="${event.remainingTickets == 0}">
                            <span style="color:red">HẾT VÉ</span>
                        </c:when>

                        <!-- sắp hết -->
                        <c:when test="${event.remainingTickets < 10}">
                            <span style="color:orange">
                                Sắp hết (còn ${event.remainingTickets} vé)
                            </span>
                        </c:when>

                        <!-- còn nhiều -->
                        <c:otherwise>
                            <span style="color:green">
                                    ${event.remainingTickets}
                            </span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <!-- ================= LINK ================= -->
                <td>
                    <c:choose>
                        <!-- disable khi hết vé -->
                        <c:when test="${event.remainingTickets == 0}">
                            <span>Không thể đặt</span>
                        </c:when>

                        <c:otherwise>
                            <!-- c:url để tránh lỗi context path -->
                            <!-- không dùng href="/events/..." -->
                            <a href="<c:url value='/events/${event.id}/book'/>">
                                Đặt vé
                            </a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<hr/>

<!-- ================= FOOTER ================= -->

<!-- phải check tránh lỗi index -->
<c:if test="${not empty events}">
    <p>
        <!-- fn:toUpperCase để viết hoa -->
        Sự kiện đầu:
            ${fn:toUpperCase(events[0].name)}
    </p>
</c:if>

<!-- độ dài keyword -->
<p>
    Độ dài keyword: ${fn:length(keyword)} ký tự
</p>

<!-- ================= GHI CHÚ ================= -->
<!--
1. XSS:
- Input: <script>alert(1)</script>
- Nếu dùng ${keyword} → script chạy
- Nếu dùng <c:out> → hiển thị text → an toàn

    2. c:if vs c:choose:
    - c:if: 1 điều kiện
    - c:choose: nhiều nhánh (if-else-if)
    → dùng c:choose cho giá và vé

    3. c:url:
    - Tự động thêm context path
    - Tránh lỗi khi deploy /ticketing

    4. Không dùng scriptlet:
    - Code sạch
    - Theo chuẩn MVC
    -->