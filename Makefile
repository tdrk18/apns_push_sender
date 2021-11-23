IMAGE_NAME := tdrk18/apns_push_sender

build:
	docker build -t ${IMAGE_NAME} .

clean:
	docker rmi ${IMAGE_NAME}

pull:
	docker pull ghcr.io/${IMAGE_NAME}:latest

run: build
	@if [ -z ${DEVICE_TOKEN} ]; then \
		echo "set DEVICE_TOKEN, please"; \
		exit 1; \
	elif [ -z ${BUNDLE_ID} ]; then \
		echo "set BUNDLE_ID, please"; \
		exit 1; \
	elif [ -z ${PEM_PATH} ]; then \
		echo "set PEM_PATH, please"; \
		exit 1; \
	fi
	docker run --rm \
		-v ${PEM_PATH}:/var/tmp/keys/certificate-and-privatekey.pem:ro \
		${IMAGE_NAME} \
		sh /var/tmp/send_push.sh \
		--token=${DEVICE_TOKEN} \
		--bundleID=${BUNDLE_ID}
