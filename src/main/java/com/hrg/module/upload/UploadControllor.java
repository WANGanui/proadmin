package com.hrg.module.upload;

import com.hrg.model.Mission;
import com.hrg.model.MissionFile;
import com.hrg.service.MissionService;
import com.sun.xml.internal.bind.v2.runtime.reflect.opt.Const;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * Created by 82705 on 2017/7/20.
 */
@Controller
public class UploadControllor {

    String rootPath = "/upload";

    Map<String, Object> fileIdMap = new HashMap<>();

    @Autowired
    MissionService missionService;

    /**
     * 参数定义 CommonsMultipartFile 接收文件上传内容
     * AjaxResult  表示传达的是ajax数据
     * @param因为webuploader是以file参数往后台   传文件的；ff是自定义的文件实体
     * @return
     * @throws IOException
     * @throws IllegalStateException
     */
    @RequestMapping(method = RequestMethod.POST, path = "/uploadfile")
    public @ResponseBody Object  upload(@RequestParam(name = "modelPath", required = false) String modelPath,
                       @RequestBody MultipartFile multiFile, HttpServletRequest request,String missionid) {
        MultipartFile file=multiFile;
        Map map = new HashMap();
        boolean bool;
        // 判断是否有文件
        try {
            if (file != null && !file.isEmpty()) {
                // 获取文件的原始名称
                String oldName = file.getOriginalFilename();
                // 获取文件大小
                Long fileSize = file.getSize();
                // 获取文件的原始流
                // f.getInputStream()
                // 获取文件的类型
                System.out.println(file.getContentType());

                // 组装文件存储路径
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy" + File.separator + "MM" + File.separator + "dd");
                String dateStr = sdf.format(new Date());
                String filePath = rootPath + File.separator + dateStr;

                // 创建目录
                File f = new File(filePath);
                if (!f.exists()) {
                    f.mkdirs();
                }

                // 生成一个新的不会重复的文件名
                // 1.获取后缀
                String suffix = FilenameUtils.getExtension(file.getOriginalFilename());
                // 2.生成新的文件名
                String newFileName = UUID.randomUUID().toString() + "." + suffix;
                // 把上传的文件存储指定位置
                try {
                    file.transferTo(new File(f, newFileName));
                }catch (Exception e){
                    e.printStackTrace();
                }
                String FilePath = rootPath + File.separator + dateStr + File.separator + newFileName;
                MissionFile missionFile = new MissionFile();
                missionFile.setNameold(oldName);
                missionFile.setPath(FilePath.replace("\\", "/"));
                missionFile.setNamenew(newFileName);
                missionFile.setMissionid(missionid);
                bool =  missionService.insert(missionFile);
                map.put("success",bool);
            } else {
                System.out.println("上传失败！！");
                map.put("success",false);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }

    // 文件下载,表示/upload后面接的任何路径都会进入到这里
    @RequestMapping("/**")
    public void view(HttpServletResponse response, HttpServletRequest request)
            throws Exception {
        String filePath = request.getServletPath().replaceFirst("/upload/", "");
        File file = new File(rootPath, filePath);

        if (file.exists()) {
            List<MissionFile> list;
            String fileName = "";

            // 设置下载文件的名称,如果想直接在想查看就注释掉，因为要是文件原名才能下载，不然就只能在浏览器直接浏览无法下载
            response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));

            // 把文件输出到浏览器
            OutputStream os = response.getOutputStream();
            FileInputStream fs = new FileInputStream(file);
            byte[] b = new byte[1024];
            int len = 0;
            while ((len = fs.read(b)) > 0) {
                os.write(b, 0, len);
            }
            fs.close();
            os.flush();
        } else {
            response.sendError(404);
        }
    }

    @RequestMapping(method = {RequestMethod.POST}, value = {""})
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


    @RequestMapping("/")
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
