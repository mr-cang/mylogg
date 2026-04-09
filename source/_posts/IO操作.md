---
title: IO操作
date: '2026-03-31 23:20:56'
updated: '2026-04-07 22:56:26'
---
## <font style="color:rgb(32, 33, 36);">一、File</font>
`<font style="background-color:rgb(248, 249, 250);">java.io</font>`<font style="color:rgb(32, 33, 36);">提供了</font>`<font style="background-color:rgb(248, 249, 250);">File</font>`<font style="color:rgb(32, 33, 36);">对象来操作文件和目录。构造</font>`<font style="background-color:rgb(248, 249, 250);">File</font>`<font style="color:rgb(32, 33, 36);">对象时，可以传入绝对路径，也可以传入相对路径。</font>

<font style="color:rgb(32, 33, 36);">windows用</font>`<font style="background-color:rgb(248, 249, 250);">\</font>`<font style="color:rgb(32, 33, 36);">作为路径分隔符，java需要用</font>`<font style="background-color:rgb(248, 249, 250);">\\</font>`<font style="color:rgb(32, 33, 36);">表示一个</font>`<font style="background-color:rgb(248, 249, 250);">\</font>`<font style="color:rgb(32, 33, 36);">。linux使用</font>`<font style="background-color:rgb(248, 249, 250);">/</font>`<font style="color:rgb(32, 33, 36);">作为路径分隔符。用</font>`<font style="background-color:rgb(248, 249, 250);">.</font>`<font style="color:rgb(32, 33, 36);">表示当前目录，</font>`<font style="background-color:rgb(248, 249, 250);">..</font>`<font style="color:rgb(32, 33, 36);">表示上级目录。</font>

`<font style="background-color:rgb(248, 249, 250);">File</font>`<font style="color:rgb(32, 33, 36);">对象有一个静态变量用来表示当前平台的系统分隔符：</font>`<font style="background-color:rgb(248, 249, 250);">separator</font>`

`<font style="background-color:rgb(248, 249, 250);">File</font>`<font style="color:rgb(32, 33, 36);">对象有3种形式表示路径：</font>

+ `<font style="background-color:rgb(248, 249, 250);">getPath()</font>`<font style="color:rgb(32, 33, 36);">：返回构造方法传入的路径</font>
+ `<font style="background-color:rgb(248, 249, 250);">getAbsolutePath()</font>`<font style="color:rgb(32, 33, 36);">：返回绝对路径</font>
+ `<font style="background-color:rgb(248, 249, 250);">getCanonicalPath()</font>`<font style="color:rgb(32, 33, 36);">：返回规范路径</font>

```plain
package org.example;
import java.io.*;

public class Main {
    public static void main(String[] args) {
        try {
            File file=new File(".\\one.txt");
            System.out.println(file.getAbsolutePath());
            System.out.println(file.getPath());
            System.out.println(file.getCanonicalPath());
        }
         catch (IOException e) {
            throw new RuntimeException("getCanonicalPath()有问题",e);
        }
    }
}
```

`<font style="background-color:rgb(248, 249, 250);">File</font>`<font style="color:rgb(32, 33, 36);">对象可以表示文件，也可以表示目录。</font>

+ `<font style="background-color:rgb(248, 249, 250);">isFile()</font>`<font style="color:rgb(32, 33, 36);">：是否是一个存在的文件</font>
+ `<font style="background-color:rgb(248, 249, 250);">isDirectory()</font>`<font style="color:rgb(32, 33, 36);">：是否是一个存在的目录</font>
+ `<font style="background-color:rgb(248, 249, 250);">canRead()</font>`<font style="color:rgb(32, 33, 36);">：是否可读</font>
+ `<font style="background-color:rgb(248, 249, 250);">canWrite()</font>`<font style="color:rgb(32, 33, 36);">：是否可写</font>
+ `<font style="background-color:rgb(248, 249, 250);">canExecute()</font>`<font style="color:rgb(32, 33, 36);">：是否可执行，对于目录而言，表示能否列出包含的文件和子目录</font>
+ `<font style="background-color:rgb(248, 249, 250);">length()</font>`<font style="color:rgb(32, 33, 36);">：文件字节大小</font>

```plain
package org.example;
import java.io.*;

public class Main {
    public static void main(String[] args) {
        File file=new File(".\\one.txt");
        if(file.isFile()){
            System.out.println(File.separator);
        }else{
            throw new RuntimeException("文件不存在");
        }
    }
}
```

