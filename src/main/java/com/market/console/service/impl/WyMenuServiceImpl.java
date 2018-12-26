package com.market.console.service.impl;

import com.market.console.dao.WyCategoryRepository;
import com.market.console.dao.WyMenuRepository;
import com.market.console.model.WyCategory;
import com.market.console.model.WyMenu;
import com.market.console.model.WyMenuDto;
import com.market.console.service.WyCategoryService;
import com.market.console.service.WyMenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.List;


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
public class WyMenuServiceImpl implements WyMenuService {

    @Resource
    private WyMenuRepository wyMenuRepository;

    @Override
    public List<WyMenu> findMenuByCateSort() {
        return wyMenuRepository.findMenuByChildren();
    }

    @Override
    public List<WyMenuDto> findMenu() {
        List<Object[]> menu = wyMenuRepository.findMenu();
        try {
            return castEntity(menu, WyMenuDto.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //转换实体类
    private static <T> List<T> castEntity(List<Object[]> list, Class<T> clazz) throws Exception {
        List<T> returnList = new ArrayList<T>();
        Object[] co = list.get(0);
        Class[] c2 = new Class[co.length];

        //确定构造方法
        for (int i = 0; i < co.length; i++) {
            c2[i] = co[i].getClass();
        }

        for (Object[] o : list) {
            Constructor<T> constructor = clazz.getConstructor(c2);
            returnList.add(constructor.newInstance(o));
        }

        return returnList;
    }
}
