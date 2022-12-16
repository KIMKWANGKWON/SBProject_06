package restaurant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import restaurant.model.Reservations;

public interface ReservationsRepository extends JpaRepository<Reservations, Long> {
	
	public List<Reservations> findByUser_id(Long user_id);
}