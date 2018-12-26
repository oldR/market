package com.market.console.service;

import com.market.console.model.WyCategory;
import com.market.console.model.WyMenu;
import com.market.console.model.WyMenuDto;

import java.util.List;


/**
 * <p>
 *
 * </P>
 * Copyright (C) 2018 R. All Rights Reserved.
 *
 * @author xinhe.REN (Create on:2018年05月09日)
 * @version 1.0
 */
public interface WyMenuService {

    List<WyMenu> findMenuByCateSort();

    List<WyMenuDto> findMenu();
}
