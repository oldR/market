package com.market.console.dao;

import com.market.console.model.WyMarket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
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
public interface WyMarketRepository extends JpaRepository<WyMarket,Long> {

    @Query("from WyMarket a where a.id=:id")
    WyMarket findMarketById(@Param("id") Long id);

    @Query("from WyMarket a where a.bDate>=:bdate and a.bDate<=:edate")
    List<WyMarket> findMarketByBdate(@Param("bdate") Date bdate,@Param("edate") Date edate);
}
