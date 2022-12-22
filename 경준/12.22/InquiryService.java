package restaurant.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import restaurant.model.Inquiry;

import restaurant.model.Response;
import restaurant.model.User;
import restaurant.repository.InquiryRepository;
import restaurant.repository.ResponseRepository;

@Service
@RequiredArgsConstructor
public class InquiryService {
	
	private final InquiryRepository iRepository;
	
	private final ResponseRepository rspRepository;
	
	@Transactional
	public void writeQna(Inquiry inquiry, User user) {
		inquiry.setUser(user);
		iRepository.save(inquiry);
	}
	
	public Page<Inquiry> findByUser_id(Long id, Pageable pageable) {
		Page<Inquiry> lists = iRepository.findByUser_id(id, pageable);
		return lists;
	}
	public List<Inquiry> findAll() {
		return iRepository.findAll();
	}
	public Page<Inquiry> findAll(Pageable pageable, String field, String word) {
		Page<Inquiry> qlists = iRepository.findAll(pageable);
		if(field.equals("title")) {
			qlists = iRepository.userSearch(pageable, word);
		}
		return qlists;
	}
	public Long countQna(String field, String word) {
		Long count = iRepository.count();
		if(field.equals("title")) {
			count = iRepository.cntUserSearch(word);
		}
		return count;
	}
	
	public Inquiry findById(Long id) {
		return iRepository.findById(id).get();
	}

	public void updateReply(Long id) {
		iRepository.updateReply(id);
	}
	
	public void responseInsert(Response response) {
		rspRepository.save(response);
	}
	
	public void deleteQna(Long id) {
		iRepository.deleteById(id);
	}
	

}