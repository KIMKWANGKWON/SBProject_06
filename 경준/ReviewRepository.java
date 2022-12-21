package restaurant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import restaurant.model.Comment;
import restaurant.model.Review;

public interface ReviewRepository extends JpaRepository<Review, Long>{

	//레스토랑 디테일 리뷰 보기
	@Query(value = "select sc from Review sc where restaurant_id=?1", nativeQuery = false)
	public List<Review> findByReview(Long restaurant_id);
	
	//내 리뷰 보기
	@Query(value = "select sc from Review sc where user_id=?1", nativeQuery = false)
	public List<Review> findByUserReview(Long user_id);
	
	@Modifying
	@Query(value = "update review set comment_id=?2 where id=?1", nativeQuery = true)
	public void updateReview(Long id, Comment comment);
}