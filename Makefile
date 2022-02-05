# a_pinyin-apk 编译脚本
#
# 使用 make 是因为, 本应用需要以至少两种方式编译:
#
# + .github/workflows/ci.yml
#   这个是 github 的 CI
#
# + fdroid/org.fm_elpac.a_pinyin.ui.yml
#   这个是 F-Droid 的编译
#
# 由于本应用的编译比较复杂, 需要执行多条命令, 如果分开维护, 难以保证一致性.
# 因此将主要编译命令放在此处, 上述位置仅保留编译工具初始化/配置的命令.
#
# 本 Makefile 的使用方式主要有:
#
# + make
#   默认目标, 或者: make apk
#   用于开发者手动编译 apk, 以及 F-Droid 编译
#
# + make run
#   用于开发者调试运行 (flutter run)
#
# + make ci
#   用于 github CI, 含代码检查, 测试等

# 配置变量

# flutter 可执行命令位置
BIN_FLUTTER := flutter
# ktlint 可执行命令位置
BIN_KTLINT := ktlint
# cargo 可执行命令位置
BIN_CARGO := cargo

# 命令前缀
PREFIX :=


# [导出] 默认 make 目标, 仅编译 apk
# 用于开发者手动编译: make apk
.PHONY: apk
apk: setup rust build_apk

# [导出] 用于 github CI: make ci
.PHONY: ci
ci: first_test check apk

# [导出] 用于调试运行: make run
.PHONY: run
run: setup rust flutter_run

# 用于开发时跳过重复的 rust 编译 (no rust)
.PHONY: nr
nr: setup build_apk


# 下方是具体的编译命令

# DEBUG
.PHONY: first_test
first_test:
	echo ${PREFIX}
	${PREFIX} echo 666


# 正式 flutter 编译之前的准备过程
.PHONY: setup
setup: setup_assets

# apk 资源包含最新版 README.md
.PHONY: setup_assets
setup_assets:
	${PREFIX} cp README.md apk/assets/

# 编译本应用依赖的 rust 部分
.PHONY: rust
rust:
	echo TODO rust

# 编译 release apk
.PHONY: build_apk
build_apk:
	cd apk && ${PREFIX} ${BIN_FLUTTER} pub get
	cd apk && ${PREFIX} ${BIN_FLUTTER} build apk --split-per-abi
# TODO for F-Droid build apk
# flutter build apk --split-per-abi --release --verbose


# 源代码检查, 用于 CI
.PHONY: check
check: check_flutter check_ktlint

# 代码格式检查 (dart)
.PHONY: check_flutter
check_flutter:
	${PREFIX} ${BIN_FLUTTER} format --set-exit-if-changed --fix apk

# ktlint 用于检查 kotlin 代码
.PHONY: check_ktlint
check_ktlint:
	cd apk && ${PREFIX} ${BIN_KTLINT} --android

.PHONY: flutter_run
flutter_run:
	cd apk && ${BIN_FLUTTER} run
