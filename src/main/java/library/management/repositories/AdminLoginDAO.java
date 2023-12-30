package library.management.repositories;
import java.util.List;
import library.management.entities.Admin;

public interface AdminLoginDAO{
	public List<Admin> validateAdmin(String adminEmailId,String adminPassword);
}
