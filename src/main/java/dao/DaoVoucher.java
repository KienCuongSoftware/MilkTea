package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import beans.Voucher;

@Repository
public class DaoVoucher {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final RowMapper<Voucher> ROW_MAPPER = new RowMapper<Voucher>() {
        @Override
        public Voucher mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
            Voucher v = new Voucher();
            v.setId(rs.getInt("id"));
            v.setMa(rs.getString("ma"));
            v.setTen(rs.getString("ten"));
            v.setMota(rs.getString("mota"));
            v.setNgayBatDau(rs.getTimestamp("ngaybatdau"));
            v.setNgayKetThuc(rs.getTimestamp("ngayketthuc"));
            v.setPhanTramGiamGia(rs.getObject("phantramgiamgia") != null ? rs.getInt("phantramgiamgia") : null);
            v.setGiaTriGiamGia(rs.getObject("giatrigiamgia") != null ? rs.getInt("giatrigiamgia") : null);
            return v;
        }
    };

    /** Lấy tất cả voucher (cho khách xem / chọn mã giảm giá). */
    public List<Voucher> findAll() {
        String sql = "SELECT id, ma, ten, mota, ngaybatdau, ngayketthuc, phantramgiamgia, giatrigiamgia FROM voucher ORDER BY ngayketthuc DESC";
        return jdbcTemplate.query(sql, ROW_MAPPER);
    }
}
