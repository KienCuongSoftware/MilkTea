<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn #${order.id} - Milk Tea Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        @media print {
            body { -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .no-print { display: none !important; }
        }
        .bill { max-width: 400px; margin: 0 auto; font-size: 14px; }
        .bill-header { text-align: center; border-bottom: 2px dashed #333; padding-bottom: 1rem; margin-bottom: 1rem; }
        .bill-table { width: 100%; }
        .bill-table th, .bill-table td { padding: 0.35rem 0; border-bottom: 1px dotted #ccc; }
        .bill-total { font-weight: 700; font-size: 1.1rem; margin-top: 0.5rem; }
    </style>
</head>
<body class="bg-light py-4">
    <div class="no-print text-center mb-3">
        <button onclick="window.print();" class="btn btn-primary"><i class="fas fa-print me-1"></i>In</button>
        <a href="${pageContext.request.contextPath}/order/success/${order.id}" class="btn btn-outline-secondary">Đóng</a>
    </div>

    <div class="bill bg-white p-4 shadow-sm">
        <div class="bill-header">
            <h4 class="mb-0">Milk Tea Shop</h4>
            <small class="text-muted">Hóa đơn bán hàng</small>
        </div>
        <p class="mb-1"><strong>Mã đơn:</strong> #${order.id}</p>
        <p class="mb-1"><strong>Ngày:</strong> <fmt:formatDate value="${order.ngaydat}" pattern="dd/MM/yyyy HH:mm"/></p>
        <p class="mb-1"><strong>Khách hàng:</strong> ${order.ten}</p>
        <p class="mb-1"><strong>Điện thoại:</strong> ${order.sdt}</p>
        <p class="mb-2"><strong>Địa chỉ:</strong> ${order.diachi}</p>

        <table class="bill-table">
            <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th class="text-end">SL</th>
                    <th class="text-end">Đơn giá</th>
                    <th class="text-end">Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${order.chiTiet}" var="ct">
                    <tr>
                        <td>${ct.tenSP}</td>
                        <td class="text-end">${ct.soLuong}</td>
                        <td class="text-end"><fmt:formatNumber value="${ct.donGia}" type="number"/></td>
                        <td class="text-end"><fmt:formatNumber value="${ct.thanhTien}" type="number"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="bill-total text-end">
            Tổng cộng: <fmt:formatNumber value="${order.tongTien}" type="currency" currencySymbol="đ"/>
        </div>
        <c:if test="${not empty order.voucher}">
            <p class="mb-0 mt-1 small text-muted">Voucher: ${order.voucher}</p>
        </c:if>
        <p class="text-center mt-4 small text-muted">Cảm ơn quý khách!</p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</body>
</html>
