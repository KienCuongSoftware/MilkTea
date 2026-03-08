package beans;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Đơn hàng.
 * status: 0=Chờ order xác nhận, 1=Đã xác nhận (pha chế), 2=Pha chế xong (thu ngân), 3=Đã thanh toán
 */
public class DonHang {
    private int id;
    private Integer maND;
    private String ten;
    private String diachi;
    private String sdt;
    private Date ngaydat;
    private String voucher;
    private BigDecimal tongTien;
    private int status;
    private BigDecimal discountAmount;
    private String discountType;
    private BigDecimal discountValue;
    private List<ChiTietDonHang> chiTiet;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Integer getMaND() { return maND; }
    public void setMaND(Integer maND) { this.maND = maND; }
    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }
    public String getDiachi() { return diachi; }
    public void setDiachi(String diachi) { this.diachi = diachi; }
    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }
    public Date getNgaydat() { return ngaydat; }
    public void setNgaydat(Date ngaydat) { this.ngaydat = ngaydat; }
    public String getVoucher() { return voucher; }
    public void setVoucher(String voucher) { this.voucher = voucher; }
    public BigDecimal getTongTien() { return tongTien; }
    public void setTongTien(BigDecimal tongTien) { this.tongTien = tongTien; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }
    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }
    public BigDecimal getDiscountValue() { return discountValue; }
    public void setDiscountValue(BigDecimal discountValue) { this.discountValue = discountValue; }
    public List<ChiTietDonHang> getChiTiet() { return chiTiet; }
    public void setChiTiet(List<ChiTietDonHang> chiTiet) { this.chiTiet = chiTiet; }

    public String getStatusText() {
        switch (status) {
            case 0: return "Chờ xác nhận";
            case 1: return "Đã xác nhận";
            case 2: return "Pha chế xong";
            case 3: return "Đã thanh toán";
            default: return "—";
        }
    }
}
