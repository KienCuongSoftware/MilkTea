<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý đơn hàng - Milk Tea Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="common/navbar.jsp"/>

    <div class="container py-4">
        <h2 class="mb-4"><i class="fas fa-clipboard-list me-2"></i>Quản lý đơn hàng</h2>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link ${tab == 'confirm' ? 'active' : ''}" href="${pageContext.request.contextPath}/order/list?tab=confirm">Chờ xác nhận</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${tab == 'brewing' ? 'active' : ''}" href="${pageContext.request.contextPath}/order/list?tab=brewing">Đang pha chế</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${tab == 'payment' ? 'active' : ''}" href="${pageContext.request.contextPath}/order/list?tab=payment">Chờ thanh toán</a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${tab == 'done' ? 'active' : ''}" href="${pageContext.request.contextPath}/order/list?tab=done">Đã hoàn thành</a>
            </li>
        </ul>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="alert alert-info">Không có đơn nào trong mục này.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover bg-white">
                        <thead class="table-light">
                            <tr>
                                <th>Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>SĐT</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="o">
                                <tr>
                                    <td>#${o.id}</td>
                                    <td>${o.ten}</td>
                                    <td>${o.sdt}</td>
                                    <td><fmt:formatDate value="${o.ngaydat}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td><fmt:formatNumber value="${o.tongTien}" type="currency" currencySymbol="đ"/></td>
                                    <td>${o.statusText}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/order/bill/${o.id}" target="_blank" class="btn btn-sm btn-outline-secondary me-1">In bill</a>
                                        <c:if test="${o.status == 0}">
                                            <form action="${pageContext.request.contextPath}/order/confirm/${o.id}" method="post" class="d-inline">
                                                <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                                                <button type="submit" class="btn btn-sm btn-primary">Xác nhận</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${o.status == 1}">
                                            <form action="${pageContext.request.contextPath}/order/brewed/${o.id}" method="post" class="d-inline">
                                                <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                                                <button type="submit" class="btn btn-sm btn-info">Pha chế xong</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${o.status == 2}">
                                            <form action="${pageContext.request.contextPath}/order/pay/${o.id}" method="post" class="d-inline">
                                                <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                                                <button type="submit" class="btn btn-sm btn-success">Thanh toán</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
