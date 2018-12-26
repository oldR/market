package com.market.console.service;

import com.market.console.model.WyMarket;
import com.market.console.common.PageModel;

import java.util.Map;


/**
 * <p>
 *
 * </P>
 * Copyright (C) 2018 R. All Rights Reserved.
 *
 * @author xinhe.REN (Create on:2018年05月09日)
 * @version 1.0
 */
public interface WyMarketService {

    PageModel<WyMarket> pageQuery(WyMarket news);

    void deleteNews(Long id);

    void saveOrUpdate(WyMarket news);

    WyMarket findMarketById(Long id);

    Map<String,Object> findMarketByBdate(String bdate);
}
