package com.market.console.common;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 图片上传工具类
 * Created by charlin on 2017/9/10.
 */
public  class UploadImageUtil {

    public static Map<String,String> uploadImg(MultipartFile file, HttpServletRequest req)
            throws IOException {
        Map<String,String> returnMap = new HashMap<>();
        if (null != file) {
            String fileName = file.getOriginalFilename();// 文件原名称
            String newFileName = UUID.randomUUID().toString()+fileName.substring(fileName.indexOf("."),fileName.length());
            String pathRoot = req.getSession().getServletContext().getRealPath("");
            String path = "/images/upload/";//获取文件保存路径
            String savePath = pathRoot + path;
            File fileDir = new File(savePath);
            if (!fileDir.exists()) { //如果不存在 则创建
                fileDir.mkdirs();
            }
            File localFile = new File(savePath + newFileName);
            try {
                file.transferTo(localFile);
                returnMap.put("newFileName",newFileName);
                returnMap.put("oldFileName",fileName);
                returnMap.put("savePath",savePath);
                returnMap.put("path", path + newFileName);
                return returnMap;
            } catch (IllegalStateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                return null;
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }else{
            System.out.println("文件为空");
        }
        return null;
    }

}