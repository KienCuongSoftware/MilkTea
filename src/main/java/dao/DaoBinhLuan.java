package dao;

import beans.BinhLuan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class DaoBinhLuan {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<BinhLuan> findByMaSP(int maSP) {
        String sql = "SELECT b.id, b.MaND, b.MaSP, b.NoiDung, b.NgayTao, n.HoTen " +
                     "FROM binh_luan b JOIN nguoi_dung n ON b.MaND = n.MaND WHERE b.MaSP = ? ORDER BY b.NgayTao DESC";
        return jdbcTemplate.query(sql, new RowMapper<BinhLuan>() {
            @Override
            public BinhLuan mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                BinhLuan b = new BinhLuan();
                b.setId(rs.getInt("id"));
                b.setMaND(rs.getInt("MaND"));
                b.setMaSP(rs.getInt("MaSP"));
                b.setNoiDung(rs.getString("NoiDung"));
                b.setNgayTao(rs.getTimestamp("NgayTao"));
                b.setHoTen(rs.getString("HoTen"));
                return b;
            }
        }, maSP);
    }

    public int save(BinhLuan b) {
        String sql = "INSERT INTO binh_luan (MaND, MaSP, NoiDung) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, b.getMaND(), b.getMaSP(), b.getNoiDung());
    }
}
