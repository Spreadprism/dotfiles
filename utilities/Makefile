all:
	@make can_activate

create_build_env:
	@if ! conda info --envs | grep -q python_builder_env; then conda create -n python_builder_env python=3.10 pyinstaller -y; fi

can_activate: create_build_env
	@echo "making can_activate"
	@conda run -n python_builder_env pyinstaller can_activate.py -F --distpath ../bin -n can_activate
	@rm -f can_activate.spec
	@rm -rf build

