package com.market.console.model;

import java.math.BigInteger;

/**
 * <p>
 *
 * </p>
 * Copyright (C) 2018 R. All Rights Reserved.
 *
 * @author xinhe.REN (Create on:2018年10月23日)
 * @version 1.0
 */
public class WyMenuDto {
    private BigInteger id;
    private String name;//名称
    private String icon;//图标
    private String url;//链接地址
    private Integer isSort;//排序
    private String useYn;//是否启用
    private BigInteger parentId;


    public WyMenuDto(BigInteger id, String icon, String name, String url, String useYn, BigInteger parentId, Integer isSort) {
        this.id = id;
        this.name = name;
        this.icon = icon;
        this.url = url;
        this.isSort = isSort;
        this.useYn = useYn;
        this.parentId = parentId;
    }

    public BigInteger getId() {
        return id;
    }

    public void setId(BigInteger id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getIsSort() {
        return isSort;
    }

    public void setIsSort(Integer isSort) {
        this.isSort = isSort;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public BigInteger getParentId() {
        return parentId;
    }

    public void setParentId(BigInteger parentId) {
        this.parentId = parentId;
    }
}
