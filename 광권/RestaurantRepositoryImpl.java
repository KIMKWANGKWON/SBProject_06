package restaurant.repository;

import java.util.ArrayList;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.jpa.impl.JPAQueryFactory;

import lombok.RequiredArgsConstructor;
import restaurant.model.QMenu;
import restaurant.model.QRestaurant;
import restaurant.model.Restaurant;

@Repository
@RequiredArgsConstructor
public class RestaurantRepositoryImpl implements RestaurantRepositoryCustom{ //네이밍으로 QueryDsl이 인식해서 중요함.
	private final JPAQueryFactory queryFactory; //config에서 저장해준 JPAQueryFactory 들고 옴.

	@Override
	public Page<Restaurant> searchWithCustom(String keywords,String order,Pageable pageable) {
		BooleanBuilder builder = new BooleanBuilder(); //검색 조건 빌더
		QRestaurant restaurant = QRestaurant.restaurant; //Restaurant테이블의 QueryDsl식 클래스
		QMenu menu = QMenu.menu; //Menu테이블의 QueryDsl식 클래스
		OrderSpecifier<?> orderSpec; //정렬 자료형
		switch(order) { //받아온 order에 따라 정렬을 설정함.
		case "recent" : orderSpec = restaurant.regdate.desc();	break; //order가 recent면 regdate를 desc로 정렬.
		case "popular" : orderSpec = restaurant.readCount.desc();	break;
		default : orderSpec = restaurant.regdate.desc(); //디폴트 정렬값
		}
		
		String keywordArray[] = keywords.split(" ");
		builder.and(restaurant.enabled.isTrue());
		BooleanBuilder builderKey = new BooleanBuilder();
		for(String keyword : keywordArray) {
			builderKey.and(
					(
					restaurant.name.containsIgnoreCase(keyword)) //식당명 검색
					.or(restaurant.address.containsIgnoreCase(keyword)) //주소 검색
					.or((restaurant.id.eq(menu.restaurant.id)).and(menu.name.containsIgnoreCase(keyword).or(menu.description.containsIgnoreCase(keyword)))) //식당 메뉴 이름
					.or(restaurant.description.containsIgnoreCase(keyword))
					);
		}
		builder.and(builderKey);
		QueryResults<Restaurant> results = queryFactory.selectDistinct(restaurant) //중복없이 Restaurant값 불러옴.
				.from(restaurant) //Restaurant 테이블에서.
				.leftJoin(restaurant.menuList, menu) //Menu테이블과 Left Out Join을 함.
				.where(builder) //설정한 조건 반영
				.orderBy(orderSpec) //설정한 정렬 반영
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
		System.out.println("Offset : " + pageable.getOffset());
		return new PageImpl<>(results.getResults(),pageable,results.getTotal());
	}
}
