package dao;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import beans.User;

@SuppressWarnings("deprecation")
@Repository
public class DaoUser {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private PasswordEncoder passwordEncoder;

    /** Find user by username (for login - password in DB may be hashed). */
    private User findByUsername(String username) {
        String sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                     "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                     "WHERE nd.TenDangNhap = ? AND nd.TrangThai = true";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{ username },
                (java.sql.ResultSet rs, int rowNum) -> {
                    User user = new User();
                    user.setMaNd(rs.getInt("MaND"));
                    user.setHoTen(rs.getString("HoTen"));
                    user.setTenDangNhap(rs.getString("TenDangNhap"));
                    user.setMatKhau(rs.getString("MatKhau"));
                    user.setEmail(rs.getString("Email"));
                    user.setSoDienThoai(rs.getString("SoDienThoai"));
                    user.setDiaChi(rs.getString("DiaChi"));
                    user.setMaQuyen(rs.getInt("MaQuyen"));
                    user.setTrangThai(rs.getBoolean("TrangThai"));
                    user.setNgayTao(rs.getTimestamp("NgayTao"));
                    user.setTenQuyen(rs.getString("TenQuyen"));
                    user.setAnhDaiDien(rs.getString("AnhDaiDien"));
                    return user;
                });
        } catch (Exception e) {
            return null;
        }
    }

    /** Login: match password with BCrypt (or plain for legacy DB). */
    public User checkLogin(String username, String password) {
        User user = findByUsername(username);
        if (user == null) {
            return null;
        }
        String stored = user.getMatKhau();
        if (stored == null) {
            return null;
        }
        boolean matches = passwordEncoder.matches(password, stored);
        if (!matches && password.equals(stored)) {
            matches = true; // legacy plain-text
        }
        if (!matches) {
            return null;
        }
        user.setMatKhau(null);
        return user;
    }
    
    public List<User> list(int permission) {
    	//permission = 0 -> chủ quán
    	//permission = 1 -> quản lý
    	String sql = "";
    	if(permission == 0) {
    		sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                    "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                    "WHERE nd.TrangThai = true "
                    + "AND (pq.TenQuyen = 'Nhân viên kho' OR pq.TenQuyen = 'Nhân viên order'"
                    + " OR pq.TenQuyen = 'Nhân viên pha chế' OR pq.TenQuyen = 'Nhân viên thu ngân' "
                    + "OR pq.TenQuyen = 'Chủ quán' OR pq.TenQuyen = 'Quản lý')";
    	}else if(permission == 1) {
    		sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                    "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                    "WHERE nd.TrangThai = true "
                    + "AND (pq.TenQuyen = 'Nhân viên kho' OR pq.TenQuyen = 'Nhân viên order'"
                    + " OR pq.TenQuyen = 'Nhân viên pha chế' OR pq.TenQuyen = 'Nhân viên thu ngân' "
                    + "OR pq.TenQuyen = 'Quản lý')";
    	}
        try {
        	return jdbcTemplate.query(
        		    sql,
        		    (java.sql.ResultSet rs, int rowNum) -> {
        		        User user = new User();
        		        user.setMaNd(rs.getInt("MaND"));
        		        user.setHoTen(rs.getString("HoTen"));
        		        user.setTenDangNhap(rs.getString("TenDangNhap"));
        		        user.setMatKhau(rs.getString("MatKhau"));
        		        user.setEmail(rs.getString("Email"));
        		        user.setSoDienThoai(rs.getString("SoDienThoai"));
        		        user.setDiaChi(rs.getString("DiaChi"));
        		        user.setMaQuyen(rs.getInt("MaQuyen"));
        		        user.setTrangThai(rs.getBoolean("TrangThai"));
        		        user.setNgayTao(rs.getTimestamp("NgayTao"));
        		        user.setTenQuyen(rs.getString("TenQuyen"));
        		        user.setAnhDaiDien(rs.getString("AnhDaiDien"));
        		        return user;
        		    }
        		);
        } catch (Exception e) {
            return null;
        }
    }
    
    public int save(User u) {
        String rawPassword = u.getMatKhau();
        String hashedPassword = (rawPassword != null && !rawPassword.isEmpty())
            ? passwordEncoder.encode(rawPassword) : passwordEncoder.encode("123");
        String sql = "INSERT INTO nguoi_dung (HoTen, TenDangNhap, MatKhau, Email, SoDienThoai, MaQuyen, DiaChi, AnhDaiDien, TrangThai, NgayTao) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
            u.getHoTen(),
            u.getTenDangNhap(),
            hashedPassword,
            u.getEmail(),
            u.getSoDienThoai(),
            u.getMaQuyen(),
            u.getDiaChi(),
            u.getAnhDaiDien(),
            1,
            LocalDate.now());
    }
    
    public String getUserName(String permission) {
        String sql = "SELECT nd.TenDangNhap FROM NGUOI_DUNG nd " +
                "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                "WHERE pq.TenQuyen = ? ORDER BY nd.TenDangNhap DESC";
        return jdbcTemplate.queryForObject(
    		    sql,
    		    new Object[]{ permission },
    		    (java.sql.ResultSet rs, int rowNum) -> {
    		    	String TenDangNhapOld = "";
    		    	String TenDangNhapNew = "";
    		    	if(rs.getRow() > 0)
    		    		TenDangNhapOld = rs.getString("TenDangNhap");
    		    	switch(permission.toLowerCase()) {
    		    	case "nhân viên kho":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "kho01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(3));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "kho0" + num;
    		    			}else {
    		    				TenDangNhapNew = "kho" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "nhân viên order":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "order01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(5));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "order0" + num;
    		    			}else {
    		    				TenDangNhapNew = "order" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "nhân viên pha chế":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "phache01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(6));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "phache0" + num;
    		    			}else {
    		    				TenDangNhapNew = "phache" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "nhân viên thu ngân":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "thungan01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(7));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "thungan0" + num;
    		    			}else {
    		    				TenDangNhapNew = "thungan" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "chủ quán":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "chuquan01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(7));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "chuquan0" + num;
    		    			}else {
    		    				TenDangNhapNew = "chuquan" + num;
    		    			}
    		    		}
    		    		break;
    		    	case "quản lý":
    		    		if(rs.getRow() == 0) {
    		    			TenDangNhapNew = "quanly01";
    		    		}else {
    		    			int num = Integer.parseInt(TenDangNhapOld.substring(6));
    		    			num++;
    		    			if(num < 10) {
    		    				TenDangNhapNew = "quanly0" + num;
    		    			}else {
    		    				TenDangNhapNew = "quanly" + num;
    		    			}
    		    		}
    		    		break;
    		    }
    		        return TenDangNhapNew;
    		    }
    		);
    }
    
    public int getPermission(String permission) {
        String sql = "SELECT MaQuyen FROM PHAN_QUYEN WHERE TenQuyen = ?";
        Integer maQuyen = jdbcTemplate.queryForObject(sql, Integer.class, permission);
        return maQuyen != null ? maQuyen : 0;
    }

    public void updateUser(User user) {
        String sql = "UPDATE NGUOI_DUNG SET HoTen=?, Email=?, SoDienThoai=?, DiaChi=? WHERE MaND=?";
        jdbcTemplate.update(sql, 
            user.getHoTen(),
            user.getEmail(),
            user.getSoDienThoai(),
            user.getDiaChi(),
            user.getMaNd()
        );
    }

    public void updateAvatar(int userId, String avatarPath) {
        String sql = "UPDATE NGUOI_DUNG SET AnhDaiDien=? WHERE MaND=?";
        jdbcTemplate.update(sql, avatarPath, userId);
    }

    public boolean checkPassword(String username, String password) {
        User user = findByUsername(username);
        if (user == null || user.getMatKhau() == null) {
            return false;
        }
        return passwordEncoder.matches(password, user.getMatKhau()) || password.equals(user.getMatKhau());
    }

    public void updatePassword(String username, String newPassword) {
        String hashed = passwordEncoder.encode(newPassword);
        String sql = "UPDATE NGUOI_DUNG SET MatKhau=? WHERE TenDangNhap=?";
        jdbcTemplate.update(sql, hashed, username);
    }

    public int update(User u) {
        String sql = "UPDATE Nguoi_Dung SET HoTen = ?, Email = ?, SoDienThoai = ?, MaQuyen = ?, DiaChi = ?, AnhDaiDien = ? WHERE MaND = ?";
        return jdbcTemplate.update(sql, 
            u.getHoTen(),
            u.getEmail(),
            u.getSoDienThoai(),
            u.getMaQuyen(),
            u.getDiaChi(),
            u.getAnhDaiDien(),
            u.getMaNd());
    }
    
    public User getUserById(int maNd) {
    	String sql = "SELECT nd.*, pq.TenQuyen FROM NGUOI_DUNG nd " +
                "JOIN PHAN_QUYEN pq ON nd.MaQuyen = pq.MaQuyen " +
                "WHERE nd.TrangThai = true "
                + "AND (pq.TenQuyen = 'Nhân viên kho' OR pq.TenQuyen = 'Nhân viên order'"
                + " OR pq.TenQuyen = 'Nhân viên pha chế' OR pq.TenQuyen = 'Nhân viên thu ngân' "
                + "OR pq.TenQuyen = 'Chủ quán' OR pq.TenQuyen = 'Quản lý')"
                + " AND nd.MaNd = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{maNd}, 
        		(java.sql.ResultSet rs, int rowNum) -> {
	        User user = new User();
	        user.setMaNd(rs.getInt("MaND"));
	        user.setHoTen(rs.getString("HoTen"));
	        user.setTenDangNhap(rs.getString("TenDangNhap"));
	        user.setEmail(rs.getString("Email"));
	        user.setSoDienThoai(rs.getString("SoDienThoai"));
	        user.setDiaChi(rs.getString("DiaChi"));
	        user.setMaQuyen(rs.getInt("MaQuyen"));
	        user.setTrangThai(rs.getBoolean("TrangThai"));
	        user.setNgayTao(rs.getTimestamp("NgayTao"));
	        user.setTenQuyen(rs.getString("TenQuyen"));
	        user.setAnhDaiDien(rs.getString("AnhDaiDien"));
	        return user;
	    }
	);
    }

    public int delete(int maNd) {
        String sql = "DELETE FROM Nguoi_Dung WHERE MaND = ?";
        return jdbcTemplate.update(sql, maNd);
    }
} 