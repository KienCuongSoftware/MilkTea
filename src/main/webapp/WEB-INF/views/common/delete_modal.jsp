<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%-- Modal Bootstrap xác nhận xóa - dùng chung, chỉ dùng icon Font Awesome --%>
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header border-0 pb-0">
        <h5 class="modal-title" id="deleteConfirmModalLabel">
          <i class="fas fa-exclamation-triangle text-warning me-2"></i>Xác nhận
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body pt-0">
        <p id="deleteConfirmMessage" class="mb-0">Bạn có chắc chắn muốn xóa?</p>
      </div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        <button type="button" class="btn btn-danger" id="deleteConfirmBtn">
          <i class="fas fa-trash me-1"></i>Xóa
        </button>
      </div>
    </div>
  </div>
</div>
<script>
(function() {
  var deleteModalEl = document.getElementById('deleteConfirmModal');
  if (!deleteModalEl) return;
  var deleteModal = new bootstrap.Modal(deleteModalEl);
  var messageEl = document.getElementById('deleteConfirmMessage');
  var confirmBtn = document.getElementById('deleteConfirmBtn');
  var pendingForm = null;
  var pendingHref = null;

  function clearPending() {
    pendingForm = null;
    pendingHref = null;
  }

  document.body.addEventListener('submit', function(e) {
    var form = e.target;
    if (!form.classList.contains('delete-confirm-form')) return;
    e.preventDefault();
    var msg = form.getAttribute('data-delete-message') || 'Bạn có chắc chắn muốn xóa?';
    messageEl.textContent = msg;
    pendingForm = form;
    pendingHref = null;
    deleteModal.show();
  }, true);

  document.body.addEventListener('click', function(e) {
    var link = e.target.closest('.delete-confirm-link');
    if (!link) return;
    e.preventDefault();
    var msg = link.getAttribute('data-delete-message') || 'Bạn có chắc chắn?';
    messageEl.textContent = msg;
    pendingHref = link.getAttribute('href') || link.getAttribute('data-href');
    pendingForm = null;
    deleteModal.show();
  }, true);

  confirmBtn.addEventListener('click', function() {
    if (pendingForm) {
      pendingForm.removeAttribute('data-delete-message');
      pendingForm.submit();
    } else if (pendingHref) {
      window.location.href = pendingHref;
    }
    clearPending();
    deleteModal.hide();
  });

  deleteModalEl.addEventListener('hidden.bs.modal', clearPending);
})();
</script>
