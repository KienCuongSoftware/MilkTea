package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import beans.Warehouse;

@Repository
public class DaoWarehouse {
	@Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<Warehouse> list() {
    	String sql = "SELECT * FROM kho";
        try {
        	return jdbcTemplate.query(
        		    sql,
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		    	Warehouse warehouse = new Warehouse();
        		    	warehouse.setCode(rs.getInt("maKho"));
        		    	warehouse.setName(rs.getString("tenKho"));
        		    	warehouse.setAddress(rs.getString("diaChi"));
        		    	return warehouse;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
    
    public int save(Warehouse u) {
        String sql = "INSERT INTO kho (TenKho, diaChi) VALUES (?, ?)";
        return jdbcTemplate.update(sql, 
            u.getName(),
            u.getAddress());
    }

    public void update(Warehouse u) {
        String sql = "UPDATE Kho SET TenKho=?, diaChi=? WHERE maKho=?";
        jdbcTemplate.update(sql, 
            u.getName(),
            u.getAddress(),
            u.getCode()
        );
    }
    
    public Warehouse getWarehouseById(int maKho) {
    	String sql = "SELECT * FROM Kho WHERE maKho = ? ";
        return jdbcTemplate.queryForObject(sql, 
        		(java.sql.ResultSet rs, int rowNum) -> {
        			Warehouse warehouse = new Warehouse();
    		    	warehouse.setCode(rs.getInt("maKho"));
    		    	warehouse.setName(rs.getString("tenKho"));
    		    	warehouse.setAddress(rs.getString("diaChi"));
    		    	return warehouse;
	    },
	    maKho);
    }

    public int delete(int maKho) {
        String sql = "DELETE FROM Kho WHERE maKho = ?";
        return jdbcTemplate.update(sql, maKho);
    }
}