+ `<font style="background-color:rgb(248, 249, 250);">craeteNewFile()</font>`<font style="color:rgb(32, 33, 36);">：创建文件</font>
+ `<font style="background-color:rgb(248, 249, 250);">delete()</font>`<font style="color:rgb(32, 33, 36);">：删除文件，删除目录时只有目录为空才能删除成功</font>
+ `<font style="background-color:rgb(248, 249, 250);">createTempFile()</font>`<font style="color:rgb(32, 33, 36);">：创建临时文件</font>
+ `<font style="background-color:rgb(248, 249, 250);">deleteOnExit()</font>`<font style="color:rgb(32, 33, 36);">：在JVM退出时自动删除该文件</font>
+ `<font style="background-color:rgb(248, 249, 250);">mkdir()</font>`<font style="color:rgb(32, 33, 36);">：创建目录</font>
+ `<font style="background-color:rgb(248, 249, 250);">mkdirs()</font>`<font style="color:rgb(32, 33, 36);">：创建目录并且创建不存在的父目录</font>
+ `<font style="background-color:rgb(248, 249, 250);">list()</font>`<font style="color:rgb(32, 33, 36);">：列出文件名</font>
+ `<font style="background-color:rgb(248, 249, 250);">listFiles()</font>`<font style="color:rgb(32, 33, 36);">：列出文件对象，好分辨哪个是目录，哪个是文件</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args) throws IOException {
        File file=new File(".\\one.txt");
        File dir=new File(".\\src\\main\\java\\demo");
        File newFile=new File(dir,file.getName());
        if(!dir.exists()){
            dir.mkdirs();
        }
        if (!newFile.exists()) {
            newFile.createNewFile();
        }
        File[] files=dir.listFiles();
        printFile(files);
    }
    static void printFile(File[] file){
        if(file == null || file.length == 0){
            System.out.println("目录为空或不存在");
            return;
        }
        for(File f:file){
            try {
                System.out.println(f.getCanonicalFile());
            } catch (IOException e) {
                throw new RuntimeException("路径有问题");
            }
        }
    }
}
```

## <font style="color:rgb(32, 33, 36);">Path类</font>
## <font style="color:rgb(32, 33, 36);">二、OutputStream</font>
`<font style="background-color:rgb(248, 249, 250);">write</font>`<font style="color:rgb(32, 33, 36);">方法会写入一个字节到输出流，虽然传入的是</font>`<font style="background-color:rgb(248, 249, 250);">int</font>`<font style="color:rgb(32, 33, 36);">参数，但只会写入一个字节。</font>

`<font style="background-color:rgb(248, 249, 250);">flush()</font>`<font style="color:rgb(32, 33, 36);">方法将缓冲区的内容输出到目的地。因为向磁盘、网络写入数据的时候，出于效率的考虑，操作系统并不是输出一个字节就立刻写入到文件或者发送到网络，而是把输出的字节先放到内存的一个缓冲区里(本质上就是一个</font>`<font style="background-color:rgb(248, 249, 250);">byte[]</font>`<font style="color:rgb(32, 33, 36);">数组)，等到缓冲区写满了，再一次性写入文件或者网络。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args) throws IOException {
        File file=new File(".\\one.txt");
        File dir=new File(".\\src\\main\\java\\demo\\");
        File newFile=new File(dir,file.getName());
        OutputStream out=new FileOutputStream(newFile);
        out.write('a');
        out.close();
    }
}
```

<font style="color:rgb(32, 33, 36);">可以通过重载</font>`<font style="background-color:rgb(248, 249, 250);">void wirte(byte[])</font>`<font style="color:rgb(32, 33, 36);">来一次性写入多个字节。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args) throws IOException {
        File file=new File(".\\one.txt");
        File dir=new File(".\\src\\main\\java\\demo\\");
        File newFile=new File(dir,file.getName());
        OutputStream out=new FileOutputStream(newFile);
        out.write("abc".getBytes("UTF-8"));
        out.close();
    }
}
```

<font style="color:rgb(32, 33, 36);">上述代码如果发生异常就无法正确关闭资源，所以需要用</font>`<font style="background-color:rgb(248, 249, 250);">try(resource)</font>`<font style="color:rgb(32, 33, 36);">来保证无论是否发生IO错误都能正确关闭。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args){
        File file=new File(".\\one.txt");
        File dir=new File(".\\src\\main\\java\\demo\\");
        File newFile=new File(dir,file.getName());
        try(OutputStream out=new FileOutputStream(newFile)) {
            out.write("abc".getBytes("UTF-8"));
        }catch (IOException e){ 
            e.printStackTrace();
        }
    }
}
```

