---
title: IO操作
date: '2026-03-31 23:20:56'
updated: '2026-04-15 23:27:05'
---
## 一、File
`java.io`提供了`File`对象来操作文件和目录。构造`File`对象时，可以传入绝对路径，也可以传入相对路径。

windows用`\`作为路径分隔符，java需要用`\\`表示一个`\`。linux使用`/`作为路径分隔符。用`.`表示当前目录，`..`表示上级目录。

`File`对象有一个静态变量用来表示当前平台的系统分隔符：`separator`

`File`对象有3种形式表示路径：

+ `getPath()`：返回构造方法传入的路径
+ `getAbsolutePath()`：返回绝对路径
+ `getCanonicalPath()`：返回规范路径

```java
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

`File`对象可以表示文件，也可以表示目录。

+ `isFile()`：是否是一个存在的文件
+ `isDirectory()`：是否是一个存在的目录
+ `canRead()`：是否可读
+ `canWrite()`：是否可写
+ `canExecute()`：是否可执行，对于目录而言，表示能否列出包含的文件和子目录
+ `length()`：文件字节大小

```java
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

+ `craeteNewFile()`：创建文件
+ `delete()`：删除文件，删除目录时只有目录为空才能删除成功
+ `createTempFile()`：创建临时文件
+ `deleteOnExit()`：在JVM退出时自动删除该文件
+ `mkdir()`：创建目录
+ `mkdirs()`：创建目录并且创建不存在的父目录
+ `list()`：列出文件名
+ `listFiles()`：列出文件对象，好分辨哪个是目录，哪个是文件

```java
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

## Path类
## 二、OutputStream
`write`方法会写入一个字节到输出流，虽然传入的是`int`参数，但只会写入一个字节。

`flush()`方法将缓冲区的内容输出到目的地。因为向磁盘、网络写入数据的时候，出于效率的考虑，操作系统并不是输出一个字节就立刻写入到文件或者发送到网络，而是把输出的字节先放到内存的一个缓冲区里(本质上就是一个`byte[]`数组)，等到缓冲区写满了，再一次性写入文件或者网络。

```java
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

可以通过重载`void wirte(byte[])`来一次性写入多个字节。

```java
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

上述代码如果发生异常就无法正确关闭资源，所以需要用`try(resource)`来保证无论是否发生IO错误都能正确关闭。

```java
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

### ByteArrayOutputStream
`ByteArrayOutputStream`实际上是把一个`byte[]`数组在内存中变成一个 `OutputStream`。

```java
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

```java
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

## 三、InputStream
`InpuStream`是一个抽象类，是所有输入流的超类。`read`是该类中最重要的方法。这个方法会读取输入流的下一个字节，并返回字节表示的int值，如果读到末尾会返回-1表示不能继续读取。

`FileInputStream`是`InpuStream`的一个子类。

`InpuStream`提供了两个重载方法来支持读取多个字节：

+ `int read(byte[] b)`：读取若干个字节并填充到`byte[]`数组，返回读取的字节数
+ `int read(byte[] b,int off,int len)`：指定`byte[]`数组的偏移量和最大填充数

InputStream也有缓冲区。读取一个字节时，操作系统往往会一次性读取若干字节到缓冲区，并维护一个指针指向未读的缓冲区。每次我们调用`read()`读取下一个字节时，可以直接返回缓冲区的下一个字节，避免每次读一个字节都导致IO操作。当缓冲区全部读完后继续调用`read()`，则会触发操作系统的下一次读取并再次填满缓冲区。

```java
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

### ByteArrayInputStream
```java
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

# 练习
```java
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

## 四、Filter模式
JDK将`InputStream`和`OutputStream`分为两大类，避免过多的子类继承导致子类爆炸：

+ 直接提供数据的基础类，如：`FileInputStream`、`ByteArrayInputStream`、`ServletInputStream`等
+ 提供额外附加功能的类，如：`BufferedInputStream`、`CipherInputStream`等

```java
InputStream file = new FileInputStream("test.gz");
InputStream buffered = new BufferedInputStream(file);
```

不管包装多少次，得到的对象始终是`InputStream`就可以正常读取。这种通过一个“基础”组件再叠加各种“附加”功能组件的模式，称之为Filter模式或者装饰器模式。

```java
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

### 序列化
序列化必须实现`java.io.Serializable`接口。序列化本质就是将一个java对象转化为`byte[]`数组。

```java
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

## 五、Reader
是java的IO库中提供的另一个输入流接口。与`InputStream`的区别在于：

