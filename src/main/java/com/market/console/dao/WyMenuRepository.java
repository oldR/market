package com.market.console.dao;

import com.market.console.model.WyCategory;
import com.market.console.model.WyMenu;
import com.market.console.model.WyMenuDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * <p>
 *
 * </p>
 * Copyright (C) 2018 R. All Rights Reserved.
 *
 * @author xinhe.REN (Create on:2018年05月09日)
 * @version 1.0
 */
public interface WyMenuRepository extends JpaRepository<WyMenu,Long> {

    @Query("from WyMenu a where a.id=:id")
    WyMenu findMarketById(@Param("id") Long id);

    @Query(value="select * from wy_menu t where t.parent_id = 0 and t.use_yn = 1", nativeQuery = true)
    List<WyMenu> findMenuByChildren();

    @Query(value="select * from wy_menu t", nativeQuery = true)
    List<Object[]> findMenu();
}
