package restaurant.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.RequiredArgsConstructor;
import restaurant.model.Restaurant;
import restaurant.service.RestaurantService;


@Controller
@RequiredArgsConstructor
public class TestController {
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
	public String register(Restaurant restaurant) {
		restaurantService.register(restaurant);
		return "/owner/update";
	}
}
