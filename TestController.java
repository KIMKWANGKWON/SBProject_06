package restaurant.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.RequiredArgsConstructor;
import restaurant.model.Restaurant;
import restaurant.service.RestaurantService;
import restaurant.service.UserService;


@Controller
@RequiredArgsConstructor
public class TestController {
	private final UserService userService;
	private final RestaurantService restaurantService;
	@GetMapping("/")
	public String home() {
		return "test";
	}
	@GetMapping("/restaurant/view/{rnum}")
	public String view(@PathVariable Long rnum,
						Model model) {
		model.addAttribute("restaurant", restaurantService.view(rnum));
		return "/restaurant/detail";
	}
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("restaurantList",restaurantService.findAll());
		return "/restaurant/list";
	}
	@GetMapping("/owner/update")
	public String update() {
		return "/owner/update";
	}
	@GetMapping("/owner/restaurantList")
	public String restaurantList() {
		return "/owner/restaurantList";
	}
	@GetMapping("/owner/register")
	public String register() {
		return "/owner/register";
	}
	@PostMapping("/owner/register")
	public String register(@RequestBody Restaurant restaurant) {
		restaurantService.register(restaurant);
		return "/owner/update";
	}
	@GetMapping("/user/favorite/{user_id}")
	public String favorite(@PathVariable Long user_id, Model model) {
		model.addAttribute("favorites", userService.findByUser_id(user_id));
		return "/user/favorite";
	}
}
