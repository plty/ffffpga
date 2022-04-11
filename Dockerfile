FROM continuumio/miniconda3

RUN apt-get update && apt-get install -y git wget cmake xz-utils --no-install-recommends

ENV INSTALL_DIR /opt/ffffpga

WORKDIR /root
ADD https://raw.githubusercontent.com/chipsalliance/f4pga-examples/main/xc7/requirements.txt .
ADD https://raw.githubusercontent.com/chipsalliance/f4pga-examples/main/xc7/environment.yml .
RUN conda env create -f environment.yml

RUN mkdir -p ${INSTALL_DIR}/xc7/install
RUN wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/20220404-212755/symbiflow-arch-defs-install-afbfe04.tar.xz | tar -xJC ${INSTALL_DIR}/xc7/install
RUN wget -qO- https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/20220404-212755/symbiflow-arch-defs-xc7z020_test-afbfe04.tar.xz | tar -xJC ${INSTALL_DIR}/xc7/install

COPY Makefile .

ENV PATH "${INSTALL_DIR}/xc7/install/bin:/opt/conda/envs/xc7/bin/:${PATH}"

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/bin/bash"]
