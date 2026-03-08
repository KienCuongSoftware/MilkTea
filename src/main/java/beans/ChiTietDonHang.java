package beans;

import java.math.BigDecimal;

/**
 * Một dòng trong đơn hàng.
 */
public class ChiTietDonHang {
    private int id;
    private int donHang;
    private int sanPham;
    private int size;
    private int soLuong;
    private String tenSP;
    private BigDecimal donGia;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getDonHang() { return donHang; }
    public void setDonHang(int donHang) { this.donHang = donHang; }
    public int getSanPham() { return sanPham; }
    public void setSanPham(int sanPham) { this.sanPham = sanPham; }
    public int getSize() { return size; }
    public void setSize(int size) { this.size = size; }
    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) { this.tenSP = tenSP; }
    public BigDecimal getDonGia() { return donGia; }
    public void setDonGia(BigDecimal donGia) { this.donGia = donGia; }

    public BigDecimal getThanhTien() {
        if (donGia == null) return BigDecimal.ZERO;
        return donGia.multiply(BigDecimal.valueOf(soLuong));
    }
}