### <font style="color:rgb(32, 33, 36);">ByteArrayOutputStream</font>
`<font style="background-color:rgb(248, 249, 250);">ByteArrayOutputStream</font>`<font style="color:rgb(32, 33, 36);">实际上是把一个</font>`<font style="background-color:rgb(248, 249, 250);">byte[]</font>`<font style="color:rgb(32, 33, 36);">数组在内存中变成一个 </font>`<font style="background-color:rgb(248, 249, 250);">OutputStream</font>`<font style="color:rgb(32, 33, 36);">。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args){
        try(ByteArrayOutputStream out=new ByteArrayOutputStream()) {
            out.write("Hello ".getBytes("UTF-8"));
            out.write("World".getBytes("UTF-8"));
            byte[] data=out.toByteArray();
            System.out.println(new String(data,"UTF-8"));
        }catch (IOException e){
            e.printStackTrace();
        }
    }
}
```

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args){
        File file=new File(".\\one.txt");
        File dir=new File(".\\src\\main\\java\\demo\\");
        File newFile=new File(dir,file.getName());
        try(ByteArrayOutputStream out=new ByteArrayOutputStream()) {
            out.write("Hello ".getBytes("UTF-8"));
            out.write("World".getBytes("UTF-8"));
            byte[] data=out.toByteArray();
            if(newFile.exists()){
                FileOutputStream fis=new FileOutputStream(newFile);
                fis.write(data);
            }
        }catch (IOException e){
            e.printStackTrace();
        }
    }
}
```

## <font style="color:rgb(32, 33, 36);">三、InputStream</font>
`<font style="background-color:rgb(248, 249, 250);">InpuStream</font>`<font style="color:rgb(32, 33, 36);">是一个抽象类，是所有输入流的超类。</font>`<font style="background-color:rgb(248, 249, 250);">read</font>`<font style="color:rgb(32, 33, 36);">是该类中最重要的方法。这个方法会读取输入流的下一个字节，并返回字节表示的int值，如果读到末尾会返回-1表示不能继续读取。</font>

`<font style="background-color:rgb(248, 249, 250);">FileInputStream</font>`<font style="color:rgb(32, 33, 36);">是</font>`<font style="background-color:rgb(248, 249, 250);">InpuStream</font>`<font style="color:rgb(32, 33, 36);">的一个子类。</font>

`<font style="background-color:rgb(248, 249, 250);">InpuStream</font>`<font style="color:rgb(32, 33, 36);">提供了两个重载方法来支持读取多个字节：</font>

+ `<font style="background-color:rgb(248, 249, 250);">int read(byte[] b)</font>`<font style="color:rgb(32, 33, 36);">：读取若干个字节并填充到</font>`<font style="background-color:rgb(248, 249, 250);">byte[]</font>`<font style="color:rgb(32, 33, 36);">数组，返回读取的字节数</font>
+ `<font style="background-color:rgb(248, 249, 250);">int read(byte[] b,int off,int len)</font>`<font style="color:rgb(32, 33, 36);">：指定</font>`<font style="background-color:rgb(248, 249, 250);">byte[]</font>`<font style="color:rgb(32, 33, 36);">数组的偏移量和最大填充数</font>

