package restaurant.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.service.RestaurantService;
import restaurant.service.UserService;

@Controller
@RequestMapping("/restaurant/*")
@RequiredArgsConstructor
public class RestaurantController {
	private final RestaurantService rService;
	private final UserService uService;
	@GetMapping("/list")
	public String list(String word, Model model) {
		model.addAttribute("restaurantList",rService.findAll());
		return "/restaurant/list";
	}
	@GetMapping("view/{rnum}")
	public String view(@PathVariable Long rnum,
						Model model, @AuthenticationPrincipal PrincipalDetails p) {
		model.addAttribute("restaurant", rService.view(rnum));
		model.addAttribute("findLike", uService.findLike(p.getUser().getId(), rnum));
		return "/restaurant/detail";
	}

}