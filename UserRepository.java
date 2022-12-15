package restaurant.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import restaurant.model.User;

public interface UserRepository extends JpaRepository<User, Long>{
	
	public User findByUsername(String username);
}