+ `IntputStream`是一个字节流，以`byte`为单位读取；
+ `Reader`是一个字符流，以`char`为单位读取。

`FileReader`是`Reader`的一个子类，可以打开文件并获取`Reader`

```java
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

### CharArrayReader
与`ByteArrayInputStream`类似。

```java
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

`StringReader`可以直接把`String`作为数据源。

### InputStreamReader
除了`CharArrayReader`与`StringReader`，普通的`Reader`都是基于`InputStream`构造的，都需要从`InputStream`中读入`byte`，再根据编码设置转换为`char`。

`InputStreamReader`可以把任何`InputStream`转换为`Reader`。

```java
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

## 六、PrintStream和PrintWriter
`PrintStream`是一种`FilterOutputStream`，在`OutputStream`的接口上额外提供了一些写入各种数据类型的方法。

`System.out`是系统默认提供的`PrintStream`，`System.err`是系统默认提供的标准错误输出。

`PrintStream`和`OutputStream`相比，除了添加了一组`print() / println()`方法，可以打印各种数据类型，比较方便外，它还有一个额外的优点，就是不会抛出`IOException`，这样我们在编写代码的时候，就不必捕获`IOException`。

```java
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

`PrintStream`最终输出的总是`byte`数据，而`PrintWriter`则是扩展了`Writer`接口，它的`print() / println()`方法最终输出的是`char`数据。两者的使用方法几乎是一模一样的。

```java
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

## 七、Files与Paths
### Paths
```java
package org.example;
import java.io.*;
import java.nio.file.*;


public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {
        //创建路径
        Path path=Paths.get("src","java","demo\\two.txt");
        Path path1=Paths.get("src\\main\\java\\demo\\two.txt");
        Path path2=Paths.get("D:\\IDEA\\test\\IO\\src\\main\\java\\demo\\two.txt");

        //拼接路径
        Path path3=Paths.get("D:\\IDEA\\test\\IO");
        Path path4=path3.resolve("src\\main\\java\\demo\\two.txt");
        Path path5=path3.resolve(path1);
        
        //计算两个路径之间的距离，路径类型要一致，如：两个都是相对路径
        Path path6=Paths.get("D:\\");
        Path path7=path6.relativize(path2);
    }
}
```

获取路径信息：

| 调用方法 | 在 Solaris 操作系统中返回 | 在 Microsoft Windows 中返回 | 说明 |
| --- | --- | --- | --- |
| toString | /home/joe/foo | `C:\home\joe\foo` | 返回的字符串表示形式 。如果使用 Filesystems.getDefault().getPath(String) 或 Paths.get（后者是一种方便的 getPath 方法）创建路径，则该方法将执行较小的语法清理。例如，在 UNIX 操作系统中，它会将输入字符串 “//home/joe/foo” 更正为 “/home/joe/foo” |
| getFileName | foo | foo | 返回名称元素序列的文件名或最后一个元素 |
| getName(0) | home | home | 返回与指定索引对应的路径元素。第0个元素是最靠近根的路径元素 |
| getNameCount | 3 | 3 | 返回路径中的元素数 |
| subpath(0,2) | home/joe | `home\joe` | 返回Path由开始和结束索引指定的（不包括根元素）的子序列 |
| getParent | /home/joe | `\home\joe` | 返回父目录的路径 |
| getRoot | / | `C:\` | 返回路径的根 |


路径转换

+ `Path toAbsolutePath()`：将相对路径转换为绝对路径。
+ `Path normalize()`：规范化路径，去除冗余的名称元素，如 `"."` 和 `".."`。
+ `Path toRealPath()`：路径必须真实存在且能完全解析，才会返回路径

```java
package org.example;
import java.io.*;
import java.nio.charset.Charset;
import java.nio.file.*;


public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {
        Path path=Paths.get(".\\src\\main\\java\\demo\\one.txt");
        Path parent=path.getParent();
        if(parent!=null&&Files.notExists(parent)){
            Files.createDirectories(parent);
        }
        if(Files.notExists(path)){
            Files.createFile(path);
        }
        try(Writer writer=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path.toFile()),Charset.forName("UTF-8")))) {
            String body= """
                Hello World!
                How are you?
                """;
            writer.write(body);
        }


    }
}
```

```java
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

