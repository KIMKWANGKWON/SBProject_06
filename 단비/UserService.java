package restaurant.service;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Favorites;
import restaurant.model.Reservations;
import restaurant.model.Restaurant;
import restaurant.model.Review;
import restaurant.model.User;
import restaurant.repository.FavoritesRepository;
import restaurant.repository.ReservationsRepository;
import restaurant.repository.ReviewRepository;
import restaurant.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class UserService {
	private final UserRepository uRepository;
	private final FavoritesRepository fRepository;
	private final ReservationsRepository rsvRepository;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	private final ReviewRepository reviewRepository;
	
	
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
	
	@Transactional
	public void updateRsv(Reservations reservations) throws ParseException {
		Reservations rsv = rsvRepository.findById(reservations.getId()).get();
		rsv.setPeopleCnt(reservations.getPeopleCnt());
		rsv.setMsg(reservations.getMsg());
		String str = reservations.getRsvDate() + " " + reservations.getRsvTime();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		rsv.setRsvDateTime(sdf.parse(str));
//		rsv.setRsvDate(reservations.getRsvDate());
//		rsv.setRsvTime(reservations.getRsvTime());
		rsvRepository.save(rsv);
	}
	
	public void cancelRsv(Long rsvid) {
		rsvRepository.deleteById(rsvid);
	}
	@Transactional
	public Long like(Favorites favorite) {
		if(fRepository.isExist(favorite.getUser().getId(), favorite.getRestaurant().getId())==null) {
			fRepository.save(favorite);
			return 1L;
		} else {
			System.out.println("test");
			fRepository.delete(favorite.getUser().getId(), favorite.getRestaurant().getId());
			return 0L;
		}
	}
	@Transactional
	public void fDelete(Long fid) {
		fRepository.deleteById(fid);
	}
	public Reservations nearestRsv(Long id) {
		return rsvRepository.nearestRsv(id);
	}
	
	public Favorites findLike(Long user_id, Long restaurant_id) {
		return fRepository.isExist(user_id, restaurant_id);
	}
	

	 @Transactional 
	 public void review(Review reviews, MultipartFile f, HttpSession session) {
		 UUID uuid = UUID.randomUUID();
		 if(f!=null) {
			 String uploadFolder = session.getServletContext().getRealPath("/") + "reviewImg";
			 String uploadFileName = uuid.toString() + "_" + f.getOriginalFilename();
			 File saveFile = new File(uploadFolder, uploadFileName);
			 try {
				 f.transferTo(saveFile);
				 reviews.setThumImage("\\reviewImg\\"+uploadFileName);
			 } catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		 }
		 reviewRepository.save(reviews);
	 }
}