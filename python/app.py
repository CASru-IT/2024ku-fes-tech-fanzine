import json
import re
import shutil
import subprocess
import tempfile
from pathlib import Path

base_dir = Path(
    f"{__file__}"
).parent.parent  # プロジェクトのルートディレクトリを設定。このファイルの2つ上の階層がプロジェクトルートとしている
article_dir = base_dir / Path("articles")  # 記事のディレクトリを設定
output_dir = base_dir / Path("output")  # 出力先のディレクトリを設定
output_dir.mkdir(parents=True, exist_ok=True)
manifest_file = article_dir / Path("manifest.json")

with open(manifest_file, mode="r", encoding="utf-8") as f:
    manifest_data = json.load(f)
    articles_data = manifest_data["articles"]
    header_file = Path(manifest_data["header"])
    images_dir = Path(manifest_data["imagesDir"])

with open(article_dir / header_file, mode="r", encoding="utf-8") as f:
    output_data = f.read()

shutil.copytree(article_dir / images_dir, output_dir / images_dir, dirs_exist_ok=True)

patterns = {
    r"#": "=",  # 見出し
    r"^\d+\.": "+",  # 順番付きリスト
    r"( +)\d+\.": r"\1 +",  # 順番付きリスト
    r"(?<!\*)\*(?!\*)": "_",  # 斜体
    r"\*\*": "*",  # 太字
    r"```(.*)([\s\S]*?)```": r"""#sourcecode[```\1\2```]""",  # コードブロック
    r"(?<!\!)\[(.*)\]\((.*)\)": r'#link("\2")[\1]',  # リンク
    r"!\[(.*)\]\((.*)\)": r'#figure(image("\2"),caption:[\1])',  # 画像
    r"~~(.*?)~~": r"#strike[\1]",  # 打ち消し線
    r"> (.*)": r"#quote[\1]",  # 引用
}

for article in reversed(articles_data):
    input_file = article_dir / Path(article["path"])
    with open(input_file, mode="r", encoding="utf-8") as f:
        markdown_text = f.read()

    for pattern, replacement in patterns.items():
        markdown_text = re.sub(pattern, replacement, markdown_text, flags=re.MULTILINE)

    output_data += (
        "\n"
        + f"""= {article["title"]}
{article["author"]}"""
        + markdown_text
    )

with tempfile.NamedTemporaryFile(
    mode="w", delete=False, dir=output_dir, encoding="utf-8"
) as output_file:
    output_file.write(output_data)
    output_file.flush()

    result = subprocess.run(
        ["typst", "c", str(output_file.name)],
        cwd=Path(output_file.name).parent,
        text=True,
        capture_output=True,
    )
    if result.stderr:
        raise Exception(result.stderr)
        exit(1)
    print(result.stdout)
