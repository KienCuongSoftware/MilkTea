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
    </style>
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="common/navbar.jsp"/>

    <div class="container mt-4">
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary mb-4">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>

        <div class="row">
            <!-- Hình ảnh sản phẩm -->
            <div class="col-md-5">
                <img src="${pageContext.request.contextPath}/resources/images/${product.hinhAnh}" 
                     class="product-image" alt="${product.tenSP}">
            </div>

            <!-- Thông tin sản phẩm -->
            <div class="col-md-7">
                <div class="product-info">
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

                    <!-- Admin buttons -->
                    <div class="mt-4">
                        <button class="btn btn-primary" type="button" data-bs-toggle="collapse" 
                                data-bs-target="#editForm">
                            <i class="fas fa-edit me-1"></i> Chỉnh sửa thông tin chi tiết
                        </button>
                        <a href="${pageContext.request.contextPath}/product/edit/${product.maSP}" 
                           class="btn btn-warning ms-2">
                            <i class="fas fa-pencil-alt me-1"></i> Sửa sản phẩm
                        </a>
                        <a href="${pageContext.request.contextPath}/product/delete/${product.maSP}" 
                           class="btn btn-danger ms-2"
                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                            <i class="fas fa-trash me-1"></i> Xóa
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Form chỉnh sửa chi tiết (ẩn) -->
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
                                <a href="${pageContext.request.contextPath}/product/detail/delete/${product.maSP}" 
                                   class="btn btn-danger ms-2"
                                   onclick="return confirm('Bạn có chắc muốn xóa chi tiết sản phẩm này?')">
                                    <i class="fas fa-trash me-1"></i> Xóa chi tiết
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
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
</body>
</html> 