<font style="color:rgb(32, 33, 36);">InputStream也有缓冲区。读取一个字节时，操作系统往往会一次性读取若干字节到缓冲区，并维护一个指针指向未读的缓冲区。每次我们调用</font>`<font style="background-color:rgb(248, 249, 250);">read()</font>`<font style="color:rgb(32, 33, 36);">读取下一个字节时，可以直接返回缓冲区的下一个字节，避免每次读一个字节都导致IO操作。当缓冲区全部读完后继续调用</font>`<font style="background-color:rgb(248, 249, 250);">read()</font>`<font style="color:rgb(32, 33, 36);">，则会触发操作系统的下一次读取并再次填满缓冲区。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args) throws IOException {
        File file=new File(".\\one.txt");
        File dir=new File(".\\src\\main\\java\\demo\\");
        File newFile=new File(dir,file.getName());
        try(InputStream in=new FileInputStream(newFile)){
            byte[] buffer=new byte[1024];
            int len=in.read(buffer);
            for(int i=0;i<len;i++){
                System.out.print((char)buffer[i]);
            }
            
        }
    }
}
```

### <font style="color:rgb(32, 33, 36);">ByteArrayInputStream</font>
```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args) throws IOException {
        File file=new File(".\\one.txt");
        File dir=new File(".\\src\\main\\java\\demo\\");
        File newFile=new File(dir,file.getName());
        byte[] data = { 72, 101, 108, 108, 111, 33 };
        try (InputStream input = new ByteArrayInputStream(data)) {
            int n;
            while ((n = input.read())!= -1) {
                System.out.println((char)n);
            }
        }
    }
}
```

# <font style="color:rgb(32, 33, 36);">练习</font>
```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args) throws IOException {
        File file=new File(".\\one.txt");
        File dir=new File(".\\src\\main\\java\\demo\\");
        File newFile=new File(dir,file.getName());
        if(!dir.exists()){
            dir.mkdirs();
        }
        if(!newFile.exists()){
            newFile.createNewFile();
        }
        try(OutputStream out=new FileOutputStream(newFile)){
            out.write("Hello World".getBytes());
            out.flush();
            try(InputStream in=new FileInputStream(newFile)){
                byte[] buffer=new byte[1024];
                int i=in.read();
                while(i!=-1){
                    System.out.print((char)i);
                    i=in.read();
                }
            }
        }
    }
}
```

## <font style="color:rgb(32, 33, 36);">四、Filter模式</font>
<font style="color:rgb(32, 33, 36);">JDK将</font>`<font style="background-color:rgb(248, 249, 250);">InputStream</font>`<font style="color:rgb(32, 33, 36);">和</font>`<font style="background-color:rgb(248, 249, 250);">OutputStream</font>`<font style="color:rgb(32, 33, 36);">分为两大类，避免过多的子类继承导致子类爆炸：</font>

+ <font style="color:rgb(32, 33, 36);">直接提供数据的基础类，如：</font>`<font style="background-color:rgb(248, 249, 250);">FileInputStream</font>`<font style="color:rgb(32, 33, 36);">、</font>`<font style="background-color:rgb(248, 249, 250);">ByteArrayInputStream</font>`<font style="color:rgb(32, 33, 36);">、</font>`<font style="background-color:rgb(248, 249, 250);">ServletInputStream</font>`<font style="color:rgb(32, 33, 36);">等</font>
+ <font style="color:rgb(32, 33, 36);">提供额外附加功能的类，如：</font>`<font style="background-color:rgb(248, 249, 250);">BufferedInputStream</font>`<font style="color:rgb(32, 33, 36);">、</font>`<font style="background-color:rgb(248, 249, 250);">CipherInputStream</font>`<font style="color:rgb(32, 33, 36);">等</font>

```plain
InputStream file = new FileInputStream("test.gz");
InputStream buffered = new BufferedInputStream(file);
```

<font style="color:rgb(32, 33, 36);">不管包装多少次，得到的对象始终是</font>`<font style="background-color:rgb(248, 249, 250);">InputStream</font>`<font style="color:rgb(32, 33, 36);">就可以正常读取。这种通过一个“基础”组件再叠加各种“附加”功能组件的模式，称之为Filter模式或者装饰器模式。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;


public class Main {
    public static void main(String[] args) throws IOException {
        byte[] data="hello world".getBytes("UTF-8");
        try(CountInputStream input=new CountInputStream(new ByteArrayInputStream(data))){
            int n;
            while((n=input.read())!=-1){
                System.out.print((char)n);
            }
            System.out.println("\n"+"总共"+input.getBytesRead()+"个byte");
        }
    }
}
class CountInputStream extends FilterInputStream {
    private int count=0;
    CountInputStream(InputStream in) {
        super(in);
    }
    public int getBytesRead(){
        return this.count;
    }
    public int read() throws IOException {
        int n=in.read();
        if(n!=-1){
            this.count++;
        }
        return n;
    }
    public int read(byte[] b) throws IOException {
        int n=in.read(b);
        if(n!=-1){
            this.count+=n;
        }
        return n;
    }
}
```

