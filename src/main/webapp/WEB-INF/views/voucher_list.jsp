<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mã giảm giá - Milk Tea Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .voucher-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            border-left: 4px solid #0984e3;
            transition: transform 0.2s;
        }
        .voucher-card:hover { transform: translateY(-2px); }
        .voucher-card.voucher-expired {
            border-left-color: #adb5bd;
            background: #f8f9fa;
            opacity: 0.85;
        }
        .voucher-card.voucher-expired .voucher-code { color: #6c757d; }
        .voucher-card.voucher-expired .discount-badge { color: #6c757d; }
        .voucher-expired-badge {
            background: #dc3545;
            color: white;
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.25rem 0.5rem;
            border-radius: 6px;
        }
        .voucher-code { font-weight: 700; color: #0984e3; font-size: 1.1rem; }
        .discount-badge { font-weight: 600; color: #00b894; }
    </style>
</head>
<body>
    <jsp:include page="common/navbar.jsp"/>

    <div class="container py-4">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary mb-3">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>
        <h2 class="mb-4"><i class="fas fa-tag me-2"></i>Mã giảm giá</h2>
        <p class="text-muted mb-4">Chọn mã giảm giá khi đặt hàng. Nhập mã tại bước thanh toán.</p>

        <c:choose>
            <c:when test="${empty vouchers}">
                <div class="alert alert-info">Hiện chưa có mã giảm giá nào.</div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach items="${vouchers}" var="v">
                        <c:set var="expired" value="${v.ngayKetThuc != null && v.ngayKetThuc lt now}"/>
                        <div class="col-md-6 col-lg-4">
                            <div class="voucher-card p-4 h-100 ${expired ? 'voucher-expired' : ''}">
                                <div class="d-flex justify-content-between align-items-start mb-2 flex-wrap gap-1">
                                    <span class="voucher-code">${v.ma}</span>
                                    <div class="d-flex align-items-center gap-2">
                                        <c:if test="${expired}">
                                            <span class="voucher-expired-badge">Hết hạn</span>
                                        </c:if>
                                        <c:if test="${v.phanTramGiamGia != null}">
                                            <span class="discount-badge">Giảm ${v.phanTramGiamGia}%</span>
                                        </c:if>
                                        <c:if test="${v.giaTriGiamGia != null}">
                                            <span class="discount-badge">Giảm <fmt:formatNumber value="${v.giaTriGiamGia}" type="number"/>đ</span>
                                        </c:if>
                                    </div>
                                </div>
                                <h6 class="mb-2">${v.ten}</h6>
                                <c:if test="${not empty v.mota}">
                                    <p class="text-muted small mb-2">${v.mota}</p>
                                </c:if>
                                <div class="small ${expired ? 'text-danger' : 'text-secondary'}">
                                    <i class="fas fa-calendar-alt me-1"></i>
                                    <fmt:formatDate value="${v.ngayBatDau}" pattern="dd/MM/yyyy"/> – <fmt:formatDate value="${v.ngayKetThuc}" pattern="dd/MM/yyyy"/>
                                    <c:if test="${expired}"> (đã hết hạn)</c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
