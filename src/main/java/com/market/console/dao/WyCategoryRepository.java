package com.market.console.dao;

import com.market.console.model.WyCategory;
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
public interface WyCategoryRepository extends JpaRepository<WyCategory,Long> {

    @Query("from WyCategory a where a.id=:id")
    WyCategory findMarketById(@Param("id") Long id);

    @Query("from WyCategory a order by cateSort")
    List<WyCategory> findCategoryByCateSort();
}
