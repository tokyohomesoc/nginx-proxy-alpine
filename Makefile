.SILENT :
.PHONY : nginx-proxy-alpine

nginx-proxy-alpine:
	docker build -t tokyohomesoc/nginx-proxy-alpine:test .
	docker images
    docker history tokyohomesoc/nginx-proxy-alpine:test