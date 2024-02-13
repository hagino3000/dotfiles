# readlines
with open('japanese.txt', 'r', 'utf-8') as f:
    for line in f:
        print(f)


import textwrap
from string import Template

def compose_msg_with_template(title: str, abstract: str) -> str:
    # JSON文字列を含めたいときはf-stringが使えない
    template_base = """
    This is article

    Title: ${title}

    Abstract: ${abstract}
    """
    template = Template(textwrap.dedent(template_base))
    return template.substitute(
        title=title, abstract=abstract, disease_name=disease_name
    )


def load_data_onmemory():
    INLINE_DATA = \"""
    abc,def,ghi
    abc,def,ghi
    """

    from io import StringIO

    f = StringIO(INPUTS)
    for line in f:
        print(line.strip())