### <font style="color:rgb(32, 33, 36);">序列化</font>
<font style="color:rgb(32, 33, 36);">序列化必须实现</font>`<font style="background-color:rgb(248, 249, 250);">java.io.Serializable</font>`<font style="color:rgb(32, 33, 36);">接口。序列化本质就是将一个java对象转化为</font>`<font style="background-color:rgb(248, 249, 250);">byte[]</font>`<font style="color:rgb(32, 33, 36);">数组。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try(ObjectOutputStream oos = new ObjectOutputStream(baos)){
            oos.writeInt(12345);
            oos.writeObject(Double.valueOf(123.345));
            byte[] bytes = baos.toByteArray();
            System.out.println(Arrays.toString(bytes));
        }
    }
}
```

## <font style="color:rgb(32, 33, 36);">五、Reader</font>
<font style="color:rgb(32, 33, 36);">是java的IO库中提供的另一个输入流接口。与</font>`<font style="background-color:rgb(248, 249, 250);">InputStream</font>`<font style="color:rgb(32, 33, 36);">的区别在于：</font>

+ `<font style="background-color:rgb(248, 249, 250);">IntputStream</font>`<font style="color:rgb(32, 33, 36);">是一个字节流，以</font>`<font style="background-color:rgb(248, 249, 250);">byte</font>`<font style="color:rgb(32, 33, 36);">为单位读取；</font>
+ `<font style="background-color:rgb(248, 249, 250);">Reader</font>`<font style="color:rgb(32, 33, 36);">是一个字符流，以</font>`<font style="background-color:rgb(248, 249, 250);">char</font>`<font style="color:rgb(32, 33, 36);">为单位读取。</font>

`<font style="background-color:rgb(248, 249, 250);">FileReader</font>`<font style="color:rgb(32, 33, 36);">是</font>`<font style="background-color:rgb(248, 249, 250);">Reader</font>`<font style="color:rgb(32, 33, 36);">的一个子类，可以打开文件并获取</font>`<font style="background-color:rgb(248, 249, 250);">Reader</font>`

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) throws IOException {
        try(Reader reader=new FileReader(".\\src\\main\\java\\demo\\one.txt", StandardCharsets.UTF_8)) {
            char[] buffer=new char[1024];
            int len=reader.read(buffer);
            for(int i=0;i<len;i++) {
                System.out.print(buffer[i]);
            }
        }
    }
}
```

### <font style="color:rgb(32, 33, 36);">CharArrayReader</font>
<font style="color:rgb(32, 33, 36);">与</font>`<font style="background-color:rgb(248, 249, 250);">ByteArrayInputStream</font>`<font style="color:rgb(32, 33, 36);">类似。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) throws IOException {
        char[] body="hello world".toCharArray();
        try(Reader reader=new CharArrayReader(body)){
            char[] chars=new char[body.length];
            int len=reader.read(chars);
            for(int i=0;i<len;i++){
                System.out.print(chars[i]);
            }
        }
    }
}
```

`<font style="background-color:rgb(248, 249, 250);">StringReader</font>`<font style="color:rgb(32, 33, 36);">可以直接把</font>`<font style="background-color:rgb(248, 249, 250);">String</font>`<font style="color:rgb(32, 33, 36);">作为数据源。</font>

### <font style="color:rgb(32, 33, 36);">InputStreamReader</font>
<font style="color:rgb(32, 33, 36);">除了</font>`<font style="background-color:rgb(248, 249, 250);">CharArrayReader</font>`<font style="color:rgb(32, 33, 36);">与</font>`<font style="background-color:rgb(248, 249, 250);">StringReader</font>`<font style="color:rgb(32, 33, 36);">，普通的</font>`<font style="background-color:rgb(248, 249, 250);">Reader</font>`<font style="color:rgb(32, 33, 36);">都是基于</font>`<font style="background-color:rgb(248, 249, 250);">InputStream</font>`<font style="color:rgb(32, 33, 36);">构造的，都需要从</font>`<font style="background-color:rgb(248, 249, 250);">InputStream</font>`<font style="color:rgb(32, 33, 36);">中读入</font>`<font style="background-color:rgb(248, 249, 250);">byte</font>`<font style="color:rgb(32, 33, 36);">，再根据编码设置转换为</font>`<font style="background-color:rgb(248, 249, 250);">char</font>`<font style="color:rgb(32, 33, 36);">。</font>

`<font style="background-color:rgb(248, 249, 250);">InputStreamReader</font>`<font style="color:rgb(32, 33, 36);">可以把任何</font>`<font style="background-color:rgb(248, 249, 250);">InputStream</font>`<font style="color:rgb(32, 33, 36);">转换为</font>`<font style="background-color:rgb(248, 249, 250);">Reader</font>`<font style="color:rgb(32, 33, 36);">。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) throws IOException {
        byte[] bytes = "Hello World".getBytes(StandardCharsets.UTF_8);
        InputStream input=new ByteArrayInputStream(bytes);
        Reader reader=new InputStreamReader(input, StandardCharsets.UTF_8);
        char[] buf=new char[bytes.length];
        int len=reader.read(buf);
        for(int i=0;i<len;i++){
            System.out.print(buf[i]);
        }
        reader.close();
        input.close();
    }
}
```

