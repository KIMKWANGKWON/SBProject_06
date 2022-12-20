package restaurant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import restaurant.model.Review;

public interface ReviewRepository extends JpaRepository<Review, Long>{

	@Query(value = "select sc from Review sc where restaurant_id=?1", nativeQuery = false)
	public List<Review> findByReview(Long restaurant_id);
	

}
