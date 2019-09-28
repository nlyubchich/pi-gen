#!/bin/bash -e

on_chroot << EOF
ssh-import-id gh:${FIRST_USER_NAME} -o /home/${FIRST_USER_NAME}/.ssh/authorized_keys

chown ${FIRST_USER_NAME}:${FIRST_USER_NAME} -R /home/${FIRST_USER_NAME}/.ssh
chmod 700 /home/${FIRST_USER_NAME}/.ssh/
chmod 600 /home/${FIRST_USER_NAME}/.ssh/authorized_keys
EOF
