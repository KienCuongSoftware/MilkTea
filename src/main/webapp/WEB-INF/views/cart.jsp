<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Giỏ hàng - Milk Tea Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .cart-card { background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); padding: 1.5rem; margin-bottom: 1rem; }
        .cart-img { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; }
        .cart-total { font-size: 1.25rem; font-weight: 600; color: #0984e3; }
    </style>
</head>
<body>
    <jsp:include page="common/navbar.jsp"/>

    <div class="container py-4">
        <a href="${pageContext.request.contextPath}/product/view" class="btn btn-outline-primary mb-3">
            <i class="fas fa-arrow-left"></i> Tiếp tục mua
        </a>
        <h2 class="mb-4"><i class="fas fa-shopping-cart me-2"></i>Giỏ hàng</h2>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty cart}">
                <div class="cart-card text-center py-5">
                    <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                    <p class="text-muted mb-0">Giỏ hàng trống. Chọn sản phẩm và bấm "Mua" để thêm vào giỏ.</p>
                    <a href="${pageContext.request.contextPath}/product/view" class="btn btn-primary mt-3">Xem sản phẩm</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width:100px">Hình ảnh</th>
                                <th>Sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th style="width:100px"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cart}" var="item">
                                <tr>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/resources/images/${item.hinhAnh}" 
                                             class="cart-img" alt="${item.tenSP}">
                                    </td>
                                    <td>${item.tenSP}</td>
                                    <td><fmt:formatNumber value="${item.donGia}" type="currency" currencySymbol="đ"/></td>
                                    <td>${item.soLuong}</td>
                                    <td><fmt:formatNumber value="${item.thanhTien}" type="currency" currencySymbol="đ"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/cart/remove/${item.maSP}" 
                                           class="btn btn-sm btn-outline-danger" onclick="return confirm('Bỏ sản phẩm khỏi giỏ?');">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="cart-card d-flex justify-content-between align-items-center">
                    <span class="cart-total">Tổng cộng: <fmt:formatNumber value="${tong}" type="currency" currencySymbol="đ"/></span>
                    <span class="text-muted small">Thanh toán sẽ được thêm sau khi có chức năng đặt hàng.</span>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
