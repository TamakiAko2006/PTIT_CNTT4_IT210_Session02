<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: binh1
  Date: 4/6/2026
  Time: 8:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Danh sách sinh viên</h1>
<%-- Trước khi học JSTL - Java Standard Tag Libariry --%>
<%-- Scriptlet --%>
<%--<ul>--%>
<%--    <%--%>
<%--        List<String> names = (List<String>) request.getAttribute("names");--%>
<%--        if(names != null) {--%>
<%--            for (String s : names) {--%>
<%--    %>--%>
<%--                <li><%= s %></li>--%>
<%--    <%--%>
<%--            }--%>
<%--        }--%>
<%--    %>--%>
<%--</ul>--%>

<ul>
    <c:forEach items="${names}" var="p">

        <c:if test="${p != 'Vũ Việt Tiến'}">
            <li>
                <c:out value="${p}"/>
            </li>
        </c:if>
        <c:if test="${p == 'Vũ Việt Tiến'}">
            <li>
                <c:out value="${p}"/>
            </li>
        </c:if>
    </c:forEach>

    <fmt:formatNumber
            value="${money}"
            currencyCode="currency"
            currencySymbol="VNĐ"
    />

    <table border="1" cellpadding="10" cellspacing="10">
        <thead>
        <tr>
            <th>Name</th>
        </tr>
        </thead>
        <tbody>
        <th
        <c:forEach items="${names}" var="p">
            <tr>
                <td><c:out value="${p}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</ul>


</body>
</html>
