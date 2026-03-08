<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${dashboardTitle} - Milk Tea Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/theme.css" rel="stylesheet">
    <style>
        :root { --card-radius: 14px; --card-shadow: 0 4px 14px rgba(93,64,55,0.08); --card-hover: 0 8px 24px rgba(93,64,55,0.12); }
        body { background: #FAF6F0; font-family: 'Segoe UI', system-ui, sans-serif; }
        .dashboard-header { background: linear-gradient(135deg, #5D4037 0%, #3E2723 100%); color: #FFF8E7; border-radius: var(--card-radius); padding: 1.5rem 1.75rem; margin-bottom: 1.75rem; box-shadow: var(--card-shadow); }
        .dashboard-header h2 { margin: 0; font-weight: 700; font-size: 1.6rem; }
        .stat-card { border: none; border-radius: var(--card-radius); box-shadow: var(--card-shadow); transition: transform 0.2s, box-shadow 0.2s; overflow: hidden; }
        .stat-card:hover { transform: translateY(-4px); box-shadow: var(--card-hover); }
        .stat-card .card-body { padding: 1.35rem; }
        .stat-card .stat-value { font-size: 1.75rem; font-weight: 700; letter-spacing: -0.02em; }
        .stat-card .stat-label { font-size: 0.85rem; opacity: 0.9; }
        .chart-card { border: none; border-radius: var(--card-radius); box-shadow: var(--card-shadow); background: #fff; }
        .chart-card .card-body { padding: 1.5rem; }
        .chart-card .card-title { font-weight: 600; color: #3E2723; margin-bottom: 1rem; }
        .table-dash { border-radius: var(--card-radius); overflow: hidden; box-shadow: var(--card-shadow); }
        .table-dash thead th { background: #5D4037; color: #FFF8E7; font-weight: 600; border: none; padding: 0.85rem 1rem; }
        .table-dash tbody tr:hover { background: #FFF8E7; }
        .section-title { font-weight: 600; color: #3E2723; margin-bottom: 1rem; font-size: 1.05rem; }
    </style>
</head>
<body>
    <jsp:include page="common/navbar.jsp"/>

    <div class="container py-4">
        <div class="dashboard-header">
            <h2><i class="fas fa-tachometer-alt me-2"></i>${dashboardTitle}</h2>
            <p class="mb-0 mt-1 opacity-90 small">Tổng quan hoạt động</p>
        </div>

        <c:choose>
            <%-- Dashboard Admin: tổng quan --%>
            <c:when test="${dashboardRole == 'admin'}">
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-white-50 mb-1">Chờ xác nhận</h6>
                                        <span class="display-6 fw-bold">${orderCountConfirm}</span> đơn
                                    </div>
                                    <i class="fas fa-clock fa-2x opacity-50"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/order/list?tab=confirm" class="text-white small mt-2 d-inline-block">Xem đơn →</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-white-50 mb-1">Đang pha chế</h6>
                                        <span class="display-6 fw-bold">${orderCountBrewing}</span> đơn
                                    </div>
                                    <i class="fas fa-blender fa-2x opacity-50"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/order/list?tab=brewing" class="text-white small mt-2 d-inline-block">Xem đơn →</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-warning text-dark">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-1">Chờ thanh toán</h6>
                                        <span class="display-6 fw-bold">${orderCountPayment}</span> đơn
                                    </div>
                                    <i class="fas fa-cash-register fa-2x opacity-50"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/order/list?tab=payment" class="text-dark small mt-2 d-inline-block">Xem đơn →</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-white-50 mb-1">Đã hoàn thành</h6>
                                        <span class="display-6 fw-bold">${orderCountDone}</span> đơn
                                    </div>
                                    <i class="fas fa-check-circle fa-2x opacity-50"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/order/list?tab=done" class="text-white small mt-2 d-inline-block">Xem đơn →</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-dark text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-white-50 mb-1">Doanh thu (đã TT)</h6>
                                        <span class="display-6 fw-bold"><fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0"/></span>đ
                                    </div>
                                    <i class="fas fa-coins fa-2x opacity-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-secondary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-white-50 mb-1">Sản phẩm</h6>
                                        <span class="display-6 fw-bold">${totalProducts}</span> SP
                                    </div>
                                    <i class="fas fa-mug-hot fa-2x opacity-50"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/product/view" class="text-white small mt-2 d-inline-block">Quản lý SP →</a>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- Biểu đồ: Doanh thu + Đơn hoàn thành --%>
                <div class="row g-4 mb-4">
                    <div class="col-lg-7">
                        <div class="chart-card card">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-chart-line me-2 text-primary"></i>Doanh thu 7 ngày gần nhất (đã thanh toán)</h5>
                                <canvas id="chartRevenue" height="180"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="chart-card card">
                            <div class="card-body">
                                <h5 class="card-title"><i class="fas fa-chart-bar me-2 text-success"></i>Đơn hoàn thành 7 ngày gần nhất</h5>
                                <canvas id="chartCompleted" height="180"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>

            <%-- Dashboard Kho --%>
            <c:when test="${dashboardRole == 'warehouse'}">
                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <div class="card stat-card border-0 bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="stat-label">Tổng sản phẩm</div>
                                        <span class="stat-value">${totalProducts}</span>
                                    </div>
                                    <i class="fas fa-boxes fa-2x opacity-50"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/product/view" class="text-white small mt-2 d-inline-block">Xem sản phẩm →</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card stat-card border-0 ${lowStockCount > 0 ? 'bg-danger' : 'bg-success'} text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="stat-label">Sắp hết hàng (≤10)</div>
                                        <span class="stat-value">${lowStockCount}</span> SP
                                    </div>
                                    <i class="fas fa-exclamation-triangle fa-2x opacity-50"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/warehouse/view" class="text-white small mt-2 d-inline-block">Quản lý kho →</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-4 mb-4">
                    <div class="col-lg-6">
                        <div class="chart-card card">
                            <div class="card-body">
                                <h5 class="section-title"><i class="fas fa-chart-pie me-2"></i>Tồn kho tổng quan</h5>
                                <canvas id="chartWarehouse" height="200"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="chart-card card">
                            <div class="card-body">
                                <h5 class="section-title"><i class="fas fa-list me-2"></i>Bảng sản phẩm sắp hết hàng</h5>
                                <div class="table-responsive">
                                    <table class="table table-dash table-hover mb-0">
                                        <thead><tr><th>Sản phẩm</th><th>Danh mục</th><th>Tồn</th><th></th></tr></thead>
                                        <tbody>
                                            <c:forEach items="${lowStockProducts}" var="p" end="4">
                                                <tr>
                                                    <td>${p.tenSP}</td>
                                                    <td>${p.tenDM}</td>
                                                    <td><span class="badge ${p.soLuong <= 5 ? 'bg-danger' : 'bg-warning'}">${p.soLuong}</span></td>
                                                    <td><a href="${pageContext.request.contextPath}/product/view" class="btn btn-sm btn-outline-primary">Xem</a></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty lowStockProducts}"><tr><td colspan="4" class="text-muted">Không có SP nào sắp hết.</td></tr></c:if>
                                        </tbody>
                                    </table>
                                </div>
                                <a href="${pageContext.request.contextPath}/warehouse/view" class="btn btn-sm btn-primary mt-2">Vào quản lý kho</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>

            <%-- Dashboard Thu ngân --%>
            <c:when test="${dashboardRole == 'cashier'}">
                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-warning text-dark">
                            <div class="card-body">
                                <div class="stat-label">Đơn chờ thanh toán</div>
                                <span class="stat-value">${fn:length(orders)}</span> đơn
                                <br><a href="${pageContext.request.contextPath}/order/list?tab=payment" class="small mt-2 d-inline-block">Xem đơn →</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="chart-card card">
                            <div class="card-body">
                                <h5 class="section-title"><i class="fas fa-chart-bar me-2"></i>Đơn đã thanh toán 7 ngày gần nhất</h5>
                                <canvas id="chartCashier" height="140"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart-card card mb-4">
                    <div class="card-body">
                        <h5 class="section-title"><i class="fas fa-list me-2"></i>Bảng đơn chờ thanh toán</h5>
                        <c:choose>
                            <c:when test="${empty orders}">
                                <p class="text-muted mb-0">Không có đơn nào.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-dash table-hover mb-0">
                                        <thead><tr><th>Mã đơn</th><th>Khách hàng</th><th>SĐT</th><th>Ngày đặt</th><th>Tổng tiền</th><th>Thao tác</th></tr></thead>
                                        <tbody>
                                            <c:forEach items="${orders}" var="o" end="6">
                                                <tr>
                                                    <td>#${o.id}</td>
                                                    <td>${o.ten}</td>
                                                    <td>${o.sdt}</td>
                                                    <td><fmt:formatDate value="${o.ngaydat}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                    <td><fmt:formatNumber value="${o.tongTien}" type="currency" currencySymbol="đ"/></td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/order/bill/${o.id}" target="_blank" class="btn btn-sm btn-outline-secondary me-1">In bill</a>
                                                        <form action="${pageContext.request.contextPath}/order/pay/${o.id}" method="post" class="d-inline">
                                                            <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                                                            <button type="submit" class="btn btn-sm btn-success">Thanh toán</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <a href="${pageContext.request.contextPath}/order/list" class="btn btn-primary mt-2">Xem tất cả đơn</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:when>

            <%-- Dashboard Pha chế --%>
            <c:when test="${dashboardRole == 'brewing'}">
                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-info text-white">
                            <div class="card-body">
                                <div class="stat-label">Đơn cần pha chế</div>
                                <span class="stat-value">${fn:length(orders)}</span> đơn
                                <br><a href="${pageContext.request.contextPath}/order/list?tab=brewing" class="text-white small mt-2 d-inline-block">Xem đơn →</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="chart-card card">
                            <div class="card-body">
                                <h5 class="section-title"><i class="fas fa-chart-bar me-2"></i>Đơn hoàn thành 7 ngày gần nhất</h5>
                                <canvas id="chartBrewing" height="140"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart-card card mb-4">
                    <div class="card-body">
                        <h5 class="section-title"><i class="fas fa-list me-2"></i>Bảng đơn cần pha chế</h5>
                        <c:choose>
                            <c:when test="${empty orders}">
                                <p class="text-muted mb-0">Không có đơn nào.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-dash table-hover mb-0">
                                        <thead><tr><th>Mã đơn</th><th>Khách hàng</th><th>SĐT</th><th>Ngày đặt</th><th>Tổng tiền</th><th>Thao tác</th></tr></thead>
                                        <tbody>
                                            <c:forEach items="${orders}" var="o" end="6">
                                                <tr>
                                                    <td>#${o.id}</td>
                                                    <td>${o.ten}</td>
                                                    <td>${o.sdt}</td>
                                                    <td><fmt:formatDate value="${o.ngaydat}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                    <td><fmt:formatNumber value="${o.tongTien}" type="currency" currencySymbol="đ"/></td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/order/bill/${o.id}" target="_blank" class="btn btn-sm btn-outline-secondary me-1">In bill</a>
                                                        <form action="${pageContext.request.contextPath}/order/brewed/${o.id}" method="post" class="d-inline">
                                                            <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                                                            <button type="submit" class="btn btn-sm btn-info">Pha chế xong</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <a href="${pageContext.request.contextPath}/order/list" class="btn btn-primary mt-2">Xem tất cả đơn</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:when>

            <%-- Dashboard Order --%>
            <c:when test="${dashboardRole == 'order'}">
                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <div class="card stat-card border-0 bg-primary text-white">
                            <div class="card-body">
                                <div class="stat-label">Đơn chờ xác nhận</div>
                                <span class="stat-value">${fn:length(orders)}</span> đơn
                                <br><a href="${pageContext.request.contextPath}/order/list?tab=confirm" class="text-white small mt-2 d-inline-block">Xem đơn →</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="chart-card card">
                            <div class="card-body">
                                <h5 class="section-title"><i class="fas fa-chart-bar me-2"></i>Đơn hoàn thành 7 ngày gần nhất</h5>
                                <canvas id="chartOrder" height="140"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="chart-card card mb-4">
                    <div class="card-body">
                        <h5 class="section-title"><i class="fas fa-list me-2"></i>Bảng đơn chờ xác nhận</h5>
                        <c:choose>
                            <c:when test="${empty orders}">
                                <p class="text-muted mb-0">Không có đơn nào.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-dash table-hover mb-0">
                                        <thead><tr><th>Mã đơn</th><th>Khách hàng</th><th>SĐT</th><th>Ngày đặt</th><th>Tổng tiền</th><th>Thao tác</th></tr></thead>
                                        <tbody>
                                            <c:forEach items="${orders}" var="o" end="6">
                                                <tr>
                                                    <td>#${o.id}</td>
                                                    <td>${o.ten}</td>
                                                    <td>${o.sdt}</td>
                                                    <td><fmt:formatDate value="${o.ngaydat}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                    <td><fmt:formatNumber value="${o.tongTien}" type="currency" currencySymbol="đ"/></td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/order/bill/${o.id}" target="_blank" class="btn btn-sm btn-outline-secondary me-1">In bill</a>
                                                        <form action="${pageContext.request.contextPath}/order/confirm/${o.id}" method="post" class="d-inline">
                                                            <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                                                            <button type="submit" class="btn btn-sm btn-primary">Xác nhận</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <a href="${pageContext.request.contextPath}/order/list" class="btn btn-primary mt-2">Xem tất cả đơn</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <div class="alert alert-secondary">Không xác định dashboard.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

    <c:if test="${dashboardRole == 'admin'}">
    <script>
(function() {
    var revLabels = [<c:forEach items="${revenueLabels}" var="l" varStatus="st">"<c:out value="${l}"/>"<c:if test="${!st.last}">,</c:if></c:forEach>];
    var revData = [<c:forEach items="${revenueData}" var="v" varStatus="st">${v}<c:if test="${!st.last}">,</c:if></c:forEach>];
    var compLabels = [<c:forEach items="${completedLabels}" var="l" varStatus="st">"<c:out value="${l}"/>"<c:if test="${!st.last}">,</c:if></c:forEach>];
    var compData = [<c:forEach items="${completedData}" var="v" varStatus="st">${v}<c:if test="${!st.last}">,</c:if></c:forEach>];
    if (document.getElementById('chartRevenue')) {
        new Chart(document.getElementById('chartRevenue'), {
            type: 'line',
            data: {
                labels: revLabels,
                datasets: [{ label: 'Doanh thu (đ)', data: revData, borderColor: '#667eea', backgroundColor: 'rgba(102,126,234,0.1)', fill: true, tension: 0.3 }]
            },
            options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true } } }
        });
    }
    if (document.getElementById('chartCompleted')) {
        new Chart(document.getElementById('chartCompleted'), {
            type: 'bar',
            data: {
                labels: compLabels,
                datasets: [{ label: 'Đơn hoàn thành', data: compData, backgroundColor: '#198754' }]
            },
            options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } } }
        });
    }
})();
    </script>
    </c:if>

    <c:if test="${dashboardRole == 'warehouse'}">
    <script>
(function() {
    var total = ${totalProducts};
    var low = ${lowStockCount};
    var ok = Math.max(0, total - low);
    if (document.getElementById('chartWarehouse')) {
        new Chart(document.getElementById('chartWarehouse'), {
            type: 'doughnut',
            data: {
                labels: ['Đủ hàng', 'Sắp hết (≤10)'],
                datasets: [{ data: [ok, low], backgroundColor: ['#198754', '#dc3545'] }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
        });
    }
})();
    </script>
    </c:if>

    <c:if test="${dashboardRole == 'cashier' || dashboardRole == 'brewing' || dashboardRole == 'order'}">
    <script>
(function() {
    var el = document.getElementById('chartCashier') || document.getElementById('chartBrewing') || document.getElementById('chartOrder');
    var compLabels = [<c:forEach items="${completedLabels}" var="l" varStatus="st">"<c:out value="${l}"/>"<c:if test="${!st.last}">,</c:if></c:forEach>];
    var compData = [<c:forEach items="${completedData}" var="v" varStatus="st">${v}<c:if test="${!st.last}">,</c:if></c:forEach>];
    if (el) {
        new Chart(el, {
            type: 'bar',
            data: {
                labels: compLabels,
                datasets: [{ label: 'Đơn', data: compData, backgroundColor: '#0dcaf0' }]
            },
            options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } } }
        });
    }
})();
    </script>
    </c:if>
</body>
</html>
