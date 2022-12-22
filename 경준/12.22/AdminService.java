package restaurant.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import restaurant.model.Restaurant;
import restaurant.model.User;
import restaurant.repository.RestaurantRepository;
import restaurant.repository.UserRepository;
import restaurant.repository.UserRepositryImpl;

@Service
@RequiredArgsConstructor
public class AdminService {
	
	private final UserRepository uRepository;
	private final UserRepositryImpl uRepositoryDsl;
	private final RestaurantRepository rRepository;
	// MemberList
	public Page<User> findUser(Pageable pageable) {
		return uRepositoryDsl.userPage(pageable, 0L);
//		return uRepository.findAll();
	}
	// MemberCount
	public Long countUser() {
		return uRepository.count();
	}
	// RestaurantList
	public List<Restaurant> findRestaurant() {
		return rRepository.findAll();
	}
	
	// RestaurantList page, search
	public Page<Restaurant> findRestaurant(Pageable pageable, String field, String word) {
		Page<Restaurant> rlists = rRepository.findAll(pageable);
		if(field.equals("name")) {
			rlists = rRepository.findByNameContaining(pageable, word);
		} 
		return rlists;
	}
	// RestaurantCount
	public Long countRestaurant() {
		return rRepository.count();
	}
	// RestaurantCount search
	public Long countRestaurant(String field, String word) {
		Long count = rRepository.count();
		if(field.equals("name")) {
			count = rRepository.cntNameSearch(word);
		}
		return count;
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