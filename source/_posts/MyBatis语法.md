---
title: MyBatis语法
date: '2026-04-19 17:27:42'
updated: '2026-04-19 17:27:42'
---
**JDBC存在的问题**

+ 数据库连接创建、释放频繁造成系统资源浪费
+ sql语句在代码中硬编码，不宜维护

MyBatis是一个持久层框架，对jdbc的操作数据库的过程进行封装。通过 xml 或注解的方式将要执行的各种  statement（statement、preparedStatemnt、CallableStatement）配置起来，并通过 java 对象和 statement 中的 sql 进行映射生成最终执行的 sql 语句，最后由 mybatis 框架执行 sql 并将结果映射成 java  对象并返回。

# select
`mapper`都会有一个`namespace`，避免多个`mapper`冲突，而且这个`namespace`不可以重复。

`id`表示查询方法的唯一标识符，`resultType`定义返回值的类型，即调用sql的完整类名。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="org.example.UserMapper">
    <!-- 查询所有用户 -->
    <select id="getUserById" resultType="org.example.User">
        SELECT * FROM user where id=#{id};
    </select>

</mapper>

```

下面文件属于mybatis的配置文件，需要自己创建，`environments`是mybatis所连接的数据库配置信息，`environments`可以有多个`environment`以对应不同的环境，每一个`environment`都有一个独属于自己的`id`。

在`environments`中可以通过`default`属性指定需要的`environment`，每一个`environment`定义一个数据的基本连接信息。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://localhost:3306/mybatis?serverTimezone=Asia/Shanghai&amp;useSSL=false"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
            </dataSource>

        </environment>

    </environments>

    <mappers>
        <mapper resource="mapper.xml"/>
    </mappers>

</configuration>

```

每个基于`MyBatis`的应用都是以一个`SqlSessionFactory`实例为核心。`SqlSessionFactory`实例可以通过`SqlSessionFactoryBuilder`加载配置文件获得。

MyBatis包含一个`Resources`工具类，其包含的方法从类路径或其他位置加载资源文件更容易。

`SqlSession`类提供了在数据库执行SQL命名所需的所有方法。

```java
package org.example;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.*;
import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        final String resource = "mybatis-config.xml";
        SqlSessionFactory sql=new SqlSessionFactoryBuilder().build(Resources.getResourceAsStream(resource));
        SqlSession session=sql.openSession();
        //方法一
        User user=(User)session.selectOne("org.example.UserMapper.getUserById",1);
        System.out.println(user);
        session.close();
    }
}
class User{
    private Integer id;
    private String name;
    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + "]";
    }
    public Integer getId() {return id;}
    public void setId(Integer id) {this.id = id;}
    public String getName() {return name;}
    public void setName(String name) {this.name = name;}
}
```

```java
//方法2：添加一个接口，接口类名要与配置文件的mapper名一致，方法则要与配置文件的sql语句的id名一致
interface UserMapper{
    User getUserById(Integer id);
}

UserMapper userMapper=session.getMapper(UserMapper.class);
User user=userMapper.getUserById(1);
System.out.println(user);
session.close();
```

注意：也可以不通过xml配置文件构建`SqlSessionFactory`，仅需要添加一个映射器类，但高级映射仍需要xml配置文件。

# insert
`parameterType`表示参数的类全限定名或别名(参数类型)。

`useGeneratedKeys`表示获取数据库生成的自增主键。(仅适用于 insert 和 update)

`KeyProperty`表示回填的属性名。(仅适用于 insert 和 update)

`KeyColumn`表示获得指定的数据库列名，与`KeyProperty`搭配，可以用逗号分隔多个列名；如果数据库列名和 Java 属性名相同可以省略。(仅适用于 insert 和 update)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="org.example.user.UserMapper">
    <!-- 添加用户 -->
    <insert id="addUser" parameterType="org.example.user.User" useGeneratedKeys="true" keyProperty="id">
        insert into user(id,username) values (#{id},#{name});
    </insert>

</mapper>

```

```java
package org.example;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.*;
import org.example.user.*;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        final String resource = "mybatis-config.xml";
        SqlSessionFactory sql=new SqlSessionFactoryBuilder().build(Resources.getResourceAsStream(resource));
        SqlSession session=sql.openSession();
        //User user=(User)session.selectOne("org.example.UserMapper.getUserById",1);
        UserMapper userMapper=session.getMapper(UserMapper.class);

        User user=new User();
        user.setName("test1");
        int insert=userMapper.addUser(user);
        System.out.println(user);
        session.commit();
        session.close();
    }
}
```

# delete
```xml
<delete id="delUser" parameterType="int">
    delete from user where id=#{id}
</delete>

```

```java
int deleteuser = userMapper.delUser(1);
System.out.println(deleteuser);
session.commit();
session.close();
```

