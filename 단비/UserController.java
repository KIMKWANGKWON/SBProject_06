package restaurant.controller;


import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import restaurant.config.auth.PrincipalDetails;
import restaurant.model.Comment;
import restaurant.model.Favorites;
import restaurant.model.Review;
import restaurant.model.User;
import restaurant.service.UserService;

@Controller
@RequestMapping("/user/*")
@RequiredArgsConstructor
@PreAuthorize("isAuthenticated()")
public class UserController {
	//주입
	private final UserService uService;
	
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
	public String favorite(@PathVariable Long user_id, Model model,
						   @PageableDefault(size=1, page = 0, direction = Direction.DESC)Pageable pageable, 
						   @AuthenticationPrincipal PrincipalDetails p) {
		Page<Favorites> lists = uService.findAll(p.getUser().getId(), pageable);
		
		model.addAttribute("favorites", lists);
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
	 public String review(@RequestPart Review review, @RequestPart(required = false) MultipartFile file, HttpSession session, @AuthenticationPrincipal PrincipalDetails p) { 
		 uService.review(review, file, session);
		 return "";
		 }
	 //리뷰 삭제
	 @DeleteMapping("reviewDelete/{id}")
	 @ResponseBody
	 public String reviewDelete(@PathVariable Long id) {
		 uService.reviewDelete(id);
		 return "success";
	}
	 //내 리뷰보기
	 @GetMapping("userReview/{user_id}")
	 public String userReview(@PathVariable Long user_id, Model model) {
		 model.addAttribute("userReview", uService.findByUserReview(user_id));
		 return "/user/userReview";
	 }
	 // 후기의 후기 등록
	 @Transactional
	 @PostMapping("commentInsert/{id}")
	 @ResponseBody
	 public String commentInsert(@RequestBody Comment comment, 
			 					 @PathVariable Long id,
			 					 @AuthenticationPrincipal PrincipalDetails p) {
		 
		 Review r = new Review();
		 r.setId(id);
		 comment.setReview(r);
		 comment.setOwner(p.getUser());
		 uService.commentInsert(comment);
		
		 return "success";
	 }
}