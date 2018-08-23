# 仿写知乎日报 iOS APP
## 编译环境:
Xcode 7.0以上  
iOS 9.0以上
## 第三方库
* AFNetworking
* Masonry
* JSONModel

## 运行效果
![effect](https://github.com/hshpy/HPYZhiHuDaily/blob/master/effect.gif)

## 部分实现过程  

### 首页

轮播视图里有一层渐变图层，当把CAGradientLayer的实例当做子图层加入的时，在我们下拉刷新时会触发景深效果会改变图层的bounds属性(动画属性)，动画效果造成与我们下拉时不一致，苹果只对子图层的动画属性改变自动会触发隐式动画；既然添加子图层没办法，那就往根图层想办法了，每个UIView的实例都一个CALayer的实例作为根图层，所以新建一个CoverView继承UIView重写下面方法，这样CoverView的实例的根图层就是CAGradientLayer了，改变bounds也不会触发隐式动画。  

	+ (Class)layerClass {
	    return [CAGradientLayer class];
	}
***

为了配合实现景深效果，UITableView加入了一个透明的tableHeaderView，这样导致了后面轮播视图的事件响应都失效了，hitTest视图都是tableview，所以给UITableview写个category添加了个disableTableHeaderView属性来判断是否响应tableviewHeaderView的事件。  

	- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	   if (self.disableTableHeaderView) {
	       CGRect frame = self.tableHeaderView.frame;
	       if (CGRectContainsPoint(frame, point)) {
	           return NO;
	       }
	   }
	   return YES;
	}
***

知乎接口给的图像大小是150*150，但是官方app的cell里的image并非正方形，同时cell里面的subview也不用响应事件，所以项目中直接使用UITableViewCell类，直接给cell.contentView.layer.contents赋值一张处理过后的CGImage，快速滑动时加载设置本地默认图的CGImage，等到停止滑动时启动异步线程获取屏幕可见cell的图片后更新cell.contentView.layer.contents的CGImage，快速滑动时接近60fps。

***

###日报内容

项目选择功能更加强大的WKWebView，知乎接口返回的内容是部分HtmlString，需要自己拼接成完整的HTML文档加载和加入Native端执行JS语句。
* 移动端页面缩放比例1.0，不允许用户缩放
```
<meta name='viewport' content='initial-scale=1.0,user-scalable=no' />
```
* 插入CSS
```
<link type='text/css' rel='stylesheet' href = 'http://news-at.zhihu.com/css/news_qa.auto.css?v=4b3e3' ></link>
``` 
* 把document中的img-place-holder元素设置为不显示
```
document.getElementsByClassName('img-place-holder')[0].style.display = 'none' 
```  
* 获取document高度后设置WKWebView的高度
```
document.body.scrollHeight
```
