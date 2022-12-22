package restaurant.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import restaurant.model.Inquiry;

import restaurant.model.Response;

public interface InquiryRepository extends JpaRepository<Inquiry, Long> {
	
	public List<Inquiry> findByUser_id(Long id);
	
	public Page<Inquiry> findByUser_id(Long id, Pageable pageable);
	
	@Modifying
	@Query(value = "update inquiry set reply=1 where id=?1", nativeQuery = true)
	public void updateReply(Long id);
	
	
	@Query(value = "SELECT * FROM inquiry where title like CONCAT('%', :word, '%') order by regdate desc",
		   nativeQuery = true)
	public Page<Inquiry> userSearch(Pageable pageable, @Param("word") String word);

	@Query(value = "SELECT count(*) FROM inquiry where title like CONCAT('%', :word, '%')",
		   nativeQuery = true)
	public Long cntUserSearch(@Param("word") String word);
}