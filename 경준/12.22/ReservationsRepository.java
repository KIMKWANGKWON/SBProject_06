package restaurant.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import restaurant.model.Reservations;
import restaurant.model.User;

public interface ReservationsRepository extends JpaRepository<Reservations, Long> {
	
	public List<Reservations> findByUser_id(Long user_id);
	
	public Page<Reservations> findByUser_id(Pageable pageable, Long user_id);
	
	
	@Query(value = "SELECT * FROM reservations where rsv_date_time >= now() and user_id = ?1 order by rsv_date_time limit 1",
			   nativeQuery = true)
	public Reservations nearestRsv(Long id);
	
	@Query(value = "select * from reservations LEFT JOIN restaurant ON reservations.restaurant_id = restaurant.id where rsv_date_time >= now() and restaurant.owner_id = ?1 ",
			nativeQuery = true)
	public List<Reservations> findRsvByOid(Long oid);
	
	@Query(value = "select count(*) from reservations LEFT JOIN restaurant ON reservations.restaurant_id = restaurant.id where rsv_date_time >= now() and restaurant.owner_id = ?1 ",
			nativeQuery = true)
	public Long countRsvByOid(Long oid);
	
	
	
}