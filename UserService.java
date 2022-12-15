package restaurant.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import restaurant.model.Favorites;
import restaurant.model.User;
import restaurant.repository.FavoriteRepository;
import restaurant.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class UserService {
	
	@Autowired
	private UserRepository uRepository;
	
	@Autowired
	private FavoriteRepository fRepository;
	
	public void join(User user) {
		uRepository.save(user);
	}
	
	public List<Favorites> findByUser_id(Long user_id) {
		return fRepository.findByUser_id(user_id);
	}

}
