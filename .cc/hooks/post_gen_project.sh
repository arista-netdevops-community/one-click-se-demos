#!/usr/bin/env bash

cp -r ./ ../
rm -rf /workspaces/one-click-se-demos/{{ cookiecutter.demo_name }}

# print additional instructions
echo "The required files for {{ cookiecutter.demo_name }} were generated."
echo "Please review them before committing."
echo ""
echo "If you are creating a new demo, please do not forget to reference it in the 'nav' section of 'mkdocs.yml'"
echo ""
echo "Example:"
echo ""
echo "nav:"
echo "  - My Awesome Demos:"
echo "      - The Best Demo Ever: awesome-demos/demo-name.md"
