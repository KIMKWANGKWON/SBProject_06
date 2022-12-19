package restaurant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import restaurant.model.Reservations;

public interface ReservationsRepository extends JpaRepository<Reservations, Long> {
	public List<Reservations> findByUser_id(Long user_id);
	
	@Query(value = "SELECT * FROM reservations04 where rsv_date_time >= now() and user_id = ?1 order by rsv_date_time limit 1",
			   nativeQuery = true)
		public Reservations nearestRsv(Long id);
}