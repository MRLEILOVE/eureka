此项目为Spring-Cloud-Eureka服务注册发现`注册中心`示例代码

# SpringCloud学习教程
@[TOC]
### 学习路线架构图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190221105219746.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0ODQ1Mzk0,size_16,color_FFFFFF,t_70)

### 项目案例架构图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190314163851550.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0ODQ1Mzk0,size_16,color_FFFFFF,t_70)


# SpringCloud学习教程

## 一、Spring Cloud简介

Spring Cloud是一个基于Spring Boot实现的云应用开发工具，它为基于JVM的云应用开发中的配置管理、服务发现、断路器、智能路由、微代理、控制总线、全局锁、决策竞选、分布式会话和集群状态管理等操作提供了一种简单的开发方式。

Spring Cloud包含了多个子项目（针对分布式系统中涉及的多个不同开源产品），比如：Spring Cloud Config、Spring Cloud Netflix、Spring Cloud CloudFoundry、Spring Cloud AWS、Spring Cloud Security、Spring Cloud Commons、Spring Cloud Zookeeper、Spring Cloud CLI等项目。

这篇文章是主要讲服务注册与发现、服务通信、配置中心、服务网关、熔断这5个最基础的，其他的以后有时间再说，我们先可以读读这篇文章来大概了解一下这5个组件是什么：[SpringCloud分布式开发五大神兽](https://mp.weixin.qq.com/s/emveMUB3IBZn1hYI3gI7Fw)

## 二、服务的注册与发现（Eureka）

SpringCloud Eureka是SpringCloud Netflix服务套件中的一部分，它基于Netflix Eureka做了二次封装，主要负责完成微服务架构中的服务治理功能。

### 1、Spring Cloud Eureka的基础架构

- 服务注册中心：Eureka提供的服务端，提供服务注册于发现的功能，也就是在上一节中我们实现的eureka-server

- 服务提供者：提供服务的应用，可以是springBoot应用，也可以是其他技术平台且遵循Eureka通信机制的应用。它将自己提供的服务注册到Eureka，以供其他应用发现，也就是上一节中我们实现的HELLO-SERVICE应用。

- 服务消费者：消费者应用从服务注册中心获取服务列表，从而使消费者可以知道从何处调用其所需要的服务，在上一节使用了Ribbon来实现服务消费，另外后续还需介绍是哦那个Feign的消费方式。

很多时候客户端既是服务提供者也是服务消费者。

具体看：[Spring Cloud Eureka的基础架构](https://www.cnblogs.com/duan2/p/9274085.html)

上面《Spring Cloud Eureka的基础架构》文章中：“Eureka中有Region和Zone的概念”具体可看：[Springcloud中的region和zone的使用](https://www.cnblogs.com/junjiang3/p/9061867.html)

### 2、搭建服务注册中心

详见：[Spring Cloud构建微服务架构（一）服务注册与发现](http://blog.didispace.com/springcloud1/)

### 3、创建服务提供者

详见：[Spring Cloud构建微服务架构（一）服务注册与发现](http://blog.didispace.com/springcloud1/)

### 4、创建服务消费者

详见：[Spring Cloud构建微服务架构（二）服务消费者](http://blog.didispace.com/springcloud2/)

## 三、服务通信

这里主要讲两种常用的：RestTemplate、Feign(推荐使用)

详见：[springCloud 服务间的两种通信方式](https://blog.csdn.net/annotation_yang/article/details/80876913)

这里通信涉及到负载均衡，这里使用到的负载均衡是Ribbon， eureka是客户端负载均衡，默认使用的是轮询的方式（比如有两个服务端，请求方式就是1,2,1,2,1,2......有序的），其实，后面要讲的服务网关
也都有用到Ribbon作为负载均衡。

具体Ribbon见下面文章：

- [Spring Cloud 负载均衡器 Ribbon原理及实现](https://blog.csdn.net/justlpf/article/details/80354161 )
- [Spring Cloud中的负载均衡策略](https://blog.csdn.net/u012702547/article/details/77978845) 

## 四、 消息和异步

这里主要是讲解SpringCloud中的Stream的使用，Stream是在消息队列RabbitMQ和Kafka的上层进一步的封装，使得开发人员在使用消息队列时更加方便，而且还支持动态更换底层队列，意思就是使用Stream并不需要关心底层使用的是RabbitMQ还是Kafka，这有点类似于Hibernate的HQL的实现，我们并不用关心数据库是使用的MySQL还是SQLServer，而是由框架自动帮我们处理的。

这里我们使用RabbitMQ，不了解RabbitMQ的看这里：https://blog.csdn.net/qq_34845394/article/details/87856765

stream使用参考下面：

- [Stream 入门、主要概念与自定义消息发送与接收](http://www.cnblogs.com/hellxz/p/9396282.html)
- [SpringCloud-Stream整合RabbitMQ](https://zhixiang.org.cn/2018/12/07/每天学点SpringCloud（十三）：SpringCloud-Stream整合RabbitMQ/)
- [SpringCloud系列十一：SpringCloudStream（SpringCloudStream 简介、创建消息生产者、创建消息消费者、自定义消息通道、分组与持久化、设置 RoutingKey）](https://www.cnblogs.com/leeSmall/p/8900518.html)

源码：
- [springcloud-stream-provider:消息发送方](https://github.com/MRLEILOVE/springcloud-stream-provider.git)    
- [springcloud-stream-customer:消息接收方](https://github.com/MRLEILOVE/springcloud-stream-customer.git)

## 四、服务网关 （Zuul）

主要是处理路由：
路由在微服务架构的一个组成部分。 例如，/可以映射到您的Web应用程序，/ api / users映射到用户服务，并且/ api / shop映射到商店服务。 Zuul是Netflix的基于JVM的路由器和服务器端负载均衡器。

具体看：
[SpringCloud微服务实战-Zuul-APIGateway（十）](https://www.cnblogs.com/520playboy/p/7234218.html)

还有一个跨域的，很常用，上面博客没有讲到：
[spring-cloud-zuul跨域问题解决](https://blog.csdn.net/moshowgame/article/details/80507696)

案例代码：[springcloud-api-gateway-网关服务](https://github.com/MRLEILOVE/springcloud-api-gateway)

## 五、分布式配置（Spring Cloud Config）

主要看案例代码，注释很详细。

在使用bus时(这里是使用GitHub存放配置文件)，有一个坑，就是使用WebHook时一直报错400。
原因：集成WebHook后，GitHub在进行post请求的同时默认会在body加上一串载荷，我们的spring boot因为无法正常反序列化这串载荷而报了400错误。

解决办法：https://blog.csdn.net/L15810356216/article/details/85064838

## 六、熔断 （Hystrix）
- [Hystrix熔断框架介绍](https://segmentfault.com/a/1190000012338949)
- [Spring Cloud入门教程-Hystrix断路器实现容错和降级](https://segmentfault.com/a/1190000014730266)
- [Hystrix超时实现机制](https://segmentfault.com/a/1190000013882023)
- [Hystrix熔断器执行机制](https://segmentfault.com/a/1190000013900623)

## 七、服务监控（Spring Boot Admin）
Spring Boot Admin 用于管理和监控一个或多个Spring Boot程序，在 Spring Boot Actuator 的基础上提供简洁的可视化 WEB UI，

提供如下功能：

- 显示 name/id 和版本号
- 显示在线状态
- Logging 日志级别管理
- JMX beans 管理
- Threads 会话和线程管理
- Trace 应用请求跟踪
- 应用运行参数信息，如：
	 - Java 系统属性
	- Java 环境变量属性
	- 内存信息
	- Spring 环境属性

使用很简单，参考这个即可：https://www.cnblogs.com/cralor/p/9258979.html

效果图：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190425215120711.?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0ODQ1Mzk0,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190425215134777.?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0ODQ1Mzk0,size_16,color_FFFFFF,t_70)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190425215200903.?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM0ODQ1Mzk0,size_16,color_FFFFFF,t_70)

源码：[springcloud-admin-服务监控server端](https://github.com/MRLEILOVE/springcloud-admin.git)

这里说一下，我们的商品和订单实际上就可以看作是服务监控的客户端。

## 相关资料

- [* Spring Cloud微服务实战-SpringBoot2.X - 视频](链接: https://pan.baidu.com/s/1--hMJSvQimIrnafrudS6XQ 提取码: 533p)

案例代码：

- [springcloud-eureka-服务注册发现-注册中心](https://github.com/MRLEILOVE/springcloud-eureka.git)
- [springcloud-client-服务注册发现-客户端](https://github.com/MRLEILOVE/springcloud-client.git)
- [springcloud-commodity-商品服务端](https://github.com/MRLEILOVE/springcloud-commodity.git)
- [springcloud-commodity-parent-商品服务端(多模块版本)](https://github.com/MRLEILOVE/springcloud-commodity-parent.git)
- [springcloud-order-订单服务端](https://github.com/MRLEILOVE/springcloud-order.git)
- [springcloud-order-parent-订单服务端(多模块版本)](https://github.com/MRLEILOVE/springcloud-order-parent.git)
- [springcloud-config-统一配置中心服务端(管理各个模块的配置)](https://github.com/MRLEILOVE/springcloud-config.git)
- [springcloud-config-repository-此项目用来存放SpringCloud-config（统一配置中心）管理的配置文件](https://github.com/MRLEILOVE/springcloud-config-repository.git)
- [springcloud-stream-provider:消息发送方](https://github.com/MRLEILOVE/springcloud-stream-provider.git)    
- [springcloud-stream-customer:消息接收方](https://github.com/MRLEILOVE/springcloud-stream-customer.git)
- [springcloud-api-gateway-网关服务](https://github.com/MRLEILOVE/springcloud-api-gateway)
- [springcloud-user-用户服务端](https://github.com/MRLEILOVE/springcloud-user)
- [springcloud-admin-服务监控server端](https://github.com/MRLEILOVE/springcloud-admin.git)

上面的示例代码几乎是按照此视频编写的(减少了一些业务流程), 项目是一个关于商品和订单的，订单服务调用商品服务的接口（查询商品信息），然后进行订单、订单详情添加。




