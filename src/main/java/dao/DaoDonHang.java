package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import beans.DonHang;

@Repository
public class DaoDonHang {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final String INSERT = "INSERT INTO don_hang (MaND, ten, diachi, sdt, ngaydat, voucher, tongTien, status, discount_amount, discount_type, discount_value) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    public int save(DonHang dh) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(con -> {
            var ps = con.prepareStatement(INSERT, new String[] { "id" });
            ps.setObject(1, dh.getMaND());
            ps.setString(2, dh.getTen());
            ps.setString(3, dh.getDiachi());
            ps.setString(4, dh.getSdt());
            ps.setTimestamp(5, dh.getNgaydat() != null ? new Timestamp(dh.getNgaydat().getTime()) : null);
            ps.setString(6, dh.getVoucher());
            ps.setBigDecimal(7, dh.getTongTien());
            ps.setInt(8, dh.getStatus());
            ps.setBigDecimal(9, dh.getDiscountAmount());
            ps.setString(10, dh.getDiscountType());
            ps.setBigDecimal(11, dh.getDiscountValue());
            return ps;
        }, keyHolder);
        Number key = keyHolder.getKey();
        return key != null ? key.intValue() : 0;
    }

    public int updateStatus(int id, int status) {
        String sql = "UPDATE don_hang SET status = ? WHERE id = ?";
        return jdbcTemplate.update(sql, status, id);
    }

    public DonHang findById(int id) {
        String sql = "SELECT id, MaND, ten, diachi, sdt, ngaydat, voucher, tongTien, status, discount_amount, discount_type, discount_value FROM don_hang WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new RowMapper<DonHang>() {
                @Override
                public DonHang mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                    DonHang d = new DonHang();
                    d.setId(rs.getInt("id"));
                    d.setMaND(rs.getObject("MaND") != null ? rs.getInt("MaND") : null);
                    d.setTen(rs.getString("ten"));
                    d.setDiachi(rs.getString("diachi"));
                    d.setSdt(rs.getString("sdt"));
                    if (rs.getTimestamp("ngaydat") != null) {
                        d.setNgaydat(new java.util.Date(rs.getTimestamp("ngaydat").getTime()));
                    }
                    d.setVoucher(rs.getString("voucher"));
                    d.setTongTien(rs.getBigDecimal("tongTien"));
                    d.setStatus(rs.getInt("status"));
                    d.setDiscountAmount(rs.getBigDecimal("discount_amount"));
                    d.setDiscountType(rs.getString("discount_type"));
                    d.setDiscountValue(rs.getBigDecimal("discount_value"));
                    return d;
                }
            }, id);
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            return null;
        }
    }

    /** Lấy đơn theo status. */
    public List<DonHang> findByStatus(int status) {
        String sql = "SELECT id, MaND, ten, diachi, sdt, ngaydat, voucher, tongTien, status, discount_amount, discount_type, discount_value FROM don_hang WHERE status = ? ORDER BY ngaydat DESC";
        return jdbcTemplate.query(sql, new RowMapper<DonHang>() {
            @Override
            public DonHang mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                DonHang d = new DonHang();
                d.setId(rs.getInt("id"));
                d.setMaND(rs.getObject("MaND") != null ? rs.getInt("MaND") : null);
                d.setTen(rs.getString("ten"));
                d.setDiachi(rs.getString("diachi"));
                d.setSdt(rs.getString("sdt"));
                if (rs.getTimestamp("ngaydat") != null) {
                    d.setNgaydat(new java.util.Date(rs.getTimestamp("ngaydat").getTime()));
                }
                d.setVoucher(rs.getString("voucher"));
                d.setTongTien(rs.getBigDecimal("tongTien"));
                d.setStatus(rs.getInt("status"));
                d.setDiscountAmount(rs.getBigDecimal("discount_amount"));
                d.setDiscountType(rs.getString("discount_type"));
                d.setDiscountValue(rs.getBigDecimal("discount_value"));
                return d;
            }
        }, status);
    }
}
