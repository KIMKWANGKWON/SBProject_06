package restaurant.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import restaurant.model.Inquiry;
import restaurant.model.Response;

public interface InquiryRepository extends JpaRepository<Inquiry, Long> {
	
	public List<Inquiry> findByUser_id(Long id);
	
	public Page<Inquiry> findByUser_id(Long id, Pageable pageable);
	
	@Modifying
	@Query(value = "update inquiry set reply=1 where id=?1", nativeQuery = true)
	public void updateReply(Long id);
	
}