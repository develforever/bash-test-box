FROM ubuntu:22.04

RUN apt-get update && apt-get install -y sudo nano wget curl strace

RUN useradd --password test --groups sudo tester
RUN printf "tester ALL=(ALL) NOPASSWD: ALL\n" | tee /etc/sudoers.d/tester

USER tester

WORKDIR /home/tester

RUN mkdir test_root
RUN mkdir -p test_root/scripts

RUN bash -c 'mkdir -p test_root/{bin,lib,lib64,usr}'

RUN sudo cp /bin/bash test_root/bin/

COPY --chown=tester:tester ./test.sh ./test_root/test.sh
COPY --chown=tester:tester ./init.sh init.sh

RUN bash init.sh

RUN sudo chroot /home/tester/test_root bash test.sh

CMD [ "test.sh" ]
ENTRYPOINT [ "/usr/bin/sudo", "/usr/sbin/chroot", "/home/tester/test_root", "bash" ]
