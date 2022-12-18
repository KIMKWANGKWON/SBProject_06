package restaurant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import restaurant.model.Reservations;

public interface ReservationsRepository extends JpaRepository<Reservations, Long> {
	public List<Reservations> findByUser_id(Long user_id);
	
	
	@Query(value = "SELECT * FROM reservations03 where rsv_date >= now() and user_id = ?1 order by rsv_date limit 1",
		   nativeQuery = true)
	public Reservations nearestRsv(Long id);
}