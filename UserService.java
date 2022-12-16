package restaurant.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import restaurant.model.Favorites;
import restaurant.model.User;
import restaurant.repository.FavoritesRepository;
import restaurant.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class UserService {
	
	@Autowired
	private UserRepository uRepository;
	
	@Autowired
	private FavoritesRepository fRepository;
	
	public void join(User user) {
		uRepository.save(user);
	}
	
	public List<Favorites> findByUser_id(Long user_id) {
		return fRepository.findByUser_id(user_id);
	}
	public User view(Long id) {
		return uRepository.findById(id).get();
	}
	
	@Transactional
	public void update(User user) {
		User u = uRepository.findById(user.getId()).get();
		u.setNickname(user.getNickname());
		u.setPassword(user.getPassword());
	}
	
	public void delete(Long id) {
		uRepository.deleteById(id);
	}
}