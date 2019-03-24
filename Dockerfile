FROM swift:4.2
COPY . /DataDecoder
WORKDIR /DataDecoder
RUN swift build
