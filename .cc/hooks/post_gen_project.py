import yaml

def read_yaml_file(filename, load_all=False):
    with open(filename, mode='r') as f:
        if not load_all:
            yaml_data = yaml.load(f, Loader=yaml.FullLoader)
        else:
            # convert generator to list before returning
            yaml_data = list(yaml.load_all(f, Loader=yaml.FullLoader))
    return yaml_data

mkdocs_yml = read_yaml_file("/workspaces/one-click-se-demos/mkdocs.yml")

updated_nav = list()

for nav_group in mkdocs_yml['nav']:
    updated_nav_group = list()
    if '{{ cookiecutter.mkdocs_nav_group_full_name }}' in nav_group.keys():
      for demo in nav_group['{{ cookiecutter.mkdocs_nav_group_full_name }}']:
        if '{{ cookiecutter.mkdocs_nav_demo_full_name }}' in demo.keys():
            updated_nav_group.append({
                '{{ cookiecutter.mkdocs_nav_demo_full_name }}': '{{ cookiecutter.mkdocs_nav_group_short_name }}/{{ cookiecutter.demo_name }}.md'
            })
        else:
            updated_nav_group.append(demo)
    else:
        updated_nav.append(nav_group)
