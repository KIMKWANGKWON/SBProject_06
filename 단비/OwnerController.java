package restaurant.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.annotations.Parameter;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Restaurant;
import restaurant.service.RestaurantService;

@Controller
@RequestMapping("/owner/*")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ROLE_OWNER')")
public class OwnerController {
	private final RestaurantService rService;
	
	//식당추가폼
	@GetMapping("/register")
	public String register() {
		return "/owner/register";
	}
	//식당추가
	@PostMapping("/register")
	@ResponseBody
	public Long register(@RequestBody Restaurant restaurant,
						 @AuthenticationPrincipal PrincipalDetails p) {
		//로그인된 사업자를 restaurant에 포함해야함.
		rService.register(restaurant,p);
		return restaurant.getId();
	}
	
	//수정폼
	@GetMapping("/update/{rid}")
	public String update(@PathVariable Long rid,Model model) {
		model.addAttribute("restaurant",rService.view(rid));
		return "/owner/update";
	}
	//수정진행
	@PutMapping("/update")
	@ResponseBody
	public String update(@RequestPart(value ="restaurant") Restaurant restaurant,
						 @RequestPart(value = "file",required = false) List<MultipartFile> files,
						 HttpSession session) {
		rService.update(restaurant,files,session);
		return "success";
	}
	
	//수정목록
	@GetMapping("/restaurantList/{oid}")
	public String restaurantList(@PathVariable Long oid,
								Model model) {
		model.addAttribute("restaurantList",rService.findByOid(oid));
		return "/owner/restaurantList";
	}
	
	//개시설정
	@PutMapping("/setEnable")
	@ResponseBody
	public String setEnable(Long id,@RequestParam boolean enabled) {
		System.out.println(id);
		rService.setEnabled(id, enabled);
		return "success";
	}
	
	//가게 폐업
	@DeleteMapping("close/{rid}")
	@ResponseBody
	public String close(@PathVariable Long rid) {
		rService.rDelete(rid);
		return "";
	}
}
