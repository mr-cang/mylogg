---
title: js关键字
date: '2026-04-01 11:12:23'
updated: '2026-04-11 21:24:34'
---
url:

post:

post(



```java
package org.example;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Files;
import java.util.List;

public class Main {
    public static void main(String[] args) throws IOException {
        File file=new File(".\\url.txt");
        File dir=new File(".\\src\\main\\java\\org\\example\\url");
        File newfile=new File(dir,file.getName());
        OpenFile openFile=new OpenFile(newfile);
        openFile.PrintContent(openFile.readAllLines());
    }
}
class OpenFile{
    File file;
    public OpenFile(File dir,File filename) throws IOException {
        this.file=new File(dir,filename.getName());
    }
    public OpenFile(File file){
        this.file=file;
    }
    public List<String> readAllLines() throws IOException {
        return Files.readAllLines(file.toPath());
    }
    public void PrintContent(List<String> list) throws MalformedURLException {
        for(String str:list){
            if(str==null||str.trim().isEmpty()){
                continue;
            }
            URL url=new URL(str);
            try {
                URLConnection con= url.openConnection();
                BufferedReader reader=new BufferedReader(new InputStreamReader(con.getInputStream()));
                String line;
                while((line=reader.readLine())!=null){
                    System.out.println(line);
                }
                reader.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
```

