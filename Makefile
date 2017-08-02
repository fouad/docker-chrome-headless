VERSION	:= $(shell git describe --tags --always --dirty="-dev")
TAG     := "$(VERSION)"
NAME    := "fouadm/chrome-headless"

all:
	@docker build -t $(NAME):$(TAG) .
	@docker push $(NAME):$(TAG)
