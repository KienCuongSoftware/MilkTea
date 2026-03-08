package beans;

import java.util.Date;

/**
 * Mã giảm giá (chỉ xem / chọn cho khách hàng, không thêm sửa xóa).
 */
public class Voucher {
    private int id;
    private String ma;
    private String ten;
    private String mota;
    private Date ngayBatDau;
    private Date ngayKetThuc;
    private Integer phanTramGiamGia;
    private Integer giaTriGiamGia;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getMa() { return ma; }
    public void setMa(String ma) { this.ma = ma; }
    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }
    public String getMota() { return mota; }
    public void setMota(String mota) { this.mota = mota; }
    public Date getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Date ngayBatDau) { this.ngayBatDau = ngayBatDau; }
    public Date getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(Date ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }
    public Integer getPhanTramGiamGia() { return phanTramGiamGia; }
    public void setPhanTramGiamGia(Integer phanTramGiamGia) { this.phanTramGiamGia = phanTramGiamGia; }
    public Integer getGiaTriGiamGia() { return giaTriGiamGia; }
    public void setGiaTriGiamGia(Integer giaTriGiamGia) { this.giaTriGiamGia = giaTriGiamGia; }
}
