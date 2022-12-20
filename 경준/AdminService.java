package restaurant.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import restaurant.model.Restaurant;
import restaurant.model.User;
import restaurant.repository.RestaurantRepository;
import restaurant.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class AdminService {
	
	private final UserRepository uRepository;
	
	private final RestaurantRepository rRepository;
	// MemberList
	public List<User> findUser() {
		return uRepository.findAll();
	}
	// MemberCount
	public Long countUser() {
		return uRepository.count();
	}
	// RestaurantList
	public List<Restaurant> findRestaurant() {
		return rRepository.findAll();
	}
	// RestaurantCount
	public Long countRestaurant() {
		return rRepository.count();
	}
	// Member 상세보기
	public User viewUser(Long id) {
		return uRepository.findById(id).get();
	}
	// Member 삭제
	public void deleteUser(Long id) {
		uRepository.deleteById(id);
	}
	// Restaurant 상세보기
	public Restaurant viewRestaurant(Long id) {
		return rRepository.findById(id).get();
	}
	// Restaurant 삭제
	public void deleteRestaurant(Long id) {
		rRepository.deleteById(id);
	}
}
