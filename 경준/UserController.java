package restaurant.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Favorites;
import restaurant.model.Reservations;
import restaurant.model.User;
import restaurant.repository.UserRepository;
import restaurant.service.RestaurantService;
import restaurant.service.UserService;

@Controller
@RequestMapping("/user/*")
@RequiredArgsConstructor
public class UserController {
	//주입
	private final UserService uService;
	
	//회원가입
	@GetMapping("join")
	private String join() {
		return "/user/join";
	}
	@PostMapping("join")
	@ResponseBody
	public String join(@RequestBody User user) {
		return uService.join(user);
	}
	
	//마이페이지
	@GetMapping("mypage/{id}")
	public String mypage(@PathVariable Long id,Model model) {
		model.addAttribute("user",uService.view(id));
		model.addAttribute("rsv",uService.nearestRsv(id));
		return "/user/mypage";
	}
	
	//나의 상세 정보
	@GetMapping("view/{id}")
	public String view(@PathVariable Long id, Model model) {
		System.out.println("id"+id);
		model.addAttribute("user", uService.view(id));
		return "/user/view";
	}
		
	//내 정보 수정
	@GetMapping("update/{id}")
	public String update(@PathVariable Long id, Model model) {
		model.addAttribute("user", uService.view(id));
		return "/user/update";
	}
	@PutMapping("update")
	@ResponseBody
	public String update(@RequestBody User user, HttpSession session) {
		uService.update(user);
		session.invalidate();
		return "success";
	}
	
	//회원 탈퇴
	@DeleteMapping("delete/{id}")
	@ResponseBody
	public String delete(@PathVariable Long id, HttpSession session) {
		uService.delete(id);
		session.invalidate();
		return "success";
	}
	
	//좋아요 ON,OFF
	@PostMapping("like")
	@ResponseBody
	public Long like(@RequestBody Favorites favorite) {
		return uService.like(favorite);
		
	}
	
	//좋아요 목록
	@GetMapping("favorites/{user_id}")
	public String favorite(@PathVariable Long user_id, Model model) {
		model.addAttribute("favorites", uService.findByUser_id(user_id));
		return "/user/favorites";
	}
	
	//좋아요 삭제
	@DeleteMapping("dislike/{fid}")
	@ResponseBody
	public String dislike(@PathVariable Long fid) {
		uService.fDelete(fid);
		return "";
	}
	
}