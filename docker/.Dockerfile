FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
        software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
        git \
        curl \
        ffmpeg \
        python3.9 \
        python3.9-dev \
        python3.9-distutils \
        python3-pip \
        libglib2.0-0

# install VS Code (code-server) and essential extensions
RUN curl -fsSL https://code-server.dev/install.sh | sh
RUN code-server --install-extension ms-python.python \
                --install-extension ms-toolsai.jupyter

# Change default version of Python to 3.9
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 999 && \
    update-alternatives --config python3 && ln -s /usr/bin/python3 /usr/bin/python

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# ENV USE_FLASH_ATTENTION 1

# Install dependencies
RUN pip3 install ipykernel
# RUN pip3 install torch==2.3.1+cu118 torchaudio==2.3.1+cu118 --index-url https://download.pytorch.org/whl/cu118
# RUN pip3 install pydub
# RUN pip3 install build
# RUN pip3 install cmake
# RUN pip3 install ninja
# RUN pip3 install wheel
# RUN pip3 install flash-attn --no-build-isolation
# RUN pip3 install openai-whisper
# RUN pip3 install huggingface_hub==0.23.4
# RUN pip3 install transformers==4.42.3
# RUN pip3 install sentencepiece==0.2.0
# RUN pip3 install accelerate==0.31.0
# RUN pip3 install protobuf==5.27.2

# # Install TTS development package
# RUN git clone https://github.com/coqui-ai/TTS/ && \
#     cd TTS && \
#     pip3 install --ignore-installed -e .[all,dev,notebooks]

# # Install system dependencies for TTS on Ubuntu system
# RUN apt-get install -y libsndfile1-dev

# Set the working directory in the container
WORKDIR /home/voice-cloning-finetune

# Define environment variable
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1