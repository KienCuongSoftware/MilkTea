<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đặt hàng thành công - Milk Tea Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="common/navbar.jsp"/>

    <div class="container py-5">
        <div class="text-center mb-4">
            <i class="fas fa-check-circle text-success" style="font-size: 4rem;"></i>
            <h2 class="mt-3">Đặt hàng thành công!</h2>
            <p class="text-muted">Mã đơn hàng: <strong>#${order.id}</strong>. Đơn sẽ được xác nhận và chế biến sớm.</p>
        </div>
        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/order/bill/${order.id}" target="_blank" class="btn btn-primary btn-lg">
                <i class="fas fa-print me-2"></i>In hóa đơn
            </a>
            <a href="${pageContext.request.contextPath}/product/view" class="btn btn-outline-primary btn-lg">Tiếp tục mua</a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-lg">Về trang chủ</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
