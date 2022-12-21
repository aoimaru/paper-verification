# dockerfileに特化した類似記述の検索

## 縛り
### ~~コマンドの順序関係を考慮すべき~~
下のパターンは誤解を与える？
自分の手法は, 順序の入れ替わりには弱い. 単純な編集距離を利用しているため?
```bash
1: RUN ... & \
2:     wget -o [obj.tar.xz] [URL] && \
3:     echo "*** obj.tar.xz" | sha256sum -c && \
4:     mkdir -p [dir/obj] && \
5:     tar -xJf [obj.tar.xz] -c [dir/obj] && \
6:     rm [obj.tar.xz]
7:     cd [dir/obj] && \
8:     ...
```
ここの4行目と5行目が入れ替わってしまうとビルドに失敗する
```bash
1: RUN ... & \
2:     wget -o [obj.tar.xz] [URL] && \
3:     echo "*** obj.tar.xz" | sha256sum -c && \
4:     tar -xJf [obj.tar.xz] -c [dir/obj] &&   <--- bug
5:     mkdir -p [dir/obj] && \
6:     rm [obj.tar.xz]
7:     cd [dir/obj] && \
8:     ...
```
つまりは, コマンドの順序関係には多少なりとも, 意味が存在するのでは? \
NCD(正規圧縮距離)単体だと, 順序までは考慮できない 

### □ ~~今回の研究では, Dockerfileの記述に慣れていないユーザをペルソナ?とする~~ 
### □ ペルソナ
+ ユーザは, 全てのコマンドに精通している訳ではなく, 多少は不慣れなコマンドが存在する 
+ Dockerfileの記述に慣れているユーザや仕組みを理解しているユーザでない場合は, より多くのバグ(ベストプラクティス違反など)を発生させる可能性がある.

Dockerfile内のRUN命令には, コマンドをシーケンシャルに記述していく.
しかし, Docker特有の特徴(UFSなど)によって, 通常のコマンドと同様の使い方をした場合などにビルドのエラーやイメージサイズ(リソース)の無駄遣いなどが発生する. \
~~また, Dockerfileはおろか, bashにも慣れていないユーザがDockerfileを記述する可能性もあり, その場合1から記述することは少なく, 何かしらのDockerfileを参考にコピペなどを行い, そこから記述を進める可能性がある.~~ \
ユーザはコマンド全てに精通している訳ではないので...
Dockerfileの記述に慣れているユーザや仕組みを理解しているユーザでない場合は, より多くのバグ(ベストプラクティス違反など)を発生させる可能性がある. \
(特に, 長期的に隠れているバグなどは極めて悪性が強い? 例えば?) \
完全に削除されたパッケージをインストールしてしまう(脆弱性の観点から)可能性もある \
使用されていないキーも


Dockerfile特有のバグ: RUN命令においてコマンドを複数利用する際に発生するバグ
1. ~~異なるベースイメージのDockerfileをコピーしてきた場合, ベースイメージの種類や振る舞いの違いによるバグを発生させてしまう可能性がある(ビルドの失敗)~~\
~~eg. パッケージのインストール忘れ[original:usePackagePrecedesAptInstall]~~
2. イメージサイズの無駄遣い(space wastage)
3. パッケージマネージャのupdate忘れ

Dockerfile特有のバグ(命名) \
@1: aptGetUpdatePrecedesInstall \
@2: DL3009:aptGetInstallRmAptLists \
(@3: DL3019:apkAddUseNoCache) \
@4: gpgVerifyAscRmAsc \
~~@5: original:usePackagePrecedesAptInstall~~\
@6: rmRecurisveAfterMktempD \
@7: tarSomethingRmTheSomething


## コンパイルチェッカーなのか, スタイルチェッカーなのか
後者を実装, コンパイルチェッカーは, Dockerでのビルドログで十分? もちろんいらない訳ではない
ビルドに成功する場合のアンチパターンは厄介. Hadolintで対応していればリントで対応出来るが, Hadolintに対応していないアンチパターンの場合は対応できない

例えば, コンパイルチェックする前に検索を行えば, ビルドエラーを防ぐことが出来る?


## Levenshtein Distanceの採用
そこで今回の研究では, Levenshtein Distanceを採用 
* ~~採用理由~~
* Levenshtein Distanceを使うメリット
1. Levenshtein Distanceは, [insert, delete, replace]の3つの処理で, ある文字をある文字に編集する回数で類似度を測る. ここでの文字を１つのコマンド(ex. tar -xJf [obj.tar.xz] -c [dir/obj] など)に置き換えた時, Dockerfileでコマンドの順序関係を考慮した類似度(編集の回数)を測ることができると考えたため. 
2. 今回の研究のペルソナをDockerfileの記述に慣れていないユーザの記述に対する(誤り検知?)の支援と考えた時, 出来るだけ, 誤った記述に似ている正しい記述を提示する方が有用であると考えた時, Levenshtein Distanceを利用すれば, コマンドの順序関係を考慮しつつ類似している(編集回数の少ない)正しい記述を取得できると考えたため. <-[コマンドの順序関係を考慮している点も新規性. 既存の研究では, 単語単位での提示などは行っているがコマンド単位では行っていない]
3. 既存の検索手法(キー検索)などでは, 条件に一致するものを全て取得してしまう+キーを事前に作成しなければならないが, これでは順序関係を考慮できない+(仮...)サイズの大きいDockerfileを検出してしまう可能性あり(慣れていないユーザはどの部分を優先的に見ればいいか分からない)
4. 順序の入れ替わりも検知できる. キー検索ベースだと無理(無理ではないが, 組み合わせを利用する必要がある(無数...))
5. NCD(正規圧縮距離)では, コマンドの順序までは考慮できない...はず -> テストする必要あり \
例えば, [A, B, C, D, E, F]に対して, [A, B, C, D]と[A, C, B, D]と[D, A, C, B]と[C, A, J, K]と[J, K, L, M]でテスト \ コマンドの順序も考慮しているのならば差が出るはず


## Levenshtein Distanceの適用
今回の研究では, コマンド単位でLevenshtein Distanceを適用した. 

## ダミーノードの追加

## 評価手法
今回の研究では, (定量的な評価を行わない..訳でない)基本的には定性的な評価を行う. \
Dockerfile特有のバグ \
@1: aptGetUpdatePrecedesInstall \
@2: DL3009:aptGetInstallRmAptLists \
@3: (DL3019:apkAddUseNoCache) \
@4: gpgVerifyAscRmAsc \
~~@5: original:usePackagePrecedesAptInstall~~  <- build前に実行すれば有用? \
@6: rmRecurisveAfterMktempD \
@7: tarSomethingRmTheSomething \
これらのバグを含んだDockerfileをクエリに検索を時に, 類似している(正解である可能性の高い)Dockerfileが検出出来るが, そのDockerfileを参照・参考にしたときにバグを修正することができれば, 参考になったと判断する. \
(仮)類似しているダミーのDockerfileより類似していると判断されたもの, もしくは類似度が近いものを対象とする
* 評価メトリクス
1. バグを修正できたかどうか
2. 提示できたDockerfileのサイズ



## 結論
### 検出可能