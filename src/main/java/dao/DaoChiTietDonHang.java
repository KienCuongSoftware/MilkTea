package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import beans.ChiTietDonHang;

@Repository
public class DaoChiTietDonHang {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final String INSERT = "INSERT INTO chi_tiet_don_hang (don_hang, san_pham, size, soLuong) VALUES (?, ?, ?, ?)";

    public void save(ChiTietDonHang ct) {
        jdbcTemplate.update(INSERT, ct.getDonHang(), ct.getSanPham(), ct.getSize(), ct.getSoLuong());
    }

    public List<ChiTietDonHang> findByDonHang(int donHangId) {
        String sql = "SELECT c.id, c.don_hang AS donHang, c.san_pham AS sanPham, c.size, c.soLuong, p.TenSP AS tenSP, p.DonGia AS donGia " +
                     "FROM chi_tiet_don_hang c JOIN san_pham p ON c.san_pham = p.MaSP WHERE c.don_hang = ? ORDER BY c.id";
        return jdbcTemplate.query(sql, new RowMapper<ChiTietDonHang>() {
            @Override
            public ChiTietDonHang mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                ChiTietDonHang ct = new ChiTietDonHang();
                ct.setId(rs.getInt("id"));
                ct.setDonHang(rs.getInt("donHang"));
                ct.setSanPham(rs.getInt("sanPham"));
                ct.setSize(rs.getInt("size"));
                ct.setSoLuong(rs.getInt("soLuong"));
                ct.setTenSP(rs.getString("tenSP"));
                ct.setDonGia(rs.getBigDecimal("donGia"));
                return ct;
            }
        }, donHangId);
    }
}
