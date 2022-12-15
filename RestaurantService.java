package restaurant.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import restaurant.model.Restaurant;
import restaurant.repository.RestaurantRepository;

@Service
@RequiredArgsConstructor
public class RestaurantService {
	
	private final RestaurantRepository restaurantRepository;
	
	public Restaurant view(Long rnum) {
		return restaurantRepository.getById(rnum);
	}
	
	public List<Restaurant> findAll() {
		return restaurantRepository.findAll();
	}
	
	public void register(Restaurant restaurant) {
		restaurantRepository.save(restaurant);
	}
}
