FROM php:7.2

# Install Jupyter
RUN apt-get update \
  && apt-get install -y python3-pip \
  && pip3 install jupyterlab

# Install Jupyter-PHP
RUN apt-get update \
  && apt-get install -y zlib1g-dev libzmq3-dev git \
  && docker-php-ext-install zip \
  && pecl install zmq-beta \
  && docker-php-ext-enable zmq \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && curl -sS -o /tmp/jupyter-php-installer.phar https://litipk.github.io/Jupyter-PHP-Installer/dist/jupyter-php-installer.phar \
  && php /tmp/jupyter-php-installer.phar install -v \
  && rm -f /tmp/jupyter-php-installer.phar

WORKDIR /notebooks

CMD ["jupyter", "lab", "--allow-root", "--ip=0.0.0.0", "--LabApp.token=''", "--notebook-dir=/notebooks"]
