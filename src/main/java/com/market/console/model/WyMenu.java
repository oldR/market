package com.market.console.model;

import com.market.console.common.SeracherForm;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

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
public class WyMenu {
    @Id
    @GeneratedValue
    private Long id;
    private String name;//名称
    private String icon;//图标
    private String url;//链接地址
    @OrderBy
    private Integer isSort;//排序
    private String useYn;//是否启用

    @OneToMany(cascade=CascadeType.ALL)
    @JoinColumn(name = "parent_id")
    private List<WyMenu> children;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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

    public List<WyMenu> getChildren() {
        return children;
    }

    public void setChildren(List<WyMenu> children) {
        this.children = children;
    }
}
