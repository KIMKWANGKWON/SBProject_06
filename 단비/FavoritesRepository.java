package restaurant.repository;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import restaurant.model.Favorites;

public interface FavoritesRepository extends JpaRepository<Favorites, Long>{
	
public List<Favorites> findByUser_id(Long user_id);

public Page<Favorites> findByUser_id(Long user_id, Pageable pageable);

	@Query(value = "select sc from Favorites sc where user.id=?1 and restaurant.id=?2",nativeQuery = false)
	public Favorites isExist(Long user_id, Long restaurant_id);
	
	@Modifying
	@Query(value = "DELETE from Favorites sc WHERE sc.user.id = ?1 and sc.restaurant.id = ?2" ,nativeQuery = false)
	public void delete(Long user_id, Long restaurant_id);
	
	@Query(value = "select sc.restaurant.id"
			+ " from Favorites sc WHERE sc.user.id = ?1")
	public List<Long> getMap(Long user_id);
}