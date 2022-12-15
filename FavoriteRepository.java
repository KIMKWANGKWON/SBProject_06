package restaurant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import restaurant.model.Favorites;

public interface FavoriteRepository extends JpaRepository<Favorites, Long>{
	
	public List<Favorites> findByUser_id(Long user_id);

}
