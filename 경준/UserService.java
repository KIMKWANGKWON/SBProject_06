package restaurant.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
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
	private final UserRepository uRepository;
	private final FavoritesRepository fRepository;
	private final ReservationsRepository rsvRepository;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	
	@Transactional
	public String join(User user) {
		if(uRepository.findByUsername(user.getUsername())!=null) {
			return "fail";
		}
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
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
	public void reservation(Reservations reservations, Long rid,PrincipalDetails p) {
		Restaurant r = new Restaurant();
		r.setId(rid);
		reservations.setRestaurant(r);
		reservations.setUser(p.getUser());
		rsvRepository.save(reservations);
	}
	
	
	public List<Reservations> findByUid(Long uid) {
		return rsvRepository.findByUser_id(uid);
	}
	
	public Reservations findRsv(Long rsvid) {
		return rsvRepository.findById(rsvid).get();
	}
	
	public void updateRsv(Reservations reservations) {
		Reservations rsv = rsvRepository.findById(reservations.getId()).get();
		rsv.setPeopleCnt(reservations.getPeopleCnt());
		rsv.setMsg(reservations.getMsg());
		rsv.setRsvDate(reservations.getRsvDate());
		rsvRepository.save(rsv);
	}
	
	public void cancelRsv(Long rsvid) {
		rsvRepository.deleteById(rsvid);
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
	
	@Transactional
	public void fDelete(Long fid) {
		fRepository.deleteById(fid);
	}
	
	public Reservations nearestRsv(Long id) {
		return rsvRepository.nearestRsv(id);
	}
}