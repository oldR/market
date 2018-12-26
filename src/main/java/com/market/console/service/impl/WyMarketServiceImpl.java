package com.market.console.service.impl;

import com.market.console.aop.MyAop;
import com.market.console.dao.WyMarketRepository;
import com.market.console.dao.page.WyMarketPage;
import com.market.console.model.WyMarket;
import com.market.console.common.Constant;
import com.market.console.common.PageModel;
import com.market.console.service.WyMarketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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
public class WyMarketServiceImpl implements WyMarketService {

    @Autowired
    private WyMarketRepository myMarketRepository;
    @Autowired
    private WyMarketPage newsPage;

    @Override
    public PageModel<WyMarket> pageQuery(WyMarket news) {
        return newsPage.queryWyMarketPage(news);
    }

    @Override
    public void deleteNews(Long id) {
        myMarketRepository.deleteById(id);
    }


    @Override
    public void saveOrUpdate(WyMarket news) {
        myMarketRepository.save(news);
    }

    @Override
    public WyMarket findMarketById(Long id) {
        WyMarket myMarket = myMarketRepository.findMarketById(id);
        if(myMarket == null){
            return new WyMarket();
        }
        return myMarket;
    }

    public static void main(String[] args) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date now = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(now);

        c.set(Calendar.DAY_OF_YEAR, 1);
        System.out.println(sdf.format(c.getTime())); // 第一天
        c.add(Calendar.YEAR, 1);
        c.set(Calendar.DAY_OF_YEAR, 0);
        System.out.println(sdf.format(c.getTime())); // 最后一天
        Map<Integer,Object> pi = new TreeMap<>();
        Map<Integer,Object> si = new TreeMap<>();
        Map<Integer,Object> ti = new TreeMap<>();
        for (int i = 1; i <= 12; i++) {
            try {
                c.setTime(sdf.parse("2018-" + i + "-01"));
                int days = c.getActualMaximum(Calendar.DAY_OF_MONTH);
                int[] hj = new int[days];
                pi.put(i, hj);
                int[] bl = new int[days];
                si.put(i, bl);
                int[] tb = new int[days];
                ti.put(i, tb);
                System.out.println(i + "月的天数：" + days); // 最后一天
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        System.out.println("PI长度" + pi.size());
        System.out.println("SI长度" + si.size());
        System.out.println("TI长度" + ti.size());
        System.out.println("2018-".substring(0,4));

    }

    @Override
    public Map<String,Object> findMarketByBdate(String bdate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String firstDay, lastDay;
        Map<String,Object> dataMap = new HashMap<>();
        try {
            Calendar c = Calendar.getInstance();
            c.setTime(sdf.parse(bdate + "-01-01"));

            c.set(Calendar.DAY_OF_YEAR, 1);
            firstDay = sdf.format(c.getTime());// 第一天
            c.add(Calendar.YEAR, 1);
            c.set(Calendar.DAY_OF_YEAR, 0);
            lastDay = sdf.format(c.getTime());// 最后一天

            Map<Integer,double[]> dataPI = new TreeMap<>();
            Map<Integer,double[]> dataSI = new TreeMap<>();
            Map<Integer,double[]> dataTI = new TreeMap<>();
            //根据月份生成天数大小的数组
            for (int i = 1; i <= 12; i++) {
                try {
                    c.setTime(sdf.parse(bdate + "-" + i + "-01"));
                    //获取每月多少天，用于定义数组长度
                    int days = c.getActualMaximum(Calendar.DAY_OF_MONTH);
                    double[] hj = new double[days];
                    dataPI.put(i, hj);
                    double[] bl = new double[days];
                    dataSI.put(i, bl);
                    double[] tb = new double[days];
                    dataTI.put(i, tb);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

            /*// 获取前月的第一天
            Calendar cale = Calendar.getInstance();
            cale.setTime(sdf.parse(bdate + "-01"));
            cale.add(Calendar.MONTH, 0);
            cale.set(Calendar.DAY_OF_MONTH, 1);
            firstDay = sdf.format(cale.getTime());
            // 获取前月的最后一天
            cale = Calendar.getInstance();
            cale.add(Calendar.MONTH, 1);
            cale.set(Calendar.DAY_OF_MONTH, 0);
            lastDay = sdf.format(cale.getTime());*/
            List<WyMarket> marketByBdate = myMarketRepository.findMarketByBdate(sdf.parse(firstDay), sdf.parse(lastDay));

            marketByBdate.forEach(x -> {
                String bDate = sdf.format(x.getbDate());
                String month = bDate.substring(5, 7);//截取月份
                String day = bDate.substring(8, bDate.length());//截取天数
                if (x.getStorefront().contains(Constant.HANJIE)) {
                    double[] pis = dataPI.get(Integer.valueOf(month));
                    pis[Integer.valueOf(day) - 1] += x.getPrice().doubleValue();
                } else if (x.getStorefront().contains(Constant.BAOLI)) {
                    double[] sis = dataSI.get(Integer.valueOf(month));
                    sis[Integer.valueOf(day) - 1] += x.getPrice().doubleValue();
                } else if (x.getStorefront().contains(Constant.TAIBEI)) {
                    double[] tis = dataTI.get(Integer.valueOf(month));
                    tis[Integer.valueOf(day) - 1] += x.getPrice().doubleValue();
                }
            });

            dataMap.put("dataPI",dataPI);
            dataMap.put("dataSI",dataSI);
            dataMap.put("dataTI",dataTI);

        } catch (ParseException e) {
            e.printStackTrace();
        }
        return dataMap;
    }
}
