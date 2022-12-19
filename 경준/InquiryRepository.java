package restaurant.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import restaurant.model.Inquiry;

public interface InquiryRepository extends JpaRepository<Inquiry, Long> {
	
	public List<Inquiry> findByUser_id(Long id);
	
	@Modifying
	@Query(value = "update inquiry04 set reply=1 where id=?1", nativeQuery = true)
	public void updateReply(Long id);
	
}
