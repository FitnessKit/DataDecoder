FROM swift:5.0
COPY . /DataDecoder
WORKDIR /DataDecoder
RUN swift build
