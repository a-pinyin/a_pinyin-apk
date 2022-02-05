# 重新签名 apk 文件的说明


## apk 签名简介

+ [官方文档](https://source.android.com/security/apksigning/) ([中文镜像](https://source.android.google.cn/security/apksigning/))

Android 系统要求, 应用 (apk 文件) 必须经过数字签名, 才能安装.

> 数字签名简介:
>
> 签名使用非对称加密算法 (比如 RSA), 也就是有公钥和私钥,
> 公钥和私钥是一一对应关系.
>
> 密钥对由签名者随机生成, 其中私钥严格保密, 只有签名者持有.
> 公钥可以公开, 被写入 apk 文件作为签名的一部分.
>
> 因为别人没有私钥, 所以可以保证只有签名者能生成对应公钥的签名,
> 也就是别人无法伪造签名.
> 但是, 如果万一私钥泄漏, 那么拿到私钥的人也能生成对应签名,
> 签名机制就失去了安全性.

apk 签名主要有以下作用:

1. 应用升级:

   当安装一个应用的新本版时,
   新的 apk 文件必须与已经安装的应用使用相同的密钥签名,
   否则系统会拒绝安装.

   这个机制保证了, 在正常情况下, 升级安装的新版本 apk,
   和之前安装的 apk, 来自同一个签名者.

   如果非要安装不同签名的 apk, 不能直接升级 (覆盖) 安装,
   必须把已经安装的应用卸载, 才能安装另一个签名的 apk.

   这个机制的意义主要是避免安装第三方制作 (冒充) 的恶意 apk.

   注意: 卸载应用会同时删除应用的数据, 可能造成数据丢失.

2. 应用隔离:

   属于 Android 安全沙箱的一部分.

   使用不同密钥签名的应用被严格隔离开, 不能访问别的应用的私有数据.

   但是使用相同密钥签名的应用, 可以访问对方的私有数据.


## 为什么要重新签名 apk

本应用使用的开源软件许可证 (`GPLv3`) 表示, 开发者不提供任何担保 (详见 `LICENSE`).
用户应该为使用本应用的行为负责, 并承担一切后果, 这也是开源的权利和责任.

从 github 页面下载的本应用的 apk 文件, 使用调试密钥 (debug key) 签名.
这个密钥的私钥被上传并保存在 github 的服务器中.

然而, github 和本应用的开发者都不是完全靠谱的.
如果万一发生了私钥泄漏, 用户就可能有在不知不觉之间,
升级了本应用的 "新版本" (实际上是第三方制作的恶意软件),
从而安装了恶意软件的风险.

根据用户应该为自己负责的原则, 如果用户在安装 apk 之前, 需要对 apk 重新签名,
那么此时就可以验证 apk 来源并检查 apk 内容,
而不会不知不觉中招.

所以用上述调试密钥签名的 apk 文件, 仅供试用.
建议用户正式使用之前, 自己生成密钥对 apk 文件重新签名.

退一步讲, 虽然用户也存在私钥泄漏的风险, 但是这个泄漏只影响这个用户一人.
而如果 github 或开发者私钥泄漏, 会影响本应用的所有用户.
相比之下, 还是重新签名的总体风险更小.

+ 参考文章: [You Should Be In Control of Your Tech](https://puri.sm/posts/you-should-be-in-control-of-your-tech/)


## 重新签名 apk 的方法

具体方法有很多, 此处仅推荐几种感觉比较好的方法.

标记为 `[PC]` 的需要在笔记本/台式计算机上操作,
标记为 `[手机]` 的在普通 Android 手机上即可操作.

标记为 `[termux]` 的,
需要先在手机上 [安装 Termux](https://f-droid.org/en/packages/com.termux/),
然后用命令行 (`CLI`) 方式操作.

### `[手机]` Apk Signer for Android

<https://apkpure.com/apk-signer/com.haibison.apksigner>

优点: 图形界面操作无需命令行, 可直接在手机上进行.

缺点: 可能无法下载该应用.

### `[手机][termux][CLI]` apksigner

这个是 Android SDK 的官方签名工具.

[官方文档](https://developer.android.com/studio/command-line/apksigner) ([中文镜像](https://developer.android.google.cn/studio/command-line/apksigner))

安装 (termux):

```sh
pkg install apksigner
```

签名栗子:

```sh
apksigner sign --ks release.jks app.apk
```

生成密钥的方法:

+ [Android: Generate Release/Debug Keystores](https://coderwall.com/p/r09hoq/android-generate-release-debug-keystores)

栗子:

```sh
keytool -genkey -v -keystore debug.keystore -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000
```

TODO

### `[手机][termux][CLI][python]` apk-signer

<https://pypi.org/project/apk-signer/>

栗子:

```sh
pip install apk-signer
apk-signer sample.apk --key_path="sample.jks" --key_alias="sample" --key_pass="sample_key" --ks_pass="sample_ks"
```

### `[PC][CLI]` Uber Apk Signer

<https://github.com/patrickfav/uber-apk-signer>

栗子:

```sh
java -jar uber-apk-signer.jar -a /path/to/apks --ks /path/release.jks --ksAlias my_alias
```
