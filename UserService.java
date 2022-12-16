package restaurant.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import lombok.RequiredArgsConstructor;
import restaurant.model.Favorites;
import restaurant.model.Reservations;
import restaurant.model.Restaurant;
import restaurant.model.User;
import restaurant.repository.FavoritesRepository;
import restaurant.repository.ReservationsRepository;
import restaurant.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class UserService {
	
	@Autowired
	private UserRepository uRepository;
	
	@Autowired
	private FavoritesRepository fRepository;
	
	@Autowired ReservationsRepository rsvRepository;
	
	public void join(User user) {
		uRepository.save(user);
	}
	
	public List<Favorites> findByUser_id(Long user_id) {
		return fRepository.findByUser_id(user_id);
	}
	
	public void reservation(Reservations reservations, Long rid) {
		Restaurant r = new Restaurant();
		r.setId(rid);
		User u = new User();
		u.setId(1L);
		reservations.setRestaurant(r);
		reservations.setUser(u);
		rsvRepository.save(reservations);
	}
}