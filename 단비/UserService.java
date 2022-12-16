package restaurant.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	private final ReservationsRepository rsvRepository;
	@Transactional
	public String join(User user) {
		if(uRepository.findByUsername(user.getUsername())!=null) {
			return "fail";
		}
		uRepository.save(user);
		return "success";
	}
	public User view(Long id) {
		return uRepository.findById(id).get();
	}
	public List<Favorites> findByUser_id(Long user_id) {
		return fRepository.findByUser_id(user_id);
	}

	
	@Transactional
	public void update(User user) {
		User u = uRepository.findById(user.getId()).get();
		u.setNickname(user.getNickname());
		u.setPassword(user.getPassword());
	}
	@Transactional
	public void delete(Long id) {
		uRepository.deleteById(id);
	}
	
	@Transactional
	public void reservation(Reservations reservations, Long rid) {
		Restaurant r = new Restaurant();
		r.setId(rid);
		User u = new User();
		u.setId(1L);
		reservations.setRestaurant(r);
		reservations.setUser(u);
		rsvRepository.save(reservations);
	}
	
	@Transactional
	public void like(Favorites favorite) {
		if(fRepository.isExist(favorite.getUser().getId(), favorite.getRestaurant().getId())==null) {
			fRepository.save(favorite);
		} else {
			System.out.println("test");
			fRepository.delete(favorite.getUser().getId(), favorite.getRestaurant().getId());
		}
	}
}