FROM elyra/kernel-image-puller:2.4.0

WORKDIR /usr/src/app

COPY kernel_image_puller.py ./
RUN pip install container-runtime-interface-api
RUN touch /tmp/ready
CMD [ "python", "kernel_image_puller.py" ]
