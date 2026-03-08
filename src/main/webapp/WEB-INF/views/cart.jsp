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
                <div class="cart-card mb-3" id="cartSummary" data-total="${tong}">
                    <h5 class="mb-3">Tổng đơn hàng</h5>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tổng tạm tính:</span>
                        <span id="subtotalText"><fmt:formatNumber value="${tong}" type="currency" currencySymbol="đ"/></span>
                    </div>
                    <div class="d-flex align-items-center gap-2 mb-2 flex-wrap">
                        <label class="form-label mb-0 me-2">Mã giảm giá:</label>
                        <input type="text" id="voucherInput" class="form-control form-control-sm" style="max-width:180px" placeholder="VD: NEWCUST10" name="voucher">
                        <button type="button" id="btnApplyVoucher" class="btn btn-outline-primary btn-sm">Áp dụng</button>
                        <span id="voucherMessage" class="small text-success"></span>
                        <span id="voucherError" class="small text-danger"></span>
                    </div>
                    <div id="discountRow" class="d-flex justify-content-between mb-2 d-none">
                        <span class="text-success">Giảm giá:</span>
                        <span id="discountText" class="text-success fw-bold">-0đ</span>
                    </div>
                    <hr class="my-2">
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="fw-bold">Tổng thanh toán:</span>
                        <span id="totalAfterText" class="cart-total"><fmt:formatNumber value="${tong}" type="currency" currencySymbol="đ"/></span>
                    </div>
                </div>
                <div class="cart-card">
                    <h5 class="mb-3">Thông tin giao hàng / thanh toán</h5>
                    <form action="${pageContext.request.contextPath}/cart/checkout" method="post" id="checkoutForm">
                        <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Họ tên <span class="text-danger">*</span></label>
                                <input type="text" name="ten" class="form-control" required value="${loggedInUser.hoTen}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="text" name="sdt" class="form-control" required value="${loggedInUser.soDienThoai}">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                <input type="text" name="diachi" class="form-control" required value="${loggedInUser.diaChi}">
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="fas fa-check me-2"></i>Thanh toán đơn hàng
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    (function() {
        var summary = document.getElementById('cartSummary');
        if (!summary) return;
        var total = parseFloat(summary.getAttribute('data-total')) || 0;
        var voucherInput = document.getElementById('voucherInput');
        var btnApply = document.getElementById('btnApplyVoucher');
        var discountRow = document.getElementById('discountRow');
        var discountText = document.getElementById('discountText');
        var totalAfterText = document.getElementById('totalAfterText');
        var voucherMessage = document.getElementById('voucherMessage');
        var voucherError = document.getElementById('voucherError');

        function formatVnd(n) {
            if (isNaN(n)) return '0đ';
            return new Intl.NumberFormat('vi-VN', { style: 'decimal', maximumFractionDigits: 0 }).format(n) + 'đ';
        }

        function resetVoucherUI() {
            discountRow.classList.add('d-none');
            totalAfterText.textContent = formatVnd(total);
            voucherMessage.textContent = '';
            voucherError.textContent = '';
        }

        if (btnApply) {
            btnApply.addEventListener('click', function() {
                var code = (voucherInput && voucherInput.value) ? voucherInput.value.trim() : '';
                voucherMessage.textContent = '';
                voucherError.textContent = '';
                if (!code) {
                    voucherError.textContent = 'Vui lòng nhập mã giảm giá.';
                    resetVoucherUI();
                    return;
                }
                var url = '${pageContext.request.contextPath}/cart/voucher/apply?code=' + encodeURIComponent(code) + '&total=' + total;
                var xhr = new XMLHttpRequest();
                xhr.open('GET', url);
                xhr.onload = function() {
                    if (xhr.status !== 200) {
                        voucherError.textContent = 'Không thể kiểm tra mã.';
                        resetVoucherUI();
                        return;
                    }
                    try {
                        var r = JSON.parse(xhr.responseText);
                        if (r.valid) {
                            voucherError.textContent = '';
                            voucherMessage.textContent = r.message || '';
                            discountText.textContent = '-' + formatVnd(r.discountAmount);
                            discountRow.classList.remove('d-none');
                            totalAfterText.textContent = formatVnd(r.totalAfter);
                        } else {
                            voucherMessage.textContent = '';
                            voucherError.textContent = r.message || 'Mã không hợp lệ.';
                            resetVoucherUI();
                        }
                    } catch (e) {
                        voucherError.textContent = 'Lỗi xử lý.';
                        resetVoucherUI();
                    }
                };
                xhr.onerror = function() { voucherError.textContent = 'Lỗi kết nối.'; resetVoucherUI(); };
                xhr.send();
            });
        }
    })();
    </script>
</body>
</html>
