package dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;

import beans.Product;

@Repository
public class DaoProduct {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Thêm sản phẩm mới
    public int save(Product p) {
        String sql = "INSERT INTO SAN_PHAM (TenSP, DonGia, MaDM, MoTa, HinhAnh, SoLuong, TrangThai) VALUES (?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, 
            p.getTenSP(), 
            p.getDonGia(), 
            p.getMaDM(), 
            p.getMoTa(), 
            p.getHinhAnh(),
            p.getSoLuong(),
            p.isTrangThai());
    }

    // Cập nhật sản phẩm
    public int update(Product p) {
        String sql = "UPDATE SAN_PHAM SET TenSP = ?, DonGia = ?, MaDM = ?, MoTa = ?, HinhAnh = ?, SoLuong = ?, TrangThai = ? WHERE MaSP = ?";
        return jdbcTemplate.update(sql, 
            p.getTenSP(), 
            p.getDonGia(), 
            p.getMaDM(), 
            p.getMoTa(), 
            p.getHinhAnh(),
            p.getSoLuong(),
            p.isTrangThai(),
            p.getMaSP());
    }

    // Xoá sản phẩm
    public int delete(int maSP) {
        String sql = "DELETE FROM SAN_PHAM WHERE MaSP = ?";
        return jdbcTemplate.update(sql, maSP);
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(int maSP) {
        String sql = "SELECT * FROM SAN_PHAM WHERE MaSP = ?";
        return jdbcTemplate.queryForObject(sql, new RowMapper<Product>() {
            @Override
            public Product mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                Product product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setDonGia(rs.getBigDecimal("DonGia"));
                product.setMaDM(rs.getInt("MaDM"));
                product.setMoTa(rs.getString("MoTa"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setTrangThai(rs.getBoolean("TrangThai"));
                return product;
            }
        }, maSP);
    }

    // Lấy danh sách tất cả sản phẩm
    public List<Product> getProducts() {
        String sql = "SELECT * FROM SAN_PHAM";
        return jdbcTemplate.query(sql, new RowMapper<Product>() {
            @Override
            public Product mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                Product product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setDonGia(rs.getBigDecimal("DonGia"));
                product.setMaDM(rs.getInt("MaDM"));
                product.setMoTa(rs.getString("MoTa"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setTrangThai(rs.getBoolean("TrangThai"));
                return product;
            }
        });
    }

    // Lấy tổng số sản phẩm
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM SAN_PHAM";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    /** Số sản phẩm có tồn kho <= ngưỡng (dùng cho dashboard kho). */
    public int getLowStockCount(int maxQuantity) {
        String sql = "SELECT COUNT(*) FROM SAN_PHAM WHERE SoLuong <= ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, maxQuantity);
        return count != null ? count : 0;
    }

    /** Danh sách sản phẩm có tồn kho <= ngưỡng (dashboard kho). */
    public List<Product> getLowStockProducts(int maxQuantity) {
        String sql = "SELECT * FROM SAN_PHAM WHERE SoLuong <= ? ORDER BY SoLuong ASC";
        return jdbcTemplate.query(sql, new RowMapper<Product>() {
            @Override
            public Product mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                Product p = new Product();
                p.setMaSP(rs.getInt("MaSP"));
                p.setTenSP(rs.getString("TenSP"));
                p.setDonGia(rs.getBigDecimal("DonGia"));
                p.setMaDM(rs.getInt("MaDM"));
                p.setMoTa(rs.getString("MoTa"));
                p.setHinhAnh(rs.getString("HinhAnh"));
                p.setSoLuong(rs.getInt("SoLuong"));
                p.setTrangThai(rs.getBoolean("TrangThai"));
                return p;
            }
        }, maxQuantity);
    }

    // Lấy sản phẩm theo trang
    public List<Product> getProductsByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM SAN_PHAM ORDER BY MaSP LIMIT ?, ?";
        return jdbcTemplate.query(sql, new RowMapper<Product>() {
            @Override
            public Product mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                Product product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setDonGia(rs.getBigDecimal("DonGia"));
                product.setMaDM(rs.getInt("MaDM"));
                product.setMoTa(rs.getString("MoTa"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setTrangThai(rs.getBoolean("TrangThai"));
                return product;
            }
        }, offset, pageSize);
    }

    @SuppressWarnings("deprecation")
    public List<Product> searchProducts(String keyword, Integer category) {
        StringBuilder sql = new StringBuilder("SELECT * FROM SAN_PHAM WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (TenSP LIKE ? OR MoTa LIKE ?)");
            String searchTerm = "%" + keyword.trim() + "%";
            params.add(searchTerm);
            params.add(searchTerm);
        }
        
        if (category != null && category > 0) {
            sql.append(" AND MaDM = ?");
            params.add(category);
        }
        
        sql.append(" ORDER BY MaSP DESC");
        
        try {
            return jdbcTemplate.query(sql.toString(), 
                params.toArray(), 
                new RowMapper<Product>() {
                    @Override
                    public Product mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
                        Product product = new Product();
                        product.setMaSP(rs.getInt("MaSP"));
                        product.setTenSP(rs.getString("TenSP"));
                        product.setDonGia(rs.getBigDecimal("DonGia"));
                        product.setMaDM(rs.getInt("MaDM"));
                        product.setMoTa(rs.getString("MoTa"));
                        product.setHinhAnh(rs.getString("HinhAnh"));
                        product.setSoLuong(rs.getInt("SoLuong"));
                        product.setTrangThai(rs.getBoolean("TrangThai"));
                        return product;
                    }
                });
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
