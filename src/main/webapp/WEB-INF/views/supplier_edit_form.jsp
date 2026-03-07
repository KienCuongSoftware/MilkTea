<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chỉnh sửa nhà cung cấp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            margin: 50px auto;
            max-width: 600px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            background-color: #007bff;
            color: white;
        }
        .form-control, .btn {
            border-radius: 8px;
        }
        .btn {
            padding: 12px 20px;
            font-size: 16px;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .form-actions {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .form-actions .btn {
            width: 48%;
        }
        /* CSS cho input file */
        .custom-file-input::-webkit-file-upload-button {
            visibility: hidden;
            display: none;
        }
        .custom-file-input::before {
            content: 'Chọn ảnh';
            display: inline-block;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 8px 16px;
            outline: none;
            white-space: nowrap;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
        }
        .custom-file-input:hover::before {
            background: linear-gradient(135deg, #0056b3, #004094);
        }
        .custom-file-input:active::before {
            background: linear-gradient(135deg, #004094, #003075);
        }
        .alert {
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .invalid-feedback {
            display: block;
        }
    </style>
</head>
<body>
    <div class="container">
      <div class="form-container">
        <h2 class="text-center text-primary mb-4">Chỉnh sửa nhà cung cấp</h2>

        <c:if test="${not empty error}">
          <div
            class="alert alert-danger alert-dismissible fade show"
            role="alert"
          >
            ${error}
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="alert"
              aria-label="Close"
            ></button>
          </div>
        </c:if>

        <c:if test="${not empty success}">
          <div
            class="alert alert-success alert-dismissible fade show"
            role="alert"
          >
            ${success}
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="alert"
              aria-label="Close"
            ></button>
          </div>
        </c:if>

        <form:form
          method="post"
          action="${pageContext.request.contextPath}/supplier/edit/${supplier.code}"
          modelAttribute="supplier"
          enctype="multipart/form-data"
          accept-charset="UTF-8"
        >
          <div class="mb-3">
            <label for="name" class="form-label">Tên nhà cung cấp:</label>
            <form:input
              path="name"
              class="form-control"
              required="required"
              placeholder="Nhập tên nhà cung cấp"
            />
          </div>

          <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ:</label>
            <form:input
              path="address"
              class="form-control"
              required="required"
              placeholder="Nhập địa chỉ"
            />
          </div>
          
          <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại:</label>
            <form:input
              path="phone"
              class="form-control"
              required="required"
              type="tel"
              placeholder="Nhập số điện thoại"
            />
          </div>

          <button type="submit" class="btn btn-success">Lưu</button>
        </form:form>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Cập nhật trạng thái ngay khi trang load
        window.onload = function() {
            updateStatus();
        }

        function validatePrice(input) {
            if (input.value > 999999) {
                input.value = 999999;
                input.classList.add('is-invalid');
                input.nextElementSibling.textContent = 'Giá sản phẩm không thể vượt quá 999,999';
            } else {
                input.classList.remove('is-invalid');
                input.nextElementSibling.textContent = '';
            }
        }

        function updateStatus() {
            const soLuong = parseInt(document.getElementById('soLuong').value) || 0;
            const trangThai = document.getElementById('trangThai');
            trangThai.value = soLuong > 0 ? 'true' : 'false';
        }

        function validateBeforeSubmit() {
            updateStatus(); // Cập nhật trạng thái một lần nữa trước khi submit
            return true;
        }
    </script>
</body>
</html>
