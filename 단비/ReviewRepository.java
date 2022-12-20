package restaurant.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import restaurant.model.Restaurant;
import restaurant.model.Review;
import restaurant.model.User;

public interface ReviewRepository extends JpaRepository<Review, Long>{




}
