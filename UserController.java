package restaurant.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import restaurant.model.Reservations;
import restaurant.model.Restaurant;
import restaurant.model.User;
import restaurant.repository.UserRepository;
import restaurant.service.RestaurantService;
import restaurant.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	private UserService uService;
	
	@Autowired
	private UserRepository uRepository;
	
	@Autowired
	private RestaurantService rService;
	
	@GetMapping("join")
	private String join() {
		return "/user/join";
	}
	
	@PostMapping("join")
	@ResponseBody
	public String join(@RequestBody User user) {
		if(uRepository.findByUsername(user.getUsername())!=null) {
			return "fail";
		}
		uService.join(user);
		return "success";
	}
	
	@GetMapping("favorites/{user_id}")
	public String favorite(@PathVariable Long user_id, Model model) {
		model.addAttribute("favorites", uService.findByUser_id(user_id));
		return "/user/favorites";
	}
	
	@GetMapping("reservationForm/{rid}")
	public String reservationForm(@PathVariable Long rid, Model model) {
		model.addAttribute("restaurant", rService.view(rid));
		return "/user/reservationForm";
	}
	
	@PostMapping("reservation/{rid}")
	@ResponseBody
	public String reservation(@RequestBody Reservations reservations, @PathVariable Long rid) {
		uService.reservation(reservations, rid);
		return "success";
	}
	
	@GetMapping("reservationList")
	public String reservationList() {
		return "/user/reservationList";
	}
}