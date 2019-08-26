FROM php:7.2

RUN apt-get update \
  && apt-get install -y zlib1g-dev libzmq3-dev python3-pip git \
  && docker-php-ext-install zip \
  && pip3 install jupyterlab

RUN pecl install zmq-beta \
  && docker-php-ext-enable zmq

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS -o jupyter-php-installer.phar https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.phar \
  && php jupyter-php-installer.phar install -v \
  && rm -r jupyter-php-installer.phar

WORKDIR /notebooks

CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0", "--LabApp.token=''", "--notebook-dir=/notebooks"]
