.PHONY: encode decode display

encode:
	@python3 src/encode.py examples/dom$(word 2, $(MAKECMDGOALS)).txt dom$(word 2, $(MAKECMDGOALS)).lp

decode: encode
	@python3 src/decode.py src/yinyangKB.lp dom$(word 2, $(MAKECMDGOALS)).lp sol$(word 2, $(MAKECMDGOALS)).txt

display: encode
	@python3 src/display.py src/yinyangKB.lp dom$(word 2, $(MAKECMDGOALS)).lp src/drawyinyang.lp

test:
	@./scripts/test.sh

%:
	@:
