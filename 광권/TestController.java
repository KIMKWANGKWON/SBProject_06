package restaurant.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import restaurant.model.Menu;
import restaurant.model.Restaurant;
import restaurant.repository.MenuRepository;
import restaurant.repository.RestaurantRepository;

@RestController
@RequestMapping("/test/*")
@RequiredArgsConstructor
public class TestController {
	private final RestaurantRepository rRepository;
	private final MenuRepository mRepository;
	
	@PostMapping("menuInsert")
	public String menuInsert(@RequestBody List<Menu> menus) {
		List<Restaurant> retrs = rRepository.findAll();
		HashMap<String,Long> mapper = new HashMap<>();
		for(Restaurant retr : retrs) {
			mapper.put(retr.getBusinessNum(),retr.getId() );
		}
		for(Menu menu : menus) {
			menu.getRestaurant().setId(mapper.get(menu.getRestaurant().getBusinessNum()));
		}
		mRepository.saveAll(menus);
		return "success";
	}
	@PostMapping("menuSetPrice")
	public String menuSetPrice(List<String> bNums,List<Long> prices) {
		List<Restaurant> retrs = rRepository.findAll();
		
		return "success";
	}
	@PostMapping("rstrInsert")
	@Transactional
	public String rstrInsert(@RequestBody List<Restaurant> rstrs) {
		rRepository.saveAll(rstrs);
		return "success";
	}
	@PostMapping("rstrImgInsert")
	@Transactional
	public String rstrImgInsert(@RequestBody List<Restaurant> rstrs) {
		for(Restaurant rstr : rstrs) {
			Restaurant loaded = rRepository.findByBusinessNum(rstr.getBusinessNum());
			loaded.setThumImage(rstr.getThumImage());
		}
		return "success";
	}
}
