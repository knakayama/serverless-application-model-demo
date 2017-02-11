SERVICE =	sam-test
CD =	[ -d src/handlers/$(handler) ] && cd src/handlers/$(handler)
PARALLEL = 5

base:
	docker build . -t $(SERVICE)

build:
	$(CD) && { [ -f Dockerfile ] && docker build . -t $(SERVICE)/$(handler) || :; }

build-all:
	find src/handlers -type d -print -maxdepth 1 | cut -d/ -f 3 | xargs -P $(PARALLEL) -I % -n 1 make build handler=%

module:
	$(CD) && \
	if [ -f Dockerfile ]; then \
		docker run --rm -v `pwd`/vendored:/app/vendored -t $(SERVICE)/$(handler); \
	elif [ -f requirements.txt -a ! -f Dockerfile ]; then \
		pip install -r requirements.txt -t vendored; \
	else \
		:; \
	fi

module-all:
	find src/handlers -type d -print -maxdepth 1 | cut -d/ -f 3 | xargs -P $(PARALLEL) -I % -n 1 make module handler=%

package:
	@[ -d .sam ] || mkdir .sam
	@aws cloudformation package \
		--template-file sam.yml \
		--s3-bucket $(S3_BUCKET) \
		--s3-prefix sam/$(SERVICE)/$(env)/`date '+%Y%m%d'` \
		--output-template-file .sam/packaged.yml

deploy:
	@aws cloudformation deploy \
		--template-file .sam/packaged.yml \
		--stack-name $(SERVICE)-$(env) \
		--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
		--parameter-overrides `cat params/param.$(env).txt | tr '\n' ' ' | awk '{print}'`

clean:
	@aws cloudformation delete-stack \
		--stack-name $(SERVICE)-$(env)

all: build-all module-all package deploy

.PHONY: base build build-all module module-all package deploy all clean
