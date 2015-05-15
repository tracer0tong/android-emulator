ALIAS = "android"
EXISTS := $(shell docker ps -a -q -f name=$(ALIAS))
RUNNED := $(shell docker ps -q -f name=$(ALIAS))
IP := $(shell boot2docker ip)
ifneq "$(RUNNED)" ""
IP1 := $(shell docker inspect $(ALIAS) | grep "IPAddress" | cut -d '"' -f 4)
endif
STALE_IMAGES := $(shell docker images | grep "<none>" | awk '{print($$3)}')

.PHONY = run ports kill ps

all:
	@docker build -q -t tracer0tong/android-emulator\:latest .
	@docker images

run: clean
	@docker run -d -P --name android --log-driver=json-file tracer0tong/android-emulator

ports:
ifneq "$(RUNNED)" ""
	$(eval ADBPORT := $(shell docker port $(ALIAS) | grep '5555/tcp' | awk -F '\:' '{print($$2)}'))
	@echo "Use:\n adb kill-server\n adb connect $(IP):$(ADBPORT)"
        ifdef IP1
		@echo "or\n adb connect $(IP1):$(ADBPORT)\n"
        endif
else
	@echo "Run container"
endif

clean: kill
	@docker ps -a -q | xargs -n 1 -I {} docker rm -f {}
ifneq "$(STALE_IMAGES)" ""
	@docker rmi -f $(STALE_IMAGES)
endif

kill:
ifneq "$(RUNNED)" ""
	@docker kill $(ALIAS)
endif

ps:
	@docker ps -a -f name=$(ALIAS)
