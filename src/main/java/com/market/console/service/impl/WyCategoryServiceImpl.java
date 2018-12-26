package com.market.console.service.impl;

import com.market.console.dao.WyCategoryRepository;
import com.market.console.model.WyCategory;
import com.market.console.service.WyCategoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;


/**
 * <p>
 * 新闻service
 * </P>
 * Copyright (C) 2018 R. All Rights Reserved.
 *
 * @author xinhe.REN (Create on:2018年05月09日)
 * @version 1.0
 */
@Service
public class WyCategoryServiceImpl implements WyCategoryService {

    @Resource
    private WyCategoryRepository wyCategoryRepository;

    @Override
    public List<WyCategory> findCategoryByCateSort() {
        return wyCategoryRepository.findCategoryByCateSort();
    }
}
