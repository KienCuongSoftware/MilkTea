package dao;

import beans.DanhGia;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class DaoDanhGia {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<DanhGia> findByMaSP(int maSP) {
        String sql = "SELECT d.id, d.MaND, d.MaSP, d.Diem, d.NoiDung, d.NgayTao, n.HoTen " +
                     "FROM danh_gia d JOIN nguoi_dung n ON d.MaND = n.MaND WHERE d.MaSP = ? ORDER BY d.NgayTao DESC";
        return jdbcTemplate.query(sql, new RowMapper<DanhGia>() {
            @Override
            public DanhGia mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                DanhGia d = new DanhGia();
                d.setId(rs.getInt("id"));
                d.setMaND(rs.getInt("MaND"));
                d.setMaSP(rs.getInt("MaSP"));
                d.setDiem(rs.getInt("Diem"));
                d.setNoiDung(rs.getString("NoiDung"));
                d.setNgayTao(rs.getTimestamp("NgayTao"));
                d.setHoTen(rs.getString("HoTen"));
                return d;
            }
        }, maSP);
    }

    public Double getAverageRating(int maSP) {
        String sql = "SELECT AVG(Diem) FROM danh_gia WHERE MaSP = ?";
        Double avg = jdbcTemplate.queryForObject(sql, Double.class, maSP);
        return avg != null ? Math.round(avg * 10.0) / 10.0 : null;
    }

    public int getTotalRatings(int maSP) {
        String sql = "SELECT COUNT(*) FROM danh_gia WHERE MaSP = ?";
        Integer n = jdbcTemplate.queryForObject(sql, Integer.class, maSP);
        return n != null ? n : 0;
    }

    public int getCountByDiem(int maSP, int diem) {
        String sql = "SELECT COUNT(*) FROM danh_gia WHERE MaSP = ? AND Diem = ?";
        Integer n = jdbcTemplate.queryForObject(sql, Integer.class, maSP, diem);
        return n != null ? n : 0;
    }

    public int save(DanhGia d) {
        String sql = "INSERT INTO danh_gia (MaND, MaSP, Diem, NoiDung) VALUES (?, ?, ?, ?)";
        return jdbcTemplate.update(sql, d.getMaND(), d.getMaSP(), d.getDiem(), d.getNoiDung());
    }
}