### Files
#### **创建和删除**
+ `static Path createFile(Path path, FileAttribute<?>... attrs)`：创建一个新文件。
+ `static Path createDirectory(Path dir, FileAttribute<?>... attrs)`：创建一个新目录。
+ `static Path createDirectories(Path dir, FileAttribute<?>... attrs)`：递归地创建目录，包括不存在的父目录。
+ `static void delete(Path path)`：删除指定的文件或目录。如果路径是目录，则目录必须为空。
+ `static boolean deleteIfExists(Path path)`：删除指定的文件或目录，如果存在的话。
+ `exists(Path path, LinkOption... options)`：检查文件或目录是否存在。
+ `notExists(Path path, LinkOption... options)`：检查文件或目录是否存在。

#### **复制文件或目录**
`public static Path copy( Path source,Path target,CopyOption ... options)`：复制文件或目录。如果目标文件存在，则复制失败，除非指定`REPLACE_EXTSTING`选项。

`public static long copy(InputStream in,Path target,CopyOption... options)`：将所有字节从输入流复制到文件。

`public static long copy(Path source,OutputStream out)`：将文件中所有字节复制到输出流。

#### **移动文件或目录**
`public static Path copy(Path source,Path target,CopyOption ... options)`：移动文件或目录。

此方法采用`varargs`参数 - 支持以下`StandardCopyOption`枚举：

+ **REPLACE_EXISTING** - 即使目标文件已经存在，也执行移动。如果目标是符号链接，则替换符号链接，但指向的内容不受影响。
+ **ATOMIC_MOVE** - 作为原子文件操作执行移动。如果文件系统不支持原子移动，则抛出异常。使用 ATOMIC_MOVE 您可以将文件移动到目录中，并确保观看目录的任何进程访问完整的文件。

**文件和文件存储属性**

| 方法 | 说明 |
| --- | --- |
| `size(Path)` | 以字节为单位返回指定文件的大小。 |
| `isDirectory(Path, LinkOption)` | 如果指定 Path 的文件是目录，则返回 true 。 |
| `isRegularFile(Path, LinkOption...)` | 如果指定 Path 的文件是常规文件，则返回 true 。 |
| `isSymbolicLink(Path)` | 如果指定的 Path 位置是一个符号链接的文件，则返回 true 。 |
| `isHidden(Path)` | 如果指定 Path 的文件系统被视为隐藏的文件，则返回 true 。 |
| `getLastModifiedTime(Path, LinkOption...)` `setLastModifiedTime(Path, FileTime)` | 返回或设置指定文件的上次修改时间。 |
| getOwner(Path, LinkOption...) setOwner(Path, UserPrincipal) | 返回或设置文件的所有者。 |
| `getPosixFilePermissions(Path, LinkOption...)` `setPosixFilePermissions(Path, Set<PosixFilePermission>)` | 返回或设置文件的 POSIX 文件权限。 |
| `getAttribute(Path, String, LinkOption...)` `setAttribute(Path, String, Object, LinkOption...)` | 返回或设置文件属性的值。 |


#### **读、写**
+ `readAllBytes`
+ `readAllLines`
+ `public static Path write(Path path,byte[] bytes,OpenOption... options)`
+ `public static Path write(Path path,Iterable<? extends CharSequence> lines,Charset cs,OpenOption... options)`

options选项：APPEND表示追加

```java
package org.example;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {
        Path path=Paths.get(".\\src\\main\\java\\demo\\one.txt");
        Path parent=path.getParent();
        if(parent!=null&&Files.notExists(parent)){
            Files.createDirectories(parent);
        }
        if(Files.notExists(path)){
            Files.createFile(path);
        }
        byte[] body="直接用write写入".getBytes();
        //覆盖写入单行
        Files.write(path,body);
        //覆盖写入多行
        List<? extends CharSequence> list= Arrays.asList("first","second","third");
        Files.write(path,list, StandardCharsets.UTF_8);
    }
}
```

**无缓冲流**  

`public static BufferedReader newBufferedReader(Path path,Charset cs)` 

```java
package org.example;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {
        Path path=Paths.get(".\\src\\main\\java\\demo\\one.txt");
        Path parent=path.getParent();
        if(parent!=null&&Files.notExists(parent)){
            Files.createDirectories(parent);
        }
        if(Files.notExists(path)){
            Files.createFile(path);
        }
        try(InputStream inputStream=Files.newInputStream(path)){
            BufferedReader br=new BufferedReader(new InputStreamReader(inputStream,StandardCharsets.UTF_8));
            String line=null;
            while((line=br.readLine())!=null){
                System.out.println(line);
            }
        }
    }
}
```

                                           

## 八、URL
