<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${product.tenSP} - Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .product-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .product-info {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            min-height: 100%;
        }
        .price {
            font-size: 1.8rem;
            color: #28a745;
            font-weight: bold;
        }
        .status-badge {
            font-size: 1.1em;
            padding: 8px 15px;
            border-radius: 20px;
            margin: 10px 0;
            display: inline-block;
        }
        .description {
            margin: 20px 0;
            line-height: 1.6;
        }
        .category-badge {
            background-color: #e9ecef;
            color: #495057;
            padding: 5px 15px;
            border-radius: 15px;
            display: inline-block;
            margin: 10px 0;
        }
        .back-button {
            margin-bottom: 20px;
        }
        .related-products {
            margin-top: 50px;
        }
        .related-product-card {
            transition: transform 0.3s;
            margin-bottom: 20px;
        }
        .related-product-card:hover {
            transform: translateY(-5px);
        }
        .detail-section {
            margin-top: 15px;
            padding: 15px;
            border-left: 4px solid #3498db;
            background: #f8f9fa;
            margin-bottom: 15px;
        }
        .detail-section h5 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 1.1rem;
        }
        .detail-content {
            background: white;
            padding: 12px;
            border-radius: 5px;
            border-left: 4px solid #3498db;
        }
        .related-product {
            transition: transform 0.3s;
        }
        .related-product:hover {
            transform: translateY(-5px);
        }
        .related-image {
            height: 200px;
            object-fit: cover;
        }
        .rating-section, .comments-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 24px;
        }
        .rating-bar-fill {
            background: #0d6efd;
            height: 8px;
            border-radius: 4px;
            min-width: 2%;
        }
        .rating-bar-bg {
            background: #e9ecef;
            border-radius: 4px;
            overflow: hidden;
        }
        .star-rating { color: #ffc107; }
        .comment-item { border-left: 3px solid #0d6efd; padding-left: 12px; margin-bottom: 16px; }
        .btn-review-comment {
            padding: 0.55rem 1.5rem;
            font-size: 1rem;
            border-radius: 0.5rem;
            min-width: 160px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="common/navbar.jsp"/>

    <div class="container mt-4">
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary mb-4">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>

        <div class="row align-items-stretch">
            <!-- Hình ảnh sản phẩm + Đánh giá -->
            <div class="col-md-5 d-flex flex-column">
                <img src="${pageContext.request.contextPath}/resources/images/${product.hinhAnh}" 
                     class="product-image align-self-start" alt="${product.tenSP}">

                <!-- Điểm xếp hạng và bài đánh giá (dưới ảnh, ngang hàng với chi tiết bên phải) -->
                <div class="rating-section mt-4 flex-grow-1 d-flex flex-column">
                    <h5 class="mb-3"><i class="fas fa-star me-2"></i>Điểm xếp hạng và bài đánh giá</h5>
                    <p class="text-muted small mb-3">Điểm xếp hạng đã được xác minh từ người dùng.</p>
                    <div class="row align-items-center">
                        <div class="col-md-4 text-center mb-3 mb-md-0">
                            <c:set var="avg" value="${avgRating != null ? avgRating : 0}"/>
                            <div class="display-4 fw-bold text-primary">${avg}</div>
                            <div class="star-rating mb-1">
                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= avg}"><i class="fas fa-star"></i></c:when>
                                        <c:when test="${i - 1 < avg}"><i class="fas fa-star-half-alt"></i></c:when>
                                        <c:otherwise><i class="far fa-star text-secondary"></i></c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <div class="text-muted small">${totalRatings} đánh giá</div>
                        </div>
                        <div class="col-md-8">
                            <c:forEach begin="1" end="5" var="idx">
                                <c:set var="star" value="${6 - idx}"/>
                                <c:set var="cnt" value="${ratingCounts[star]}"/>
                                <c:set var="pct" value="${totalRatings > 0 ? (cnt * 100 / totalRatings) : 0}"/>
                                <div class="d-flex align-items-center mb-2">
                                    <span class="me-2" style="width:20px">${star}</span>
                                    <i class="fas fa-star text-warning me-2"></i>
                                    <div class="flex-grow-1 rating-bar-bg" style="height:8px">
                                        <div class="rating-bar-fill" data-width="${pct}"></div>
                                    </div>
                                    <span class="ms-2 small text-muted">${cnt}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <c:if test="${not empty loggedInUser}">
                        <form action="${pageContext.request.contextPath}/product/detail/${product.maSP}/review" method="post" class="mt-4 pt-3 border-top">
                            <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                            <label class="form-label">Gửi đánh giá của bạn</label>
                            <div class="d-flex flex-wrap align-items-center gap-2 mb-2">
                                <select name="diem" class="form-select form-select-sm" style="width:auto" required>
                                    <option value="5">5 sao</option>
                                    <option value="4">4 sao</option>
                                    <option value="3">3 sao</option>
                                    <option value="2">2 sao</option>
                                    <option value="1">1 sao</option>
                                </select>
                                <input type="text" name="noiDung" class="form-control flex-grow-1" style="max-width:300px" placeholder="Nội dung (tùy chọn)">
                                <button type="submit" class="btn btn-primary btn-review-comment">Gửi đánh giá</button>
                            </div>
                        </form>
                    </c:if>
                </div>
            </div>

            <!-- Thông tin sản phẩm (cột phải cao bằng cột trái: ảnh + đánh giá) -->
            <div class="col-md-7 d-flex flex-column">
                <div class="product-info flex-grow-1">
                    <h2 class="mb-3">${product.tenSP}</h2>
                    <p class="text-muted mb-2">Danh mục: ${product.tenDM}</p>
                    
                    <div class="price mb-3">
                        <fmt:formatNumber value="${product.donGia}" type="currency" currencySymbol="đ"/>
                    </div>

                    <div class="mb-3">
                        <span class="badge ${product.trangThai ? 'bg-success' : 'bg-danger'} p-2">
                            <i class="fas ${product.trangThai ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                            ${product.trangThai ? 'Còn hàng' : 'Hết hàng'}
                        </span>
                    </div>

                    <div class="detail-section">
                        <h5><i class="fas fa-info-circle me-2"></i>Mô tả sản phẩm</h5>
                        <p class="mb-0">${product.moTa}</p>
                    </div>

                    <c:if test="${not empty detail}">
                        <div class="detail-section">
                            <h5><i class="fas fa-leaf me-2"></i>Nguyên liệu</h5>
                            <p class="mb-0">${detail.nguyenLieu}</p>
                        </div>

                        <div class="detail-section">
                            <h5><i class="fas fa-book me-2"></i>Hướng dẫn sử dụng</h5>
                            <p class="mb-0">${detail.huongDanSuDung}</p>
                        </div>

                        <div class="detail-section">
                            <h5><i class="fas fa-heart me-2"></i>Lợi ích</h5>
                            <p class="mb-0">${detail.loiIch}</p>
                        </div>

                        <div class="detail-section">
                            <h5><i class="fas fa-sticky-note me-2"></i>Ghi chú</h5>
                            <p class="mb-0">${detail.ghiChu}</p>
                        </div>
                    </c:if>

                    <!-- Chỉ quản lý / chủ quán mới thấy nút sửa-xóa -->
                    <c:if test="${permission == 'quản lý' || permission == 'chủ quán'}">
                    <div class="mt-4">
                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" 
                                data-bs-target="#editForm">
                            <i class="fas fa-edit me-1"></i> Chỉnh sửa thông tin chi tiết
                        </button>
                        <a href="${pageContext.request.contextPath}/product/edit/${product.maSP}" 
                           class="btn btn-warning ms-2">
                            <i class="fas fa-pencil-alt me-1"></i> Sửa sản phẩm
                        </a>
                        <form action="${pageContext.request.contextPath}/product/delete/${product.maSP}" method="post" class="d-inline ms-2 delete-confirm-form" data-delete-message="Bạn có chắc muốn xóa sản phẩm này?">
                            <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                            <button type="submit" class="btn btn-danger">
                                <i class="fas fa-trash me-1"></i> Xóa
                            </button>
                        </form>
                    </div>
                    </c:if>
                    <c:if test="${(permission != 'quản lý' && permission != 'chủ quán') && product.soLuong > 0}">
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/cart/add/${product.maSP}?from=detail" class="btn btn-success">
                                <i class="fas fa-shopping-cart me-1"></i> Thêm vào giỏ
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Form chỉnh sửa chi tiết (chỉ quản lý / chủ quán) -->
        <c:if test="${permission == 'quản lý' || permission == 'chủ quán'}">
        <div class="collapse mt-4" id="editForm">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title mb-3">Chỉnh sửa thông tin chi tiết</h5>
                    <form action="${pageContext.request.contextPath}/product/detail/save" method="post">
                        <input type="hidden" name="maSP" value="${product.maSP}">
                        <input type="hidden" name="maCTSP" value="${detail.maCTSP}">
                        
                        <div class="mb-3">
                            <label for="nguyenLieu" class="form-label">Nguyên liệu:</label>
                            <textarea name="nguyenLieu" id="nguyenLieu" 
                                      class="form-control" rows="3">${detail.nguyenLieu}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="huongDanSuDung" class="form-label">Hướng dẫn sử dụng:</label>
                            <textarea name="huongDanSuDung" id="huongDanSuDung" 
                                      class="form-control" rows="3">${detail.huongDanSuDung}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="loiIch" class="form-label">Lợi ích:</label>
                            <textarea name="loiIch" id="loiIch" 
                                      class="form-control" rows="3">${detail.loiIch}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="ghiChu" class="form-label">Ghi chú:</label>
                            <textarea name="ghiChu" id="ghiChu" 
                                      class="form-control" rows="3">${detail.ghiChu}</textarea>
                        </div>
                        
                        <div class="mb-3">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save me-1"></i> Lưu thay đổi
                            </button>
                            <c:if test="${not empty detail.maCTSP}">
                                <form action="${pageContext.request.contextPath}/product/detail/delete/${product.maSP}" method="post" class="d-inline ms-2 delete-confirm-form" data-delete-message="Bạn có chắc muốn xóa chi tiết sản phẩm này?">
                                    <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash me-1"></i> Xóa chi tiết
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        </c:if>

        <!-- Bình luận (trên phần sản phẩm liên quan) -->
        <div class="comments-section">
            <h5 class="mb-3"><i class="fas fa-comments me-2"></i>Bình luận</h5>
            <c:if test="${not empty loggedInUser}">
                <form action="${pageContext.request.contextPath}/product/detail/${product.maSP}/comment" method="post" class="mb-4">
                    <input type="hidden" name="csrfToken" value="${csrfToken}"/>
                    <div class="mb-2">
                        <label class="form-label">Viết bình luận</label>
                        <textarea name="noiDung" class="form-control" rows="2" placeholder="Chia sẻ cảm nhận của bạn..." required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary btn-review-comment">Gửi bình luận</button>
                </form>
            </c:if>
            <c:choose>
                <c:when test="${empty comments}">
                    <p class="text-muted mb-0">Chưa có bình luận nào. Hãy là người đầu tiên bình luận!</p>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${comments}" var="c">
                        <div class="comment-item">
                            <strong>${c.hoTen}</strong>
                            <span class="text-muted small ms-2"><fmt:formatDate value="${c.ngayTao}" pattern="dd/MM/yyyy HH:mm"/></span>
                            <p class="mb-0 mt-1">${c.noiDung}</p>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Sản phẩm liên quan -->
        <div class="related-products mt-5">
            <h3 class="mb-4">Sản phẩm liên quan</h3>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                <c:forEach var="relatedProduct" items="${relatedProducts}">
                    <div class="col">
                        <div class="card h-100 related-product">
                            <img src="${pageContext.request.contextPath}/resources/images/${relatedProduct.hinhAnh}" 
                                 class="card-img-top related-image" alt="${relatedProduct.tenSP}">
                            <div class="card-body">
                                <h5 class="card-title">${relatedProduct.tenSP}</h5>
                                <p class="text-success fw-bold">
                                    <fmt:formatNumber value="${relatedProduct.donGia}" type="currency" currencySymbol="đ"/>
                                </p>
                                <a href="${pageContext.request.contextPath}/product/detail/${relatedProduct.maSP}" 
                                   class="btn btn-outline-primary w-100">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty success}">
            <div class="alert alert-success mt-3">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3">${error}</div>
        </c:if>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Milk Tea Shop</h5>
                    <p>Địa chỉ: Đường Xuân Thủy, quận Cầu Giấy, thành phố Hà Nội<br>
                       Điện thoại: (+84) 369702376<br>
                       Email: trankiencuong30072003@gmail.com</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h5>Theo dõi chúng tôi</h5>
                    <div class="social-links">
                        <a href="https://www.facebook.com/KienCuong2003" target="_blank" class="text-light me-3"><i class="fab fa-facebook"></i></a>
                        <a href="https://www.instagram.com/kiencuong2003/" target="_blank" class="text-light me-3"><i class="fab fa-instagram"></i></a>
                        <a href="https://x.com/TranKienCuong03" target="_blank" class="text-light"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
            <div class="text-center mt-3">
                <small>&copy; 2025 Milk Tea Shop. All rights reserved.</small>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.querySelectorAll('.rating-bar-fill[data-width]').forEach(function(el){ el.style.width = (el.getAttribute('data-width') || 0) + '%'; });
    </script>
    <jsp:include page="common/delete_modal.jsp"/>
</body>
</html> 