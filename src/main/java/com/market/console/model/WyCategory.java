package com.market.console.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/**
 * <p>
 *
 * </p>
 * Copyright (C) 2018 R. All Rights Reserved.
 *
 * @author xinhe.REN (Create on:2018年10月23日)
 * @version 1.0
 */
@Entity
public class WyCategory {
    @Id
    @GeneratedValue
    private Long id;
    private String cateName;//店面名称
    private String cateSort;//排序

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public String getCateSort() {
        return cateSort;
    }

    public void setCateSort(String cateSort) {
        this.cateSort = cateSort;
    }
}
