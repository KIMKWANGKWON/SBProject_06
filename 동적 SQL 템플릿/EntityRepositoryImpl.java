package restaurant;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.jpa.impl.JPAQueryFactory;

import restaurant.model.QMenu;
import restaurant.model.QRestaurant;
import restaurant.model.Restaurant;

public class EntityRepositoryImpl implements EntityRepositoryCustom{
	private final JPAQueryFactory queryFactory;

	@Override
	public Page<Restaurant> searchWithCustom(String keyword,String order,Pageable pageable) {
		BooleanBuilder builder = new BooleanBuilder();
		QRestaurant restaurant = QRestaurant.restaurant;
		QMenu menu = QMenu.menu;
		OrderSpecifier<?> orderSpec;
		switch(order) { //정렬 설정
		case "recent" : orderSpec = restaurant.regdate.desc();	break;
		case "popular" : orderSpec = restaurant.readCount.desc();	break;
		default : orderSpec = restaurant.regdate.desc();
		}
		builder.and(restaurant.enabled.isTrue());
		if(!keyword.equals("")) {
			builder.and(
					(restaurant.name.containsIgnoreCase(keyword)) //식당명 검색
					.or((restaurant.id.eq(menu.restaurant.id)).and(menu.name.containsIgnoreCase(keyword))) //식당 메뉴 이름
					.or(restaurant.description.containsIgnoreCase(keyword))); //가게 설명
		}
		System.out.println(pageable.getOffset() + "" + pageable.getPageSize());
		QueryResults<Restaurant> results = queryFactory.selectDistinct(restaurant)
				.from(restaurant)
				.leftJoin(restaurant.menuList, menu)
				.where(builder)
				.orderBy(orderSpec)
				.offset(pageable.getOffset())
				.limit(pageable.getPageSize())
				.fetchResults();
	      return new PageImpl<>(results.getResults(),pageable,results.getTotal());
	}
}
