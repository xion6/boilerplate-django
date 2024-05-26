from .base import *

import os

ALLOWED_HOSTS = ["*"]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('POSTGRES_DB', 'testdb'),
        'USER': os.environ.get('POSTGRES_USER', 'postgres'),
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD', 'pass'),
        'HOST': 'host.docker.internal',
        'PORT': '5432',
        'ATOMIC_REQUESTS': True,
    }
}