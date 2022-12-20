package restaurant.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Favorites;
import restaurant.model.Restaurant;
import restaurant.model.Review;
import restaurant.model.User;
import restaurant.service.UserService;

@Controller
@RequestMapping("/user/*")
@RequiredArgsConstructor
public class UserController {
	//주입
	private final UserService uService;
	private final AuthenticationManager authenticationManager;
	
	//로그인
	@PostMapping("login")
	@ResponseBody
    public String customLoginProcess(
            @RequestParam String username,
            @RequestParam String password
    ) {
        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);
        try {
            // AuthenticationManager 에 token 을 넘기면 UserDetailsService 가 받아 처리하도록 한다.
            Authentication authentication = authenticationManager.authenticate(token);
            // 실제 SecurityContext 에 authentication 정보를 등록한다.
            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (Exception e) {
            String status;
            if (e.getClass().equals(BadCredentialsException.class)) {
                status = "비밀번호가 잘못되었습니다.";
            } else if (e.getClass().equals(DisabledException.class)) {
                status = "사용할 수 없는 계정입니다.";
            } else if (e.getClass().equals(LockedException.class)) {
                status = "사용할 수 없는 계정입니다.";
            } else if (e.getClass().equals(InternalAuthenticationServiceException.class)){
                status = "내부 로그인 서비스 에러입니다.";
            } else {
            	status = "Unknown Error";
            }
            return status;
        }
        return "success";
    }
	
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
	
	//레스토랑 디테일 리뷰 리스트
	@GetMapping("review/{rid}")
	public String review(@PathVariable Long rid, Model model) {
		model.addAttribute("rid", rid);
		return "/user/review";
	}
	
	//리뷰 작성
	 @PostMapping("review")
	 @ResponseBody 
	 public String review(@RequestPart Review review, @RequestPart MultipartFile file, HttpSession session, @AuthenticationPrincipal PrincipalDetails p) { 
		 uService.review(review, file, session);
		 return "";
		 }
	 
	 //내 리뷰보기
	 @GetMapping("userReview/{user_id}")
	 public String userReview(@PathVariable Long user_id, Model model) {
		 model.addAttribute("userReview", uService.findByUserReview(user_id));
		 return "/user/userReview";
	 }
	
}