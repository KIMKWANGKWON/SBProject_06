package restaurant.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import restaurant.model.Reservations;

public interface ReservationsRepository extends JpaRepository<Reservations, Long> {
	
}
