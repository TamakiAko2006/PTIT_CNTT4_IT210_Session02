<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<h2>
    Xin chào, ${sessionScope.loggedUser}!
    Vai trò: ${sessionScope.role}
</h2>

<table border="1">
    <tr>
        <th>Mã</th>
        <th>Sản phẩm</th>
        <th>Tổng tiền</th>
        <th>Ngày</th>
    </tr>

    <c:forEach var="o" items="${orders}">
        <tr>
            <td>${o.id}</td>
            <td>${o.name}</td>
            <td>
                <fmt:formatNumber value="${o.price}" type="currency" currencySymbol="₫"/>
            </td>
            <td>
                <fmt:formatDate value="${o.date}" pattern="dd/MM/yyyy"/>
            </td>
        </tr>
    </c:forEach>
</table>

<p>
    Tổng lượt xem: ${applicationScope.totalViewCount}
</p>

<a href="/logout">Đăng xuất</a>