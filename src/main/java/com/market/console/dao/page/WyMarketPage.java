package com.market.console.dao.page;

import com.market.console.model.WyMarket;
import com.market.console.common.BaseSqlDaoImpl;
import com.market.console.common.PageModel;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *
 * </p>
 * Copyright (C) 2018 R. All Rights Reserved.
 *
 * @author xinhe.REN (Create on:2018年05月09日)
 * @version 1.0
 */
@Service
public class WyMarketPage extends BaseSqlDaoImpl {

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public PageModel<WyMarket> queryWyMarketPage(WyMarket market) {
        Map<String, Object> map = new HashMap<>();
        StringBuilder hql = new StringBuilder();
        String startTime = "", endTime = "";
        hql.append("select t from WyMarket t where 1=1 ");
        if (market.getStorefront() != null) {
            hql.append(" and t.storefront like :storefront");
            map.put("storefront", "%" + market.getStorefront() + "%");
        }
        try {
            if (StringUtils.isNotBlank(market.getStartTime())) {
                String[] times = market.getStartTime().split(" - ");
                startTime = times[0];
                endTime = times[1];
            }
            if (StringUtils.isNotBlank(startTime)) {
                hql.append(" and t.bDate >= :startTime ");
                map.put("startTime", sdf.parse(startTime));
            }

            if (StringUtils.isNotBlank(endTime)) {
                hql.append(" and t.bDate <= :endTime ");
                map.put("endTime", sdf.parse(endTime));
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        hql.append(" order by t.bDate desc ");
        return this.queryForPageWithParams(hql.toString(), map, market.getCurrentPage(), market.getPageSize());
    }
}
