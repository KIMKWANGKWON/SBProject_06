package restaurant;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


public interface EntityRepositoryCustom {
	public Page<CustomEntity> searchWithCustom(String keyword,String order,Pageable pageable);

}