## <font style="color:rgb(32, 33, 36);">六、PrintStream和PrintWriter</font>
`<font style="background-color:rgb(248, 249, 250);">PrintStream</font>`<font style="color:rgb(32, 33, 36);">是一种</font>`<font style="background-color:rgb(248, 249, 250);">FilterOutputStream</font>`<font style="color:rgb(32, 33, 36);">，在</font>`<font style="background-color:rgb(248, 249, 250);">OutputStream</font>`<font style="color:rgb(32, 33, 36);">的接口上额外提供了一些写入各种数据类型的方法。</font>

`<font style="background-color:rgb(248, 249, 250);">System.out</font>`<font style="color:rgb(32, 33, 36);">是系统默认提供的</font>`<font style="background-color:rgb(248, 249, 250);">PrintStream</font>`<font style="color:rgb(32, 33, 36);">，</font>`<font style="background-color:rgb(248, 249, 250);">System.err</font>`<font style="color:rgb(32, 33, 36);">是系统默认提供的标准错误输出。</font>

`<font style="background-color:rgb(248, 249, 250);">PrintStream</font>`<font style="color:rgb(32, 33, 36);">和</font>`<font style="background-color:rgb(248, 249, 250);">OutputStream</font>`<font style="color:rgb(32, 33, 36);">相比，除了添加了一组</font>`<font style="background-color:rgb(248, 249, 250);">print() / println()</font>`<font style="color:rgb(32, 33, 36);">方法，可以打印各种数据类型，比较方便外，它还有一个额外的优点，就是不会抛出</font>`<font style="background-color:rgb(248, 249, 250);">IOException</font>`<font style="color:rgb(32, 33, 36);">，这样我们在编写代码的时候，就不必捕获</font>`<font style="background-color:rgb(248, 249, 250);">IOException</font>`<font style="color:rgb(32, 33, 36);">。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) throws IOException {
        PrintStream out = new PrintStream(System.out, true, "UTF-8");
        out.println(123);
    }
}
```

`<font style="background-color:rgb(248, 249, 250);">PrintStream</font>`<font style="color:rgb(32, 33, 36);">最终输出的总是</font>`<font style="background-color:rgb(248, 249, 250);">byte</font>`<font style="color:rgb(32, 33, 36);">数据，而</font>`<font style="background-color:rgb(248, 249, 250);">PrintWriter</font>`<font style="color:rgb(32, 33, 36);">则是扩展了</font>`<font style="background-color:rgb(248, 249, 250);">Writer</font>`<font style="color:rgb(32, 33, 36);">接口，它的</font>`<font style="background-color:rgb(248, 249, 250);">print() / println()</font>`<font style="color:rgb(32, 33, 36);">方法最终输出的是</font>`<font style="background-color:rgb(248, 249, 250);">char</font>`<font style="color:rgb(32, 33, 36);">数据。两者的使用方法几乎是一模一样的。</font>

```plain
package org.example;
import javax.annotation.processing.FilerException;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class Main {
    public static void main(String[] args) throws IOException {
        StringWriter sw = new StringWriter();
        try(PrintWriter pw = new PrintWriter(sw)){
            pw.println("Hello World");
        }
        System.out.println(sw);
    }
}
```

## <font style="color:rgb(32, 33, 36);">七、Files</font>
```plain
package org.example;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;

public class Main {
    public static void main(String[] args) throws IOException {
        File file=new File(".\\src\\main\\java\\demo\\one.txt");
        byte[] data= Files.readAllBytes(file.toPath());
        System.out.println(data);
        String dataString=Files.readString(file.toPath(), StandardCharsets.UTF_8);
        System.out.println(dataString);
    }
}
```

  
 

