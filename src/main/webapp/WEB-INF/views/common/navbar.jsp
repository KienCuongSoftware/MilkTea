<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.1); padding: 0.8rem 1rem;">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/" style="font-size: 1.5rem; font-weight: 600; color: #2d3436;">
            <i class="fas fa-mug-hot" style="color: #0984e3; margin-right: 0.5rem;"></i> Milk Tea Shop
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <c:if test="${not empty loggedInUser}">
                    <%-- Trang chủ + Sản phẩm: cho mọi role (order, thu ngân, pha chế, khách hàng dùng chung) --%>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/product/view">
                            <i class="fas fa-mug-hot"></i> Sản phẩm
                        </a>
                    </li>
                    <c:if test="${permission == 'quản lý' || permission == 'chủ quán'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/category/view">
                                <i class="fas fa-folder"></i> Quản lý danh mục
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/user/view">
                                <i class="fas fa-user-friends"></i> Quản lý nhân viên
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/supplier/view">
                                <i class="fas fa-truck"></i> Quản lý nhà cung cấp
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${permission == 'nhân viên kho'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/warehouse/view">
                                <i class="fas fa-warehouse"></i> Quản lý kho
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${permission == 'nhân viên order'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                <i class="fas fa-clipboard-list"></i> Đơn hàng
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${permission == 'nhân viên thu ngân'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                <i class="fas fa-cash-register"></i> Thu ngân
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${permission == 'nhân viên pha chế'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                <i class="fas fa-blender"></i> Đơn cần pha
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${permission == 'khách hàng'}">
                        <c:set var="cartCount" value="0"/>
                        <c:forEach items="${sessionScope.cart}" var="cartItem">
                            <c:set var="cartCount" value="${cartCount + cartItem.soLuong}"/>
                        </c:forEach>
                        <li class="nav-item">
                            <a class="nav-link d-inline-flex align-items-center" href="${pageContext.request.contextPath}/cart">
                                <span class="position-relative">
                                    <i class="fas fa-shopping-cart"></i>
                                    <c:if test="${cartCount > 0}">
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.65rem; min-width: 1.1em;"><c:out value="${cartCount}"/></span>
                                    </c:if>
                                </span>
                                <span class="ms-1">Giỏ hàng</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/voucher/list">
                                <i class="fas fa-tag"></i> Mã giảm giá
                            </a>
                        </li>
                    </c:if>
                </c:if>
            </ul>
            <c:choose>
                <c:when test="${empty loggedInUser}">
                    <div class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <span class="user-avatar me-2"><i class="fas fa-user-circle"></i></span>
                            <span>${loggedInUser.hoTen}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">
                                    <i class="fas fa-user-cog me-2"></i>Quản lý tài khoản
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
