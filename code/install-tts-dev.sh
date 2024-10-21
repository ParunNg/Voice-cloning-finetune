# Install TTS development package with added pythainlp dependency
git clone https://github.com/coqui-ai/TTS/ && \
    cd TTS && \
    echo -e "\npythainlp" >> requirements.txt && \
    pip3 install --upgrade --force-reinstall -e .[all,dev,notebooks]

# Add Thai text cleaners to TTS cleaners module 
cp -f /home/voice-cloning-finetune/utils/cleaners.py /home/voice-cloning-finetune/TTS/TTS/tts/utils/text/cleaners.py
cp -f /home/voice-cloning-finetune/utils/formatters.py /home/voice-cloning-finetune/TTS/TTS/tts/datasets/formatters.py

# Install system dependencies for TTS on Ubuntu system
apt-get install -y libsndfile1-dev