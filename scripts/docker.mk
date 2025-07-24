EXEC_FG_OPTS := -it
EXEC_BG_OPTS := -d
RUN_BG_OPTS  := -itd

include scripts/docker/net.mk
include scripts/docker/port.mk
include scripts/docker/vol.mk
include scripts/docker/hosts.mk
include scripts/docker/cap.mk

run:
	docker run $(RUN_BG_OPTS) $(RUN_OPTS) --name $(NAME) $(IMAGE):$(TAG)

start:
	docker start $(NAME)

stop:
	docker stop $(NAME)

rm:
	docker rm $(NAME)

exec:
	docker exec $(EXEC_FG_OPTS) --user $(USER) $(NAME) $(SH)
