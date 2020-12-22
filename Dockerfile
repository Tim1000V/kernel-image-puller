FROM elyra/kernel-image-puller:2.0.0
COPY kernel_image_puller.py /usr/src/app/kernel_image_puller.py
CMD pip install container-runtime-interface-api
