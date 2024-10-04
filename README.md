# 2024ku-fes-tech-fanzine

2024年金大祭CASる通信投稿技術同人誌

## 使い方

1. `git clone <https://github.com/CASru-IT/2024ku-fes-tech-fanzine.git`
2. `cd 2024ku-fes-tech-fanzine`
3. `articles/`ディレクトリにマークダウンファイルを配置
4. `images/`ディレクトリに画像ファイルを配置
5. `manifest.json`を編集
6. `python/app.py`を実行
7. `output/output.pdf`が生成される

## manifest.json

復数のマークダウンファイルを1つのTypstファイルに変換するファイルを纏めたファイル。`article/`ディレクトリ以下に配置しないと動作しない。

ファイル内のパスは`manifest.json`が存在するディレクトリを基準とする。

```json
{
  "header":"./header.typ",//ヘッダーファイル
  "imagesDir":"./images",//画像ディレクトリ
  "articles":[//記事リスト
    {
      "title":"title",//記事タイトル
      "author":"author",//著者
      "path":"./content.typ"//ファイルパス
    }
  ]
}
```

記事は`articles/`ディレクトリ以下に配置する。画像は`images/`ディレクトリ以下に配置する。

## 対応文法

よく使うものはひととおり対応している。抜けがあったら教えてください。正規表現ベタ打ちしたので、正規表現以上のものを実装するのは難しいです。

- 見出し
- 箇条書き
- 番号付きリスト
- リンク
- 画像
- コードブロック
- 引用
- 太字
- 斜体
- 取り消し線
- インラインコード
