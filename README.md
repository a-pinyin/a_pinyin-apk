# a_pinyin-apk
<https://github.com/fm-elpac/a_pinyin-apk>

[![build](https://github.com/fm-elpac/a_pinyin-apk/actions/workflows/ci.yml/badge.svg)](https://github.com/fm-elpac/a_pinyin-apk/actions)

A拼音: 开源拼音输入法 (Android 应用)

a_pinyin: Open source Chinese pinyin input method (Android)

+ 文档: <https://github.com/fm-elpac/a_pinyin>

+ 支持系统: Android 8.1+ (API 27)

+ 支持硬件: `arm64-v8a`, `armeabi-v7a`


## 下载安装

此部分说明一般适用于普通用户.

TODO 发布至 [F-Droid](https://f-droid.org/)

由于 app 不连网 (没有申请网络权限), 安装应用之后,
需要单独 [下载并导入](https://github.com/fm-elpac/a_pinyin-data) 内置数据库 (含有内置词典等),
才能正常使用拼音输入功能.

### 别的下载方式

从 [releases 页面](https://github.com/fm-elpac/a_pinyin-apk/releases) 下载发布版,
或者从 [github actions](https://github.com/fm-elpac/a_pinyin-apk/actions) 下载每次提交编译的版本 (可能更不稳定).

注意, 这些 apk 使用调试密钥 (debug key) 签名, 仅供试用.
正式使用建议自己创建密钥 [重新签名 apk](https://github.com/fm-elpac/a_pinyin-apk/blob/main/re-sign-apk.md).

> 说明:
> 如果万一丢失私钥, 则必须先卸载旧版 apk 才能安装另一个密钥签名的 apk.
>
> 为了避免数据丢失 (比如输入法学习数据/用户词典等),
> 请使用 用户数据库导出/导入 功能.


## 编译运行

此部分说明一般适用于开发者.

+ 使用 [flutter](https://flutter.dev/) / [dart](https://dart.dev/)

+ 运行调试版 (flutter run)

  ```sh
  flutter devices
  make run
  ```

+ 编译 apk (flutter build apk)

  ```sh
  make
  ```


## 友情链接

+ **FlorisBoard**
  <https://github.com/florisboard/florisboard>

  参考了其中的一部分设计和工作原理.


## LICENSE

```
a_pinyin: Open source Chinese pinyin input method
Copyright (C) 2022  sceext

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
