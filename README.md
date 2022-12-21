# dockerfileに特化した類似記述の検索

## 縛り
### コマンドの順序関係を考慮すべき
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

### 今回の研究では, Dockerfileの記述に慣れていないユーザをペルソナ?とする \

Dockerfile内のRUN命令には, コマンドをシーケンシャルに記述していく.
しかし, Docker特有の特徴(UFSなど)によって, 通常のコマンドと同様の使い方をした場合などにビルドのエラーやイメージサイズ(リソース)の無駄遣いなどが発生する. \
また, Dockerfileはおろか, bashにも慣れていないユーザがDockerfileを記述する可能性もあり, その場合1から記述することは少なく, 何かしらのDockerfileを参考にコピペなどを行い, そこから記述を進める可能性がある.
Dockerfileの記述に慣れているユーザや仕組みを理解しているユーザでない場合は, より多くのバグ(ベストプラクティス違反など)を発生させる可能性がある. 
(特に, 長期的に隠れているバグなどは極めて悪性が強い? 例えば?)

Dockerfile特有のバグ: RUN命令においてコマンドを複数利用する際に発生するバグ
1. 異なるベースイメージのDockerfileをコピーしてきた場合, ベースイメージの種類や振る舞いの違いによるバグを発生させてしまう可能性がある(ビルドの失敗) \
eg. パッケージのインストール忘れ[original:usePackagePrecedesAptInstall]
2. イメージサイズの無駄遣い(space wastage)
3. パッケージマネージャのupdate忘れ

Dockerfile特有のバグ(命名) \
@1: aptGetUpdatePrecedesInstall \
@2: DL3009:aptGetInstallRmAptLists \
(@3: DL3019:apkAddUseNoCache) \
@4: gpgVerifyAscRmAsc \
@5: original:usePackagePrecedesAptInstall \
@6: rmRecurisveAfterMktempD \
@7: tarSomethingRmTheSomething

