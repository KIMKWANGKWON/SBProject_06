package restaurant.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Restaurant;
import restaurant.repository.FavoritesRepository;
import restaurant.repository.MenuRepository;
import restaurant.repository.RestaurantRepository;

@Service
@RequiredArgsConstructor
public class RestaurantService {
	private final RestaurantRepository restaurantRepository;
	private final MenuRepository menuRepository;
	private final FavoritesRepository fRepository;
	
	public HashMap<Long,Long> getFavoritesMap(Long uid){
		HashMap<Long,Long> hm = new HashMap<>();
		List<Long> li = fRepository.getMap(uid);
		for(Long rid : li) {
			hm.put(rid, uid);
		}
		return hm;
	}
	
	@Transactional
	public void setEnabled(Long id,boolean enabled) {
		restaurantRepository.getById(id).setEnabled(enabled);
		
	}
	public List<Restaurant> popularList(){
		return restaurantRepository.popularList();
	}
	public List<Restaurant> recentList(){
		return restaurantRepository.recentList();
	}
	@Transactional
	public Restaurant view(Long rnum) {
		Restaurant loaded = restaurantRepository.getById(rnum);
		loaded.setReadCount(loaded.getReadCount() + 1);
		return loaded;
	}

	public List<Restaurant> findAll() {
		return restaurantRepository.findAllByEnabled(true);
	}
	public List<Restaurant> findByOid(Long oid){
		return restaurantRepository.findAllByOwner_id(oid);
	}
	@Transactional
	public Long register(Restaurant restaurant,PrincipalDetails p) {
		restaurant.setOwner(p.getUser());
		restaurantRepository.save(restaurant);
		return restaurant.getId();
	}

	@Transactional
	public void update(Restaurant restaurant, List<MultipartFile> files, HttpSession session) {
		Restaurant loaded = restaurantRepository.findById(restaurant.getId()).get();
		String uploadFolder;
		UUID uuid = UUID.randomUUID();
		MultipartFile f = files.get(0);
		if (!f.getOriginalFilename().equals("empty")) {
			uploadFolder = session.getServletContext().getRealPath("/") + "restaurantImg";
			String uploadFileName = uuid.toString() + "_" + f.getOriginalFilename();
			File saveFile = new File(uploadFolder, uploadFileName);
			try {
				f.transferTo(saveFile);
				restaurant.setThumImage("\\restaurantImg\\" + uploadFileName);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			restaurant.setThumImage(loaded.getThumImage());
		}
		uploadFolder = session.getServletContext().getRealPath("/") + "menuImg";
		for (int i = 1; i < files.size(); i++) {
			f = files.get(i);
			if (!f.getOriginalFilename().equals("empty")) {
				String uploadFileName = "";
				uploadFileName = uuid.toString() + "_" + f.getOriginalFilename();
				File saveFile = new File(uploadFolder, uploadFileName);
				try {
					f.transferTo(saveFile);
					restaurant.getMenuList().get(i - 1).setImg("\\menuImg\\" + uploadFileName);
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				if(i <= loaded.getMenuList().size())
				restaurant.getMenuList().get(i - 1).setImg(loaded.getMenuList().get(i - 1).getImg());
			}
		}
		loaded.copy(restaurant);
		menuRepository.saveAll(restaurant.getMenuList());
	}
	
	//가게 폐업
	public void rDelete(Long rid) {
		restaurantRepository.deleteById(rid);
	}
//	public List<Restaurant> search(){
//		return restaurantRepository.search();
//	}
}
