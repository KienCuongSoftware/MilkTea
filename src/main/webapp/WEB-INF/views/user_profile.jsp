<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thông tin cá nhân - Milk Tea Shop</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background-color: #f8f9fa;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      .navbar {
        background-color: #ffffff;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 0.8rem 1rem;
      }
      .profile-container {
        max-width: 800px;
        margin: 40px auto;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      }
      .avatar-container {
        text-align: center;
        margin-bottom: 30px;
      }
      .avatar-preview {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        margin-bottom: 15px;
        border: 3px solid #007bff;
        background-color: #f8f9fa;
      }
      .upload-btn-wrapper {
        position: relative;
        overflow: hidden;
        display: inline-block;
      }
      .upload-btn {
        border: 2px solid #007bff;
        color: #007bff;
        background-color: white;
        padding: 8px 20px;
        border-radius: 8px;
        font-weight: bold;
        cursor: pointer;
      }
      .upload-btn:hover {
        background-color: #007bff;
        color: white;
      }
      .upload-btn-wrapper input[type="file"] {
        font-size: 100px;
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        cursor: pointer;
      }
      .form-group {
        margin-bottom: 20px;
      }
      .alert {
        margin-bottom: 20px;
      }
    </style>
  </head>
  <body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light sticky-top">
      <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
          <i class="fas fa-mug-hot"></i> Milk Tea Shop
        </a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav me-auto">
            <li class="nav-item">
              <a
                class="nav-link"
                href="${pageContext.request.contextPath}/product/view"
              >
                <i class="fas fa-box"></i> Quản lý sản phẩm
              </a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="${pageContext.request.contextPath}/category/view"
              >
                <i class="fas fa-folder"></i> Quản lý danh mục
              </a>
            </li>
          </ul>
          <div class="nav-item dropdown">
            <a
			  class="nav-link dropdown-toggle d-flex align-items-center"
			  href="#"
			  id="userDropdown"
			  role="button"
			  data-bs-toggle="dropdown"
			  aria-expanded="false"
			>
			  <span class="user-avatar me-2">
			    <i class="fas fa-user-circle"></i>
			  </span>
			  <span>${loggedInUser.hoTen}</span>
			</a>
            <ul
              class="dropdown-menu dropdown-menu-end"
              aria-labelledby="userDropdown"
            >
              <li>
                <a
                  class="dropdown-item active"
                  href="${pageContext.request.contextPath}/user/profile"
                >
                  <i class="fas fa-user-cog me-2"></i>Quản lý tài khoản
                </a>
              </li>
              <li><hr class="dropdown-divider" /></li>
              <li>
                <a
                  class="dropdown-item text-danger"
                  href="${pageContext.request.contextPath}/logout"
                >
                  <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </nav>

    <div class="profile-container">
      <h2 class="text-center mb-4">Thông tin cá nhân</h2>

      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>
      <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
      </c:if>

      <div class="avatar-container">
        <img
          src="${empty loggedInUser.anhDaiDien ? pageContext.request.contextPath.concat('/resources/images/default-avatar.png') : pageContext.request.contextPath.concat(loggedInUser.anhDaiDien)}"
          alt="Avatar"
          class="avatar-preview"
          id="avatarPreview"
        />

        <form
          action="${pageContext.request.contextPath}/user/upload-avatar"
          method="post"
          enctype="multipart/form-data"
          id="avatarForm"
        >
          <div class="upload-btn-wrapper">
            <button class="upload-btn" type="button">
              <i class="fas fa-camera"></i> Chọn ảnh
            </button>
            <input
              type="file"
              name="avatar"
              accept="image/*"
              onchange="previewImage(this); submitForm();"
            />
          </div>
        </form>
      </div>

      <form
        action="${pageContext.request.contextPath}/user/update"
        method="post"
        class="needs-validation"
        novalidate
      >
        <div class="form-group">
          <label for="hoTen">Họ và tên:</label>
          <input
            type="text"
            class="form-control"
            id="hoTen"
            name="hoTen"
            value="${loggedInUser.hoTen}"
            required
          />
        </div>

        <div class="form-group">
          <label for="email">Email:</label>
          <input
            type="email"
            class="form-control"
            id="email"
            name="email"
            value="${loggedInUser.email}"
            required
          />
        </div>

        <div class="form-group">
          <label for="soDienThoai">Số điện thoại:</label>
          <input
            type="tel"
            class="form-control"
            id="soDienThoai"
            name="soDienThoai"
            value="${loggedInUser.soDienThoai}"
            required
          />
        </div>

        <div class="form-group">
          <label for="diaChi">Địa chỉ:</label>
          <textarea
            class="form-control"
            id="diaChi"
            name="diaChi"
            rows="3"
            required
          >
${loggedInUser.diaChi}</textarea
          >
        </div>

        <div class="text-center">
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-save"></i> Lưu thay đổi
          </button>
        </div>
      </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      function previewImage(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
            document.getElementById("avatarPreview").src = e.target.result;
          };
          reader.readAsDataURL(input.files[0]);
        }
      }

      function submitForm() {
        document.getElementById("avatarForm").submit();
      }

      // Form validation
      (function () {
        "use strict";
        var forms = document.querySelectorAll(".needs-validation");
        Array.prototype.slice.call(forms).forEach(function (form) {
          form.addEventListener(
            "submit",
            function (event) {
              if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
              }
              form.classList.add("was-validated");
            },
            false
          );
        });
      })();
    </script>
  </body>
</html>
