package com.market.console.controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.market.console.common.AjaxJson;
import com.market.console.model.WyCategory;
import com.market.console.model.WyMarket;
import com.market.console.common.Menu;
import com.market.console.common.PageModel;
import com.market.console.model.WyMenu;
import com.market.console.model.WyMenuDto;
import com.market.console.service.WyCategoryService;
import com.market.console.service.WyMarketService;
import com.market.console.service.WyMenuService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import sun.misc.IOUtils;

import javax.annotation.Resource;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * <p>
 * 魏永市场送货信息Controller
 * </p>
 * Copyright (C) 2018 R. All Rights Reserved.
 *
 * @author xinhe.REN (Create on:2018年10月23日)
 * @version 1.0
 */
@RestController
public class MarketDeliveryController {

    @Resource
    private org.springframework.core.io.Resource resource;
    @Resource
    private WyCategoryService wyCategoryService;

    @Resource
    private WyMenuService wyMenuService;
    @Resource
    private WyMarketService wyMarketService;
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
    private Gson gson = new Gson();

    @GetMapping("/")
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView("console/index");
        /*String str = new String(IOUtils.readFully(resource.getInputStream(), -1, true), "UTF-8");
        Gson gson = new Gson();*/
        List<WyMenu> menuByCateSort = wyMenuService.findMenuByCateSort();
        menuByCateSort.forEach(x->{
            x.getChildren().sort(new Comparator<WyMenu>() {
                @Override
                public int compare(WyMenu o1, WyMenu o2) {
                    return o1.getIsSort().compareTo(o2.getIsSort());
                }
            });
        });
        modelAndView.addObject("menu", menuByCateSort);
        return modelAndView;
    }

    @GetMapping("/welcome")
    public ModelAndView welcome() {
        return new ModelAndView("console/welcome");
    }

    @GetMapping("/login")
    public ModelAndView login() {
        return new ModelAndView("console/login");
    }

    @GetMapping("/menuView")
    public ModelAndView menu() {
        return new ModelAndView("sys/menuView");
    }

    @GetMapping("/menuJson")
    public String menuJson() {
        Map<String,Object> resultMap = new HashMap<>();
        List<WyMenuDto> menuByCateSort = wyMenuService.findMenu();
        menuByCateSort.sort(new Comparator<WyMenuDto>() {
            @Override
            public int compare(WyMenuDto o1, WyMenuDto o2) {
                return o1.getIsSort().compareTo(o2.getIsSort());
            }
        });
        resultMap.put("data",menuByCateSort);
        resultMap.put("code",0);
        String str = gson.toJson(resultMap);
        return str;
    }

    @GetMapping("/listView")
    public ModelAndView login(WyMarket market) {
        ModelAndView modelAndView = new ModelAndView("md/listView");
        modelAndView.addObject("searchForm",market);
        PageModel<WyMarket> wyMarketPage = wyMarketService.pageQuery(market);
        modelAndView.addObject("marketList",wyMarketPage);
        return modelAndView;
    }

    @GetMapping("/addView")
    public ModelAndView addView(@RequestParam(value = "id",defaultValue = "-1",required = false) Long id){
        ModelAndView modelAndView = new ModelAndView("md/addView");
        modelAndView.addObject("category",wyCategoryService.findCategoryByCateSort());
        modelAndView.addObject("market",wyMarketService.findMarketById(id));
        return modelAndView;
    }

    @PostMapping("/add")
    public AjaxJson add(WyMarket market){
        wyMarketService.saveOrUpdate(market);
        return new AjaxJson();
    }

    @PostMapping("/delete")
    public AjaxJson delete(Long id){
        wyMarketService.deleteNews(id);
        return new AjaxJson();
    }

    @GetMapping("/echarts")
    public ModelAndView echarts(String bDate){
        ModelAndView modelAndView = new ModelAndView("md/echartsView");
        List<WyCategory> categoryList = wyCategoryService.findCategoryByCateSort();
        if(bDate == null)
            bDate = sdf.format(new Date());
        Map<String,Object> dataMap = wyMarketService.findMarketByBdate(bDate);
        Map<String,Object> resultMap = new HashMap<>();
        resultMap.put("text",bDate);
        resultMap.put("data",dataMap);
        modelAndView.addObject("category",gson.toJson(categoryList));
        modelAndView.addObject("dataMap",gson.toJson(dataMap));
        modelAndView.addObject("bDate",bDate);
        return modelAndView;
    }

}
