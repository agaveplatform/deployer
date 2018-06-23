#!/bin/bash
# Update settings to not check jwt and restart apache.

echo "" >> /code/agave_id/agave_id/deployment_settings.py
echo "CHECK_JWT = False" >> /code/agave_id/agave_id/deployment_settings.py
apachectl -k graceful
