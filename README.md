# retain_builtin_flash
 一键恢复 Windows 10 内置 Flash。绿色，快速，安全。免 Windows Update 删除。
 
 ![yX75vV.png](https://s3.ax1x.com/2021/02/24/yX75vV.png)
 
 到 [Release](https://github.com/pokon548/retain_builtin_flash/releases) 下载最新版。
 
## 它能做什么？
- 恢复 Windows 10 现已被 [KB4577586](https://support.microsoft.com/zh-cn/topic/kb4577586-%E7%94%A8%E4%BA%8E%E5%88%A0%E9%99%A4-adobe-flash-player-%E7%9A%84%E6%9B%B4%E6%96%B0-2020-%E5%B9%B4-10-%E6%9C%88-27-%E6%97%A5-931521b9-075a-ce54-b9af-ff3d5da047d5) 删除的自带的 Flash。
- 删除正常情况下删不掉的 KB4577586 补丁。
- 阻止 Windows Update 后续推送 KB4577586（避免恢复后再被删除）。

## 它不能做什么？
- 移除 Flash 自带的时间炸弹（很不幸，自带版本也会受到影响 :(）。请移步[这里](https://github.com/KuromeSan/FlashPatcher/)查看解决方案。

## 支持的操作系统
Windows 10 32 或 64 位的系统。目前只在 20H2 上测试通过，其它版本未测试，但也许也能用。
Windows 8.1 全系及 Server 等不在支持范围内。

## Q&A
### Flash 版本是？
32.0.0.445

### 为什么程序在阻止补丁阶段用了很长时间？
受制于程序限制，在使用相关技术阻止（隐藏）相应 Windows Update 时，需要向微软服务器请求响应补丁信息。
如果网络质量不佳，可能会导致相应长时间等待。请参见 Q&A 第三条。

### 看起来这个程序不是完全开源的... 有毒嘛？
Release 里的 exe 实际就是个压缩包。你大可采用你喜欢的解压缩软件对其解压，并进行审查。

程序主体使用 ```bat``` 和 ```powershell``` 编写。内含的二进制文件也都是方便起见直接抓取到内部的。如果不放心，你可以到微软的[补丁网站](https://www.catalog.update.microsoft.com/Search.aspx?q=Adobe+Flash)下载到那些文件。

### 怎么做到让 Windows Update 收不到 KB4577586？
原理是将对应的 Update 加上 Hide 的属性。你可以在[这里](https://support.microsoft.com/zh-cn/topic/%E5%A6%82%E4%BD%95%E6%9A%82%E6%97%B6%E9%98%BB%E6%AD%A2%E9%A9%B1%E5%8A%A8%E7%A8%8B%E5%BA%8F%E6%9B%B4%E6%96%B0%E5%9C%A8-windows-10-%E4%B8%AD%E9%87%8D%E6%96%B0%E5%AE%89%E8%A3%85-17df0ef3-7480-36e9-0ed9-118351398897)获得更多技术细节。
我们采用的实际方案来自于[这里](https://stackoverflow.com/questions/43598200/how-to-hide-windows-7-updates-in-batch-based-on-kb-number/44573333)。

### 看起来挺丑的...
嘛，确实。我没有很多精力写 UI，因此只有最简单的命令行界面。敬请谅解。
但功能是完善的。

水平有限，写的不好，还请在 [Issue](https://github.com/pokon548/retain_builtin_flash/issues) 区留下你的看法。感谢 :)

Microsoft 及 Windows 是 Microsoft Corporation 的注册商标。

## 另请参考
[Ruffle](https://ruffle.rs/) 项目。一个用 WebAssembly 编写的 Flash 替代品。
