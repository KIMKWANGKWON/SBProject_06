package restaurant.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import restaurant.model.Restaurant;

public interface RestaurantRepository extends JpaRepository<Restaurant, Long>{
	@Query(value = 
			"SELECT * FROM restaurant WHERE enabled = 1 ORDER BY read_count DESC LIMIT 3",
			nativeQuery = true)
	public List<Restaurant> popularList();
	@Query(value =
			"SELECT * FROM restaurant WHERE enabled = 1 ORDER BY regdate DESC LIMIT 3",
			nativeQuery = true)
	public List<Restaurant> recentList();
//	@Query()
//	public List<Restaurant> searchByMenuName();

	public List<Restaurant> findAllByEnabled(boolean enabled);
	public List<Restaurant> findAllByOwner_id(Long oid);
	@Query(value = "SELECT sc FROM Restaurant sc WHERE sc.businessNum = ?1")
	public Restaurant findByBusinessNum(String BusinessNum);
	//	public List<Restaurant> search();
	
	//밑에는 모두 검색
//	@Query(value =
//			"SELECT sc FROM Restaurant sc WHERE sc.name LIKE %:word%")
//	public List<Restaurant> searchByName(
//			@Param("word")String word);
//	@Query(value =
//			"SELECT * FROM restaurant04 rt, menu04 mt"
//			+ " WHERE rt.id = mt.restaurant_id AND mt.name like concat('%',:word,'%')"
//			,nativeQuery = true)
//	public List<Restaurant> searchByMenuName(
//			@Param("word")String word);
//	@Query(value =
//			"SELECT sc FROM Restaurant sc WHERE sc.description LIKE %:word%")
//	public List<Restaurant> searchByDescription(
//			@Param("word")String word);
//	//조회수 순
//	@Query(value =
//			"SELECT sc FROM Restaurant sc WHERE sc.name LIKE %:word% ORDER BY sc.readCount DESC")
//	public List<Restaurant> searchByNameOrderByReadCnt(
//			@Param("word")String word);
//	@Query(value =
//			"SELECT * FROM restaurant04 rt, menu04 mt"
//			+ " WHERE rt.id = mt.restaurant_id AND mt.name like concat('%',:word,'%') ORDER BY read_count DESC"
//			,nativeQuery = true)
//	public List<Restaurant> searchByMenuNameOrderByReadCnt(
//			@Param("word")String word);
//	@Query(value =
//			"SELECT sc FROM Restaurant sc WHERE sc.description LIKE %:word% ORDER BY sc.readCount DESC")
//	public List<Restaurant> searchByDescriptionOrderByReadCnt(
//			@Param("word")String word);
//	//최근 등록 순
//	@Query(value =
//			"SELECT sc FROM Restaurant sc WHERE sc.name LIKE %:word% ORDER BY sc.regdate DESC")
//	public List<Restaurant> searchByNameOrderByRegdate(
//			@Param("word")String word);
//	@Query(value =
//			"SELECT * FROM restaurant04 rt, menu04 mt"
//			+ " WHERE rt.id = mt.restaurant_id AND mt.name like concat('%',:word,'%') ORDER BY regdate DESC"
//			,nativeQuery = true)
//	public List<Restaurant> searchByMenuNameOrderByRegdate(
//			@Param("word")String word);
//	@Query(value =
//			"SELECT sc FROM Restaurant sc WHERE sc.description LIKE %:word% ORDER BY sc.regdate DESC")
//	public List<Restaurant> searchByDescriptionOrderByRegdate(
//			@Param("word")String word);
	
	public Page<Restaurant> findByNameContaining(Pageable pageable, String word);
	
	@Query(value = "select count(*) from restaurant where name like CONCAT('%', :word, '%')",
		   nativeQuery = true)
	public Long cntNameSearch(@Param("word") String word);
}
