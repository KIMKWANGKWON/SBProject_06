package restaurant.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import restaurant.model.PageRequest;
import restaurant.model.Restaurant;
import restaurant.service.AdminService;

@Controller
@RequestMapping("/admin/")
@RequiredArgsConstructor
@PreAuthorize("isAuthenticated()")
public class AdminController {
	
	private final AdminService aService;
	
	@GetMapping("memberList")
	public String memberList(PageRequest pageRequest,Model model) {
		model.addAttribute("mPage", aService.findUser(pageRequest.of()));
		return "/admin/memberList";
	}
	
//	@GetMapping("restaurantList")
//	public String restaurantList(Model model) {
//		model.addAttribute("restaurant", aService.findRestaurant());
//		model.addAttribute("count", aService.countRestaurant());
//		return "/admin/restaurantList";
//	}
	
	@GetMapping("restaurantList")
	public String restaurantList(Model model, 
								 @PageableDefault(size = 5, sort = "id", direction = Direction.DESC) Pageable pageable,
								 @RequestParam(required = false, defaultValue = "") String field,
								 @RequestParam(required = false, defaultValue = "") String word) {
		Page<Restaurant> rlists = aService.findRestaurant(pageable, field, word);
		Long count = aService.countRestaurant(field, word);
		model.addAttribute("restaurant", rlists);
		model.addAttribute("count", count);
		return "/admin/restaurantList";
	}
	
	@GetMapping("memberView/{id}")
	public String memberView(@PathVariable Long id, Model model) {
		model.addAttribute("member", aService.viewUser(id));
		return "/admin/memberView";
	}
	
	@DeleteMapping("memberDelete/{id}")
	@ResponseBody
	public String memberDelete(@PathVariable Long id) {
		aService.deleteUser(id);
		return "success";
	}
	
	@GetMapping("restaurantView/{id}")
	public String restaurantView(@PathVariable Long id, Model model) {
		model.addAttribute("restaurant", aService.viewRestaurant(id));
		return "/admin/restaurantView";
	}
	
	@DeleteMapping("restaurantDelete/{id}")
	@ResponseBody
	public String restaurantDelete(@PathVariable Long id) {
		aService.deleteRestaurant(id);
		return "success";
	}
}