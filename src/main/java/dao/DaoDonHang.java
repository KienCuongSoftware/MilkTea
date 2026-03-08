package dao;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
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

    private static final RowMapper<DonHang> ROW_MAPPER = new RowMapper<DonHang>() {
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
    };

    private static final RowMapper<Object[]> REVENUE_BY_DAY_MAPPER = new RowMapper<Object[]>() {
        @Override
        public Object[] mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
            return new Object[] { rs.getString(1), rs.getBigDecimal(2) };
        }
    };

    private static final RowMapper<Object[]> COMPLETED_COUNT_BY_DAY_MAPPER = new RowMapper<Object[]>() {
        @Override
        public Object[] mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
            return new Object[] { rs.getString(1), Integer.valueOf(rs.getInt(2)) };
        }
    };

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final String INSERT = "INSERT INTO don_hang (MaND, ten, diachi, sdt, ngaydat, voucher, tongTien, status, discount_amount, discount_type, discount_value) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_FIND_BY_STATUS = "SELECT id, MaND, ten, diachi, sdt, ngaydat, voucher, tongTien, status, discount_amount, discount_type, discount_value FROM don_hang WHERE status = ? ORDER BY ngaydat DESC";

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
            return jdbcTemplate.queryForObject(sql, ROW_MAPPER, id);
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            return null;
        }
    }

    /** Dem so don theo status (badge navbar). */
    public int countByStatus(int status) {
        String sql = "SELECT COUNT(*) FROM don_hang WHERE status = ?";
        Integer n = jdbcTemplate.queryForObject(sql, Integer.class, status);
        return n != null ? n : 0;
    }

    /** Tong doanh thu tu cac don da thanh toan (status = 3). */
    public BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(tongTien), 0) FROM don_hang WHERE status = 3";
        try {
            return jdbcTemplate.queryForObject(sql, BigDecimal.class);
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    /** Lay don theo status. */
    public List<DonHang> findByStatus(int status) {
        return jdbcTemplate.query(SQL_FIND_BY_STATUS, ROW_MAPPER, status);
    }

    /* Subquery so outer SELECT has no ngaydat reference; satisfies ONLY_FULL_GROUP_BY */
    private static final String SQL_REVENUE_BY_DAY = "SELECT DATE_FORMAT(t.dt, '%d/%m') as d, COALESCE(t.total, 0) FROM (SELECT DATE(ngaydat) as dt, SUM(tongTien) as total FROM don_hang WHERE status = 3 AND ngaydat >= DATE_SUB(CURDATE(), INTERVAL ? DAY) GROUP BY DATE(ngaydat)) t ORDER BY t.dt";
    private static final String SQL_COMPLETED_COUNT_BY_DAY = "SELECT DATE_FORMAT(t.dt, '%d/%m') as d, t.cnt FROM (SELECT DATE(ngaydat) as dt, COUNT(*) as cnt FROM don_hang WHERE status = 3 AND ngaydat >= DATE_SUB(CURDATE(), INTERVAL ? DAY) GROUP BY DATE(ngaydat)) t ORDER BY t.dt";

    /** Doanh thu theo ngay (status=3) N ngay gan nhat. Tra ve List [dateStr, amount]. */
    public List<Object[]> getRevenueByDay(int lastDays) {
        return jdbcTemplate.query(SQL_REVENUE_BY_DAY, REVENUE_BY_DAY_MAPPER, lastDays);
    }

    /** So don hoan thanh (status=3) theo ngay, N ngay gan nhat. Tra ve List [dateStr, count]. */
    public List<Object[]> getCompletedOrdersCountByDay(int lastDays) {
        return jdbcTemplate.query(SQL_COMPLETED_COUNT_BY_DAY, COMPLETED_COUNT_BY_DAY_MAPPER, lastDays);
    }
}
