package com.hrg.module.upload;

import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
 * Created by 82705 on 2017/7/20.
 */
@Controller
public class UploadControllor {

    @RequestMapping(method = {RequestMethod.POST}, value = {"/webUploader"})
    @ResponseBody
    public void webUploader(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (isMultipart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                String savePath = "";
                // 得到所有的表单域，它们目前都被当作FileItem
                List<FileItem> fileItems = upload.parseRequest(request);

                String id = "";
                String fileName = "";
                // 如果大于1说明是分片处理
                int chunks = 1;
                int chunk = 0;
                FileItem tempFileItem = null;

                for (FileItem fileItem : fileItems) {
                    if (fileItem.getFieldName().equals("id")) {
                        id = fileItem.getString();
                    } else if (fileItem.getFieldName().equals("name")) {
                        fileName = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
                    } else if (fileItem.getFieldName().equals("chunks")) {
                        chunks = NumberUtils.toInt(fileItem.getString());
                    } else if (fileItem.getFieldName().equals("chunk")) {
                        chunk = NumberUtils.toInt(fileItem.getString());
                    } else if (fileItem.getFieldName().equals("multiFile")) {
                        tempFileItem = fileItem;
                    }
                }
                //session中的参数设置获取是我自己的原因,文件名你们可以直接使用fileName,这个是原来的文件名
                String realname = makeFileName(fileName);//转化后的文件名
                String filePath =makePath(realname, savePath);//文件上传路径

                // 临时目录用来存放所有分片文件
                String tempFileDir = filePath + id;
                File parentFileDir = new File(tempFileDir);
                if (!parentFileDir.exists()) {
                    parentFileDir.mkdirs();
                }
                // 分片处理时，前台会多次调用上传接口，每次都会上传文件的一部分到后台
                File tempPartFile = new File(parentFileDir, realname + "_" + chunk + ".part");
                FileUtils.copyInputStreamToFile(tempFileItem.getInputStream(), tempPartFile);

                // 是否全部上传完成
                // 所有分片都存在才说明整个文件上传完成
                boolean uploadDone = true;
                for (int i = 0; i < chunks; i++) {
                    File partFile = new File(parentFileDir, realname + "_" + i + ".part");
                    if (!partFile.exists()) {
                        uploadDone = false;
                    }
                }
                // 所有分片文件都上传完成
                // 将所有分片文件合并到一个文件中
                if (uploadDone) {
                    // 得到 destTempFile 就是最终的文件
                    File destTempFile = new File(filePath, realname);
                    for (int i = 0; i < chunks; i++) {
                        File partFile = new File(parentFileDir, realname + "_" + i + ".part");
                        FileOutputStream destTempfos = new FileOutputStream(destTempFile, true);
                        //遍历"所有分片文件"到"最终文件"中
                        FileUtils.copyFile(partFile, destTempfos);
                        destTempfos.close();
                    }
                    // 删除临时目录中的分片文件
                    FileUtils.deleteDirectory(parentFileDir);
                } else {
                    // 临时文件创建失败
                    if (chunk == chunks -1) {
                        FileUtils.deleteDirectory(parentFileDir);
                    }
                }

            }
        } catch (Exception e) {

        }
    }


    @RequestMapping("/uploadfile")
    public @ResponseBody Object uploadfile(HttpServletRequest request, HttpServletResponse response) {
        Map map = new HashMap();
        String savePath = request.getSession().getServletContext().getRealPath("/WEB-INF/upload");
        String tempPath = request.getSession().getServletContext().getRealPath("/WEB-INF/temp");
        File tmpFile = new File(tempPath);
        if (!tmpFile.exists()) {
            tmpFile.mkdir();
        }
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(1024 * 100);//设置缓冲区的大小为100KB，如果不指定，那么缓冲区的大小默认是10KB
            factory.setRepository(tmpFile);
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setProgressListener(new ProgressListener() {
                public void update(long pBytesRead, long pContentLength, int arg2) {
                    System.out.println("文件大小为：" + pContentLength + ",当前已处理：" + pBytesRead);
                }
            });
            upload.setHeaderEncoding("UTF-8");
            if (!ServletFileUpload.isMultipartContent(request)) {
                return null;
            }
            /*upload.setFileSizeMax(1024 * 102);
            upload.setSizeMax(1024 * 1024 * 10);*/
            List<FileItem> list = upload.parseRequest(request);
            for (FileItem item : list) {
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString("UTF-8");
                    System.out.println(name + "=" + value);
                } else {
                    String filename = item.getName();
                    System.out.println(filename);
                    if (filename == null || filename.trim().equals("")) {
                        continue;
                    }
                    filename = filename.substring(filename.lastIndexOf("\\") + 1);
                    String fileExtName = filename.substring(filename.lastIndexOf(".") + 1);
                    System.out.println("上传的文件的扩展名是：" + fileExtName);
                    InputStream in = item.getInputStream();
                    String saveFilename = makeFileName(filename);
                    String realSavePath = makePath(saveFilename, savePath);
                    FileOutputStream out = new FileOutputStream(realSavePath + "\\" + saveFilename);
                    byte buffer[] = new byte[1024];
                    int len = 0;
                    while ((len = in.read(buffer)) > 0) {
                        out.write(buffer, 0, len);
                    }
                    in.close();
                    out.close();
                    map.put("filename",saveFilename);
                }
            }
        } catch (FileUploadBase.FileSizeLimitExceededException e) {
            e.printStackTrace();
            map.put("success",false);
        } catch (FileUploadBase.SizeLimitExceededException e) {
            e.printStackTrace();
            map.put("success",false);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }

    /**
     * @Method: makeFileName
     * @Description: 生成上传文件的文件名，文件名以：uuid+"_"+文件的原始名称
     * @Anthor:孤傲苍狼
     * @param filename 文件的原始名称
     * @return uuid+"_"+文件的原始名称
     */
    private String makeFileName(String filename){  //2.jpg
        //为防止文件覆盖的现象发生，要为上传文件产生一个唯一的文件名
        return UUID.randomUUID().toString() + "_" + filename;
    }

    /**
     * 为防止一个目录下面出现太多文件，要使用hash算法打散存储
     * @Method: makePath
     * @Description:
     * @Anthor:孤傲苍狼
     *
     * @param filename 文件名，要根据文件名生成存储目录
     * @param savePath 文件存储路径
     * @return 新的存储目录
     */
    private String makePath(String filename,String savePath){
        int hashcode = filename.hashCode();
        int dir1 = hashcode&0xf;  //0--15
        int dir2 = (hashcode&0xf0)>>4;  //0-15
        String dir = savePath + "\\" + dir1 + "\\" + dir2;  //upload\2\3  upload\3\5
        File file = new File(dir);
        if(!file.exists()){
            file.mkdirs();
        }
        return dir;
    }
}